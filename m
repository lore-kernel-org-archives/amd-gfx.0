Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E63C87FCE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 09:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E6910E4B3;
	Mon, 28 Jul 2025 09:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UnNuoykG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0CD10E4B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 09:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmngXtWC+ihAmEVaNOCHOVI1G6x0PZE+x+PW6gvolWLzLFKrP7dsTqcefbonE5KwiNUgNq48JwsnJLuYWg+oMBghNLZV3vbh7J+tunrgvgpHVFXDAp554AMoqt8N2RQAn+WYm9cEQOKM8ajyinRQOgvOYq2Eeb1KcScOMH30RFH7Dno9uKNaOmhinBVcAVum5Itzb6EU3lWEovMhebCUMMwh2cRflB+Pj+FrxmVXRA/w5sjTB0eneWrc8LdicQKjP3IDHbZytREej8V3lSdumL4zjBlCcC54QRJfRtBPLxmUInJoccXw7RduDqZBoyaSoXcRpG01CEbld8b6P9opiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVcSwiph3dCajaTwt/Ez6sqNbK9sM9ZpEeGXLqfX4Xw=;
 b=rLhbiwMvcsXAk+OGRNQ5i8fNqPgaCNYjGhWD+ko8nwzJT3X4mgS30xoizBG4rvCQnYIhNdFmgkZlTXfsuwglmK1etRohr8IwSnk/C80gpIndsz7M+TxmOzssmsocG5+WyETAd7/iW/GrC5L/pt/xqURBqzkYXlUIgQj79E4uLEYLY6gUc8xyTGvnrnvyIxrRrZCYsw81uqVWZRlzOJ9C1HntFuWsmbsy/u4GJTBTuSUMRc5vn8gkx7rnAg8gbN/HlYVG2KRjcCJLAhKvK0+uKoQ5c7LGEes2AZh863NFmtYqfwV69wIicIuOd+fXJSwX3t6SV4nvIiWvwPst8YjFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVcSwiph3dCajaTwt/Ez6sqNbK9sM9ZpEeGXLqfX4Xw=;
 b=UnNuoykGFHgB+IBK5VrQoI7Amn3i0zDVp8hCcg6MqwTNA7Z7zcZQQ2WKYtyQoNXnqpDG5842yG/3LeANnb51HzDk2MKrs78yWNjbOzpCVmpJ3UVyUYFzmn99pVFYkStncx/5uggpzHUFGnBly1bSV7Vj+h9A8j12ZY8QDDwFZjM=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 09:00:56 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 09:00:56 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "cao, lin"
 <lin.cao@amd.com>, "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
Thread-Topic: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job
Thread-Index: AQHb+7EcoCXofQ9OfkW7m4hre0+GirRHQr2g
Date: Mon, 28 Jul 2025 09:00:56 +0000
Message-ID: <PH0PR12MB5420F1D3878389D200D4E419E05AA@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20250723090624.53536-1-YuanShang.Mao@amd.com>
In-Reply-To: <20250723090624.53536-1-YuanShang.Mao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-28T08:53:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|PH8PR12MB6916:EE_
x-ms-office365-filtering-correlation-id: c2201a77-083f-44b8-7ef2-08ddcdb543d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sMRpQDnI3nyrHLpafk+AXhyCSQ8yaRDjJDms4mHCPABnT0TXOs+8ot3Zzc+l?=
 =?us-ascii?Q?cM8dgWATpCCdlNwy0M0iHACHLGpgLV7WUh47vG6eDIXn6sRdy8lMg0fiQ58A?=
 =?us-ascii?Q?hSRUwBRnaCOfB4qI4I7NPbBXpvuXWQyPcYEorhD5krRUu16ZqMBYQUA48Tzm?=
 =?us-ascii?Q?z2QCSC3LqPJ3Ou5D1+J0TkkIbYMuRBPiIO6aACFAHyHF4T/TC4oKmoP2g+Tc?=
 =?us-ascii?Q?R224/CQ378FqgjdBktPGSNGgb03RSJooMmmQBw0EM8eOy4fY5kdGlDFQc7lc?=
 =?us-ascii?Q?Qd5nCaE/lXImHrMFqdoZLj8SaYD65CtksWbb+wDqQmt9J1yy2kTDytvjr7/6?=
 =?us-ascii?Q?erp0D9xZlidSR965zNB7RSUYyZ5kvYG9I4gneMAXOPemHx5tnpYSuSNJMZ0x?=
 =?us-ascii?Q?O7hacxe7xq5Mt47/ADpUQQdqeP1Hb10zq+NBLvXJKZhJT6zi/eE8LUzXakVU?=
 =?us-ascii?Q?xWHtZhM5+WhwtlhBWfdguBPyea/ipYa1wVRJ10nS4e94KyWYU2//j/LB9Fi1?=
 =?us-ascii?Q?7RyM6yD5Xyipw3U6fPyHBgg5AQxt1JJhovlQIkuDSUbnxyxWZID0emcswVdM?=
 =?us-ascii?Q?bN1xbDn5zzTbTlxJSVOIu6AwFRIpQxVPmAWvO38cDwEKF6nnKjP+Fb24+kpC?=
 =?us-ascii?Q?HpM7dA9bs3o1BHJ/gE782OVgk6OKNTom9ULw9Aecrs/V/XEPurKQOtAlQ7Lk?=
 =?us-ascii?Q?iSDk1nxokMbnIx0YmDIkfgxUbOxAEPvyL7DIHqb+xO/pgMn++UZWfEssfQ1z?=
 =?us-ascii?Q?BHYj/1xSW7tx9IhYJvo6RGq8DvKNvWQSaof7CJ/97Ya9/vbCiq+vGHtkpA7s?=
 =?us-ascii?Q?kkyI8+uzLhL7wmNrlSU/3Hr6StNjkpc0GpLunWk7k5Nxzu46Bh0PNDM6YK11?=
 =?us-ascii?Q?0+7wbOhQW0Mm7fPkE5LJ/Otvc/ISbYI7ixT4WK7kroAAJiLOJo+9Hmq6bs/J?=
 =?us-ascii?Q?+c+C6N2ooutlo+juFvFsufvDYNV1cWmwM+C4GLir6BSEhS4qXVPQGzKjqN04?=
 =?us-ascii?Q?ulBigimBF1v8SL2JsWNqotEqZNrkxUi0AlFhIYZr/kaPkQIKHWX6iTb3HEgG?=
 =?us-ascii?Q?sux9DI2CQwA0V775dh7XioI5GoOj091zb2wsYhTYXmnOEzY5CFF3YjgQKR8/?=
 =?us-ascii?Q?q4UYJOMTabYkaCmi/wHf2Fgn5RAvJEIY806vY33ThKDreX+8KiQTkwctsxxf?=
 =?us-ascii?Q?MuI24vdBXRcFI38xyZasouTaMijaq7tKsTaW40IkyYw9/AclEXS05ZSSeqQo?=
 =?us-ascii?Q?bM8F1V4N4+Vqw+Stwb5Coc8ouYJOG2uzcXDVJe3RlvqyrnlzYzUAgF8suz1y?=
 =?us-ascii?Q?j4Bdw2ac5hv7t4Sn2QtUbNC/vTZlPISJXD/gH68v9kl/8JSuZJw3rwexHqR3?=
 =?us-ascii?Q?g/QQKAxs/AzEJ7lWItoAJJ0HUtsDMN8UswTBJUmYo7bc75DQu2zvfaj6Mnpb?=
 =?us-ascii?Q?pSZlX30WhqRK1jnwQhUdCh4KZPfU6qDlQCmGVLho8PPoCv700G8TcfgWY6sc?=
 =?us-ascii?Q?KZCelZ8S8VJNB2g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sZBB9oJiIhVAfRd+zjhoHrWKr2DIOmb53bnLnPSAZQ7doe/iEyHpIGALMoeY?=
 =?us-ascii?Q?Ps100RO3NKZJvxl5iJxxG+9yHLYm95sW5vC71qYreC1nWkLDqm3Kktoin2g4?=
 =?us-ascii?Q?kKKwuJS1XLJ1xv3LcXXHBZaILe4YnusZ4UO6NoMgrlCjhlxYyLglmX8xnMTI?=
 =?us-ascii?Q?HssdMs8f6neA91wwbgx78F0RudfW2oDeJ0WopCwnmeqkKDlqIMC2JGyuoi9m?=
 =?us-ascii?Q?FA6hPcn+OA1rqP2sFxrYR0l9yhjgbXU4wzVYcbV+TWfh0A0XlObDytUV764Y?=
 =?us-ascii?Q?yRa+UBBp7BZG7oxzht/eqteDGdxPlCSZSwmN3t96eN7CEDPMyr2JasCESNxL?=
 =?us-ascii?Q?AUz4J23v8A5WS88hv0GWg2rxXtj4cfLvjYpBGRTI07ng5eyJYFUIpkJVfBc2?=
 =?us-ascii?Q?4Kk46tXSciVdFAETSHPqIWIovkriuaj6dqpnyrArSupu3ZI6wVZVwe1zmwFq?=
 =?us-ascii?Q?9+noUHHwFVSPFDW3dEY9aOEcZR+T8xmQu9S1K98TEtck+r9pLehCTOjnE1Ez?=
 =?us-ascii?Q?iVx1aL/158cJz8tHJZUBrPdP6yLd1Mu7RHv91nPenjpLNylJIjpMOQHTAIv5?=
 =?us-ascii?Q?Q49Jh1SHTHN+CnNgLciQ3SdYu7QfRwv0UUNFb5rQrSjAMNKpEUPVCU8X148K?=
 =?us-ascii?Q?yFGY3UmoDWqaDXOOs2DC76Ty6OBLeGSm8vQoPJIkmZ5WT6u12SNynIPN9eJh?=
 =?us-ascii?Q?ZHZDrTto/6dg+X677tTTrW54FrlQw94f3zQ24FjHfSA2ntnEViGZbdXdrrul?=
 =?us-ascii?Q?fP47V1PqGZFM7pMto8fmdKQgfUWkI6ij7J5xe1/DUfM8J8RlFlnb9XVotbo2?=
 =?us-ascii?Q?gXLl1ryWMGFYCWFYDTXjEVFSDmofjZCw0gkO6eIVfXRTiGR8OlgGrOdtpuvY?=
 =?us-ascii?Q?cGqcPIAYMcoInv2cJaSXH2+21uGqQ932QMAQjZvlo8EauYsyQamOyE2V/oSK?=
 =?us-ascii?Q?X67nWUHzycSKcZn1Wx+itYpU8nF/esDld4l0BI5vHH9tK+jmEsKQz9RZhNGl?=
 =?us-ascii?Q?RfR3Jw68f3ybhspSKmqTmmacaaoLx9eQO34sbM/rrpoDbdqh0fMSb3mV9Yrk?=
 =?us-ascii?Q?AM5fcp/Ktkkj7fcCXRugjWb+U5+wsi1yIQEmj3laPWmeDu9kSQvlPvcp4WV5?=
 =?us-ascii?Q?tHHzjwW4sFaa9Ph2copEbIiwYFf8v3+lUEUEUgLqOQ6cdDkpU29U2DAIDL15?=
 =?us-ascii?Q?Byh6F9PBPPQomQUeez9KXDQH/AiIvlP13rx5/PFINwsBMr97zUM1xGkZM/WA?=
 =?us-ascii?Q?NUhMOyS9wxk6S8oHncI1Fl7zl1tJFm5s6uutZ4K/KhlpMEF4pdesXPxiCI8v?=
 =?us-ascii?Q?oI6XkXqA5JcfXgQ9DHSazXU7BOwwf0QSp9P46M0xl5B2Z1T+0BJwJ0nUKIpU?=
 =?us-ascii?Q?KffpaJ6Huu2yVVZoAHAL4tfzDIxOvmuro5nPAZYw/znE9CzePRm4FrgUYuMX?=
 =?us-ascii?Q?TCLViULZA3Q0NvNntgFQTef2mLcSYeihldlLS2BQT9+Gv9/8jCQdCkdnJnHw?=
 =?us-ascii?Q?x6cV+tEF6dWZpATca10Y3C0hw3RvJrf6jPQzXQccfTfrHI6jAfvJoSJVNedk?=
 =?us-ascii?Q?0GMtAp8ieCkeKQcvBVQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2201a77-083f-44b8-7ef2-08ddcdb543d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 09:00:56.7007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CspJFCIaaWh/+YuWTzgmSybPD5sOnS9w/HFscZgGV8l+mL4Z7PJlIlx/acWPG5OeoMKNooY5rgidm22LkpSpUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
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

Hi Alexander

        Since Christian is on vacation. Could you help review the below pat=
ch?
        If set job->vm to null in amdgpu_job_prepare_job, the job which sho=
uld be skipped in amdgpu_job_run will be submitted unexpectedly.

Thanks
River


-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Wednesday, July 23, 2025 5:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; YuanShang Mao (River) <Yu=
anShang.Mao@amd.com>
Subject: [PATCH] drm/amdgpu: keep job->vm in amdgpu_job_prepare_job

job->vm is used in function amdgpu_job_run to get the page
table re-generation counter and decide whether the job should be skipped.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index 45febdc2f349..18998343815e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -360,13 +360,6 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job=
,
                        dev_err(ring->adev->dev, "Error getting VM ID (%d)\=
n", r);
                        goto error;
                }
-               /*
-                * The VM structure might be released after the VMID is
-                * assigned, we had multiple problems with people trying to=
 use
-                * the VM pointer so better set it to NULL.
-                */
-               if (!fence)
-                       job->vm =3D NULL;
                return fence;
        }

--
2.25.1

