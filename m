Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745FDC2BA18
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 17:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8D910E0C8;
	Tue, 18 Jun 2024 17:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g+2HFwn1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F55710E75A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 17:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFo7FIGJtrpPpYfwcnHUxB7kICr3gb0dJsBPMLec7WULZEBGMbxRiZTs5ld+F44rvSlFyMi3MvzGgjRcisnGmaFETWau9ifyib8CQx2WSzQHzB55cuFM4JR5QVMhTiTTrtwpEoVseTZpqZEY0IvLk6JmKHRENoDdJRoob6ZlXAXJb4a5tAP/RHJrbE8WL4oAlEp0d5SN40RGGc8hoITCD9XNQT0vCSCiJevdmlz7kWRqTW2FLFDA7gyPG+JDBW9vVhUgTDtZiq84PR5H+se8IIaap0taRlsPvd9t1bNThxhQw9jdjtEPwMtqu+XjzpNG5pj8j1xiefTzGR9Wy+7Fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7eU/G72qlT4Bl2GzZmjUnPNofW3klr4NTeILJZYvyE=;
 b=C/GyWdNgFYTShGDFyjc4TFzrUIQxUa77DENRBSN+itY6gLvE7vspdejIyWncvYVdbmjuULB0dHk8te8bNtwTvkhRYSBn1qY33Wj+luZqAsyc/EYos3viwbEojWOj32vh63CY13Lh5Xw51X8NLFrQLKVYOurUJOQm/8BF5hkaif5vK97eAWMUUVPbKZBr1aQD2URJT5pRY5nVGgcdqYLSLvdWPh9rAXd+NCastc8NCcPf3gw3Gu5n+LeMEFSfs/fv1XnzE/STLjkurgDrEqMpsmOFeANMkzf6aHasLvLyMRebtVBVwgcQQ637+5XAcvzl9t5Fv6ImKqb+aNJhUxgRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7eU/G72qlT4Bl2GzZmjUnPNofW3klr4NTeILJZYvyE=;
 b=g+2HFwn1793Sf81S42mJmfwAX07G8AnpBmxS2uOnTFa6bS8/qx0XCKZO3R/9KqbNXMi4uaAWM8+V8fQ+fW+XqQ3AHbSq5v22H3FtJvIvfZXzr4Vf6FmCMg+zSJg3mjSM1/ZjhZ0wNhHzS/ij99R8343/CJuSKfxmxTD26MavXzk=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 17:27:18 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::a585:5723:a993:b9c0]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::a585:5723:a993:b9c0%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:27:18 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Chander, Vignesh" <Vignesh.Chander@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Use dev_ prints for virtualization as it
 supports multi adapter
Thread-Topic: [PATCH 1/2] drm/amdgpu: Use dev_ prints for virtualization as it
 supports multi adapter
Thread-Index: AQHawMZWbPpUJALMX02OkiKzX4TyvbHNx+Eg
Date: Tue, 18 Jun 2024 17:27:18 +0000
Message-ID: <DM4PR12MB532877762F5B62696C4C5F0CF1CE2@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240617145446.593279-1-Vignesh.Chander@amd.com>
In-Reply-To: <20240617145446.593279-1-Vignesh.Chander@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ba895ea9-d7e6-4485-916c-d15a6ff6da39;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T17:26:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|IA0PR12MB8840:EE_
x-ms-office365-filtering-correlation-id: d2752022-c8cd-4233-e21b-08dc8fbbe761
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?kkPSq4Qi+Ycs4LHK5UEwi4ZX9i0XofNTdAHroz3FWhWknJ+8iKYmRuidLI5w?=
 =?us-ascii?Q?2bSbcuJhobWK1kMRhgk3AXhkFEHluq+YA2O5p4I8tqtewf45UMgvolGuSFyM?=
 =?us-ascii?Q?NZSHWaSIxtpgzb3JCbu7pB5m12SWJfDEGNWyfEmaGDpAv/kQiDG/po4yBR11?=
 =?us-ascii?Q?QIRlO+rr2kbVJZ8rM25ITmx1cpKiAgt7DPddsnmf/4Yo7rA6p6qcGs5QvaF0?=
 =?us-ascii?Q?sP/CS0yZxNOI56AA739pn9xcknFl4UZYRRc3vlkF2rDQHi7q51crC/9LEnFm?=
 =?us-ascii?Q?sNMBo0BHMlErpDOPNUwkTQGvr31cpJ8tYYg+NyueNcMBWTaAmGv0i7LMAktF?=
 =?us-ascii?Q?Tk0b+tro20J+SU+GmEe++zka4+ehIYJl6L/CjoV/JG+lTz+wRmz/OX/p0mO6?=
 =?us-ascii?Q?1jULtmEzXl35oOuNUqqRhbB3UY6NA6/v54t0X+igpfRI8Je44+7x8GUC1h1l?=
 =?us-ascii?Q?XaHPLPlmn/BXh2p0SQrPmDUUi413u1huDs+dK/17zItn715Dps5IKYo7ZA/d?=
 =?us-ascii?Q?fCXOLfYxF5SbujLW21NTAqcf4rXiovFp95iKE9n9GRHusAhB60nXp+OqAhEv?=
 =?us-ascii?Q?VsEuYbQ1yDqLl1QJGkdoEgcFtb+55WJrK+AN5mgtFuJ4Y1wYjvXbOiuzy+ha?=
 =?us-ascii?Q?j4oMlM+ryEndBGA2VzH+Kn/Hrd8ePtL3Buqz/nTo0UCfatXbnzwb+xQAmzXW?=
 =?us-ascii?Q?ouZjBzBOjBMMzPvmVLWE04M+/X34DUFvNZ3aY8JP3iLDwSs1MYeu9wyV1epm?=
 =?us-ascii?Q?oK2gXYqxsDODB3Cyerqiog2iFUu78pQmW9dztF5kbffzjCQXKABHk0U2iG09?=
 =?us-ascii?Q?JCcImjxlN+6x0EaCSL31hawZeuF0IZQ76uIorqiwYp2gqhKgWPK9CDIOeCwy?=
 =?us-ascii?Q?XgUG9lcYa1pb6cRPfDnuqIbDxw5I/iB+hiRhxcsHpYa4T8dlh79qgJADf7vD?=
 =?us-ascii?Q?J8ee4SUIQ4hjIh2r8tZ+CUa0rwHte8bL+U6GZO2IhGEdRpMwbBu+xEXpKIof?=
 =?us-ascii?Q?qebvcz0kk0lch7NlNtBSvaEvOo7YJi+KJjr1tp17G5MImZYJgVPrgkUElZQS?=
 =?us-ascii?Q?4kLIuQM3Ob1st/DpbM11UvPElvqwGB4L++u3z+1+EQIdiDtGVxCWRI+m5MG/?=
 =?us-ascii?Q?Uqs+ex3D6deA0rvDsk58DMYK5J1xxDJT0y/9XKGRB43lgDmRSfdJ4DcgSu/M?=
 =?us-ascii?Q?z9m3Kzp6lgDVoAMRbECfF/1+8ti1G1KxbLhKXI4X/j+uwIREHvoeIq6WsNnr?=
 =?us-ascii?Q?eazJmdSNNhW9fYZAt+fst0ubPBx8q0DAJnzBOYc2e22cKRZ9xM/LMwOEEgrd?=
 =?us-ascii?Q?fz9YlpvvFmnP2uL/vYg3171c8P4FdrAgNorp33lE9/p0FQgrKNxFBE+GPCkE?=
 =?us-ascii?Q?EnAnZKY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xaQUtAstz5IHekqEMF/so2DfIMm2EcN+CFSVeyDdJ0ZGLo3dfiRfTGmVImwG?=
 =?us-ascii?Q?3TQGbEiTVwml+4MeI3O1dsLdaONGiXmr0KuF6W/Pf6dElJxzMo3+tMHlzD78?=
 =?us-ascii?Q?uQ/6/lSJxfVqV+cAXwXyG7jAuhIo5Zwes9itRI3A6plwkia156fOGoYLgS5u?=
 =?us-ascii?Q?h/B7kI3Yy1v0B29JJQVsMqyL1/ovrOw+P+4FSIubOujXspw+T3fa8GhplWjU?=
 =?us-ascii?Q?exFee1Fxakr8l1W10Gzi7EXai9OIkJhcC7dnhyrvSsJ57z2i9SQsiBMQUM/g?=
 =?us-ascii?Q?HSE8T+yRVjmbPR8KjfZIq5fKUulhmLCs+CgGjZ4yIZGMd8u+xIs0pym7l2Vc?=
 =?us-ascii?Q?4cg58A/v23huuESB0CY9y//vede3WExVHiVNOgVn8HAwg7LNgXKBKQxnFgCp?=
 =?us-ascii?Q?Ce2oODE8bHJogjvKkBLySYv9UWM0UdoZTRnJWOPWxytu32RnvVEzAQbDXNXe?=
 =?us-ascii?Q?siwBPgrvJlYOj0kFv8Q3C6hW6Z1OazA9lj0iSAqcPOYy6GoVh8gVQPP3v38Y?=
 =?us-ascii?Q?lgHozlFljaVxtMfPwUr2T68QWNvuxm3NsmWTnErm721D8+TYwJFUMnya5Mjt?=
 =?us-ascii?Q?iAlsETyRQkNb0pEDp0KtkivzuMxWVMJu1s/Hw95KGIP7GPPC+j38Oo+sghV4?=
 =?us-ascii?Q?PJIBk/xGCypLrbEoDzbr0HEWE06/FFem2XGIl91J84e+amEhL3oVY7ElDXA4?=
 =?us-ascii?Q?EZ+/hXGAN4nYvfJWxBtELT1JiQTh5pdFGQ/RVhvX0gfHM+5/3b23HPcVF9I0?=
 =?us-ascii?Q?G1d4wo1waIR0vfxxE9GlwAQ1s9MJ+drct/81FKym4jQYyRl110QppygQIdLR?=
 =?us-ascii?Q?ClvDxxVdg51gnO7NC+0Dkl9Ot7Wca0RL57M2sKRxo5qEwSfcWaPfEbz512pM?=
 =?us-ascii?Q?r7uXNF3RjHEhvMmqjngm2xfIuybrL3cLTzPqNb1nUdTmFRFxH4/pDFR+3xjX?=
 =?us-ascii?Q?6CXY7NuRPQSnfwya2fEfy4q4Cp2aNI3E/oZ2iej0TmMkQlFdF0ahBEgEj3lF?=
 =?us-ascii?Q?hXWNlJGUMA46P5xdStCWm7noFolEHRixqvzGfiCo8fol4Oer2rtEQ/RFr2w2?=
 =?us-ascii?Q?vOIOFPsBe+DGleyNKlOR4cwwqanuOHc/Q+fTjB+kB7ELMNoENqzlT/9JP8XA?=
 =?us-ascii?Q?ZBhlUxD6/aBtaCfJz8xdS3OX+GyAflqzvKx4ewBGNV3eUKs+n5obeimjMuKj?=
 =?us-ascii?Q?K2tCfUKm0snD9cJauBRbxWY6a+LNGqPJNgEOxoEMl3ZU7+SuHJajaXyfnCPb?=
 =?us-ascii?Q?9Mmd7cW6QbrPQtk803Yc5eX46IrLinIJT8EGSqsePYK/m+D/AyKqkc/eR8MK?=
 =?us-ascii?Q?xAeHwY7mI9R539Ga0oZXedHXz3b4372768ePMmGexJv8aOHdW5ZPiLhs29W0?=
 =?us-ascii?Q?0zFCJ1iwRnLSCuHgKYHEErK9Aj372UZNuiTD4KMO4qDctLkaYtQVzOJN8SMr?=
 =?us-ascii?Q?+mIsidRBLAiwANWq+pHnEASY5b8utdRS7qr0CO5g1A4u2JU4ZGqmNABsqLK/?=
 =?us-ascii?Q?ZuEewz5gtC255OO0uASl2NaXRRLLvXmbBKUDdl5zhqNdty1i35r+U8zZlrY1?=
 =?us-ascii?Q?H3fX1eYNXkXLQItB5Ow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2752022-c8cd-4233-e21b-08dc8fbbe761
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 17:27:18.2766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPgUuWncxCp8akvcJCow4o2uhVYyLoERmH/zQYhq5WFP5IkV/UbzgX8zzAU6vmI7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: Chander, Vignesh <Vignesh.Chander@amd.com>
Sent: Monday, June 17, 2024 10:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Chander, Vignesh <Vignesh.Chander@amd.com>; Chander, Vignesh <Vignesh.=
Chander@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use dev_ prints for virtualization as it s=
upports multi adapter

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
Change-Id: Ifead637951c00e5b4e97c766d172323dcac4da08
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 19 +++++++++++--------  drivers/gp=
u/drm/amd/amdgpu/mxgpu_nv.c | 23 +++++++++++++++--------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index 6b71ee85ee6556..65656afc6ed1c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -93,7 +93,7 @@ static int xgpu_ai_poll_ack(struct amdgpu_device *adev)
                timeout -=3D 5;
        } while (timeout > 1);

-       pr_err("Doesn't get TRN_MSG_ACK from pf in %d msec\n", AI_MAILBOX_P=
OLL_ACK_TIMEDOUT);
+       dev_err(adev->dev, "Doesn't get TRN_MSG_ACK from pf in %d msec\n",
+AI_MAILBOX_POLL_ACK_TIMEDOUT);

        return -ETIME;
 }
@@ -111,7 +111,7 @@ static int xgpu_ai_poll_msg(struct amdgpu_device *adev,=
 enum idh_event event)
                timeout -=3D 10;
        } while (timeout > 1);

-       pr_err("Doesn't get msg:%d from pf, error=3D%d\n", event, r);
+       dev_err(adev->dev, "Doesn't get msg:%d from pf, error=3D%d\n", even=
t,
+r);

        return -ETIME;
 }
@@ -132,7 +132,7 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_de=
vice *adev,
                xgpu_ai_mailbox_set_valid(adev, false);
                trn =3D xgpu_ai_peek_ack(adev);
                if (trn) {
-                       pr_err("trn=3D%x ACK should not assert! wait again =
!\n", trn);
+                       dev_err_ratelimited(adev->dev, "trn=3D%x ACK should=
 not assert! wait
+again !\n", trn);
                        msleep(1);
                }
        } while(trn);
@@ -155,7 +155,7 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_de=
vice *adev,
        /* start to poll ack */
        r =3D xgpu_ai_poll_ack(adev);
        if (r)
-               pr_err("Doesn't get ack from pf, continue\n");
+               dev_err(adev->dev, "Doesn't get ack from pf, continue\n");

        xgpu_ai_mailbox_set_valid(adev, false);  } @@ -173,7 +173,7 @@ stat=
ic int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
                req =3D=3D IDH_REQ_GPU_RESET_ACCESS) {
                r =3D xgpu_ai_poll_msg(adev, IDH_READY_TO_ACCESS_GPU);
                if (r) {
-                       pr_err("Doesn't get READY_TO_ACCESS_GPU from pf, gi=
ve up\n");
+                       dev_err(adev->dev, "Doesn't get READY_TO_ACCESS_GPU=
 from pf, give
+up\n");
                        return r;
                }
                /* Retrieve checksum from mailbox2 */ @@ -231,7 +231,7 @@ s=
tatic int xgpu_ai_mailbox_ack_irq(struct amdgpu_device *adev,
                                        struct amdgpu_irq_src *source,
                                        struct amdgpu_iv_entry *entry)
 {
-       DRM_DEBUG("get ack intr and do nothing.\n");
+       dev_dbg(adev->dev, "get ack intr and do nothing.\n");
        return 0;
 }

@@ -258,12 +258,15 @@ static int xgpu_ai_wait_reset(struct amdgpu_device *a=
dev)  {
        int timeout =3D AI_MAILBOX_POLL_FLR_TIMEDOUT;
        do {
-               if (xgpu_ai_mailbox_peek_msg(adev) =3D=3D IDH_FLR_NOTIFICAT=
ION_CMPL)
+               if (xgpu_ai_mailbox_peek_msg(adev) =3D=3D IDH_FLR_NOTIFICAT=
ION_CMPL) {
+                       dev_dbg(adev->dev, "Got AI IDH_FLR_NOTIFICATION_CMP=
L after %d ms\n",
+AI_MAILBOX_POLL_FLR_TIMEDOUT - timeout);
                        return 0;
+               }
                msleep(10);
                timeout -=3D 10;
        } while (timeout > 1);
-       dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
+       dev_dbg(adev->dev, "waiting AI IDH_FLR_NOTIFICATION_CMPL timeout\n"=
);
        return -ETIME;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 22af30a15a5fd7..17e1e8cc243752 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -91,7 +91,7 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
                timeout -=3D 5;
        } while (timeout > 1);

-       pr_err("Doesn't get TRN_MSG_ACK from pf in %d msec\n", NV_MAILBOX_P=
OLL_ACK_TIMEDOUT);
+       dev_err(adev->dev, "Doesn't get TRN_MSG_ACK from pf in %d msec \n",
+NV_MAILBOX_POLL_ACK_TIMEDOUT);

        return -ETIME;
 }
@@ -106,13 +106,16 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *ade=
v, enum idh_event event)

        do {
                r =3D xgpu_nv_mailbox_rcv_msg(adev, event);
-               if (!r)
+               if (!r) {
+                       dev_dbg(adev->dev, "rcv_msg 0x%x after %llu ms\n", =
event,
+NV_MAILBOX_POLL_MSG_TIMEDOUT - timeout + now);
                        return 0;
+               }

                msleep(10);
                now =3D (uint64_t)ktime_to_ms(ktime_get());
        } while (timeout > now);

+       dev_dbg(adev->dev, "nv_poll_msg timed out\n");

        return -ETIME;
 }
@@ -133,11 +136,12 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_=
device *adev,
                xgpu_nv_mailbox_set_valid(adev, false);
                trn =3D xgpu_nv_peek_ack(adev);
                if (trn) {
-                       pr_err("trn=3D%x ACK should not assert! wait again =
!\n", trn);
+                       dev_err_ratelimited(adev->dev, "trn=3D%x ACK should=
 not assert! wait
+again !\n", trn);
                        msleep(1);
                }
        } while (trn);

+       dev_dbg(adev->dev, "trans_msg req =3D 0x%x, data1 =3D 0x%x\n", req,
+data1);
        WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW0, req);
        WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW1, data1);
        WREG32_NO_KIQ(mmMAILBOX_MSGBUF_TRN_DW2, data2); @@ -147,7 +151,7 @@=
 static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
        /* start to poll ack */
        r =3D xgpu_nv_poll_ack(adev);
        if (r)
-               pr_err("Doesn't get ack from pf, continue\n");
+               dev_err(adev->dev, "Doesn't get ack from pf, continue\n");

        xgpu_nv_mailbox_set_valid(adev, false);  } @@ -185,7 +189,7 @@ stat=
ic int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
                                goto send_request;

                        if (req !=3D IDH_REQ_GPU_INIT_DATA) {
-                               pr_err("Doesn't get msg:%d from pf, error=
=3D%d\n", event, r);
+                               dev_err(adev->dev, "Doesn't get msg:%d from=
 pf, error=3D%d\n", event,
+r);
                                return r;
                        } else /* host doesn't support REQ_GPU_INIT_DATA ha=
ndshake */
                                adev->virt.req_init_data_ver =3D 0;
@@ -261,7 +265,7 @@ static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device=
 *adev,
                                        struct amdgpu_irq_src *source,
                                        struct amdgpu_iv_entry *entry)
 {
-       DRM_DEBUG("get ack intr and do nothing.\n");
+       dev_dbg(adev->dev, "get ack intr and do nothing.\n");
        return 0;
 }

@@ -291,12 +295,15 @@ static int xgpu_nv_wait_reset(struct amdgpu_device *a=
dev)  {
        int timeout =3D NV_MAILBOX_POLL_FLR_TIMEDOUT;
        do {
-               if (xgpu_nv_mailbox_peek_msg(adev) =3D=3D IDH_FLR_NOTIFICAT=
ION_CMPL)
+               if (xgpu_nv_mailbox_peek_msg(adev) =3D=3D IDH_FLR_NOTIFICAT=
ION_CMPL) {
+                       dev_dbg(adev->dev, "Got NV IDH_FLR_NOTIFICATION_CMP=
L after %d ms\n",
+NV_MAILBOX_POLL_FLR_TIMEDOUT - timeout);
                        return 0;
+               }
                msleep(10);
                timeout -=3D 10;
        } while (timeout > 1);
-       dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
+       dev_dbg(adev->dev, "waiting NV IDH_FLR_NOTIFICATION_CMPL timeout\n"=
);
        return -ETIME;
 }

--
2.25.1

