Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9DAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 01:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C0710E663;
	Thu,  7 Apr 2022 01:23:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF8010E663
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 01:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdK5IfB3DlFtZHBr5+bGGJ1ChJKRIKQk0iPWfsuc3t/vuSDtfNCESKUAShtvdKalJ3I1Ae0Nriyc4npOpQI5592cOZh4WyXaORk5liNU0WNUtHi6jXFe52GmrUzojAjOeIaVQow+xXOnFUZE9tMFmblt9Fre8ugY33xUkUBA5gx0la1hqaZwhMPqVMVB8nHPxfuEcfxRaZk9r5GSdCD8MQ8Aypw0/HMWLlKb9NSQgjtuBti8HEdfSlrIi6NSzTnN/tKbYXY1SZogB6VjD1+xdOSnv//gd0AdEAsJSFDt6AKw84jctXaDU0+Nh6f9Mv6qCFwPCUMH8pJAY4rNwiKMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib49zcrSwd6/KR2SJdyPbV9kAXN++I6emgW091nscxY=;
 b=YrmrLBUzbPbMao8HzyLbExrETtBcnLPtl1izvSft6Zs1KU6dMI3O42GYUf0lPD9vH6gwAOM9j5Gn04QFo67D/9/0m986nI1mYdfulmwvagTL+/k2BcIIy/d4TxObzTl3BQbwMphoHbRL9rB944rr9vvTIWn4O382c5Soy+sJ8z0k/Du+6PjQnqKS7KyupcOdrojcDm8Bn+Xy3eOQRcqGAJnPPmHKccK/cpuRWKRH/K83dzlPNakvA3TrDiJcp5AQHAS/Wk6Ty32MEZKYEdqXiAUU/+br6UAwwAq056pzuxKFXSk2+LiP0rYW5T87t95q98YBb5ixMirPSYRRdLP1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib49zcrSwd6/KR2SJdyPbV9kAXN++I6emgW091nscxY=;
 b=Wzjrgn7SnsmrTNO89HgnJTvIcJrzeWf0Wro5+p7SlTomc7Od3WFlk0FeDzr1pwDbvEmzRIrxsRb4ZGGGB0xi80WplCvTrnBrZ6MmF/bbXZTOdeYAuueAmW5bfmPMhf5t5Gr93D0wn/v1McPhqYGee+fq7oOtyyORLimdkHWiN/4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM5PR12MB1500.namprd12.prod.outlook.com (2603:10b6:4:11::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Thu, 7 Apr 2022 01:23:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1d50:ed4c:53ca:7c37]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1d50:ed4c:53ca:7c37%3]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 01:23:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Fix NULL pointer dereference
Thread-Topic: [PATCH 1/1] drm/amdkfd: Fix NULL pointer dereference
Thread-Index: AQHYSfo0otmJ8ZESwE2LI5LdnUCHOazjqB/Q
Date: Thu, 7 Apr 2022 01:23:26 +0000
Message-ID: <BN9PR12MB525709C268E466C908CFE56AFCE69@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220406210616.133483-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220406210616.133483-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4bb855d1-f3a8-4f63-88cf-b8ff1a617591;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-07T01:23:08Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5ddb165-8376-49f2-629f-08da18353752
x-ms-traffictypediagnostic: DM5PR12MB1500:EE_
x-microsoft-antispam-prvs: <DM5PR12MB15006DE69E628E7994DB88ECFCE69@DM5PR12MB1500.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRXMjVaS4il6wexaWF+3qYJkT9aQI8aF7KKrc4RM72TqtAJrNc58EBOSLkfyKWVJfFXsCkvVx2+JGurGKJ8Nc8jiHM58xUEfvVGyKKfNzpK5ncJuzdKKRlfn9B9vaYsKJRuPvBtHVtSs+ezZLtqB9IO/mYBQ3b6zeoch8TDHtCMpTqKKlWMiWLiRAjFCCblXw6ZBN0LeamzVQ1mkg/qMiWb6jTpGg0vN8KykQ2YU8TWfuIPcdKETvNRucJRPvHw+8wMUnmQKTbOcRRjcLCVKq4pMcmjSEb6Iq9Rstb8VcS2QP6Flq13mX5is2cqkWce9TGlknC3pmOt1UxnFIMW5v+mgjH7Wl5FndIic5+2FfpdYtXo+WqDeo6PXjKeqlYnxaFbHJICu4rIVIMGUvi7ylE7IM8yFugteyAS6P6XN2pdWKpGpwc6obRwZes1cx2uy2MAl9Bny21yZCr+rdMV62bmDiwDbc2m5Mam5W3T4IheiWL7lpAhIrxJNK4paAuJBacrnDDvljM0bs/ueux0T2UiBVF13eHRt0h7Clxia463XMKk24+xJ7wz9gGb0JpJnHZA8NglHXE7u9nLNnLxKbeQ027SSj4zp2ZYKNlAQfjcAHvsnsGmUq8GpZQqexqgVztkZt2lomCyqtx2awA+FA2dAHVzC+/DMB887VJXcslHPuHv4AdIAHwR1UovEquPW8Qr3CSoWx8NsUxWtSdcScQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(122000001)(2906002)(86362001)(9686003)(110136005)(53546011)(316002)(7696005)(6506007)(38100700002)(8676002)(83380400001)(8936002)(186003)(26005)(5660300002)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(71200400001)(508600001)(4326008)(38070700005)(52536014)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cWQ2GHYxBUAhnNzGyWMXwJb35HBF/9mkz17XkaluR80jU2bE4P95AKWBFwEq?=
 =?us-ascii?Q?ZhoKxweTk+WR7gp/qmMmUMFX6ge522n3clEIYtyjonDq4FcQStZNwU6Sl2UG?=
 =?us-ascii?Q?wE72Gxb/pKby0oyC3k75LKX8nGKvKUANQMP/gavXIPeN6n4PgvGfr4ZHX4k1?=
 =?us-ascii?Q?KrgY/sq4purZdGpK92bf5MGRsFelE6pfPTNuvh14OkHVV5CXKlT/FyAWXC6T?=
 =?us-ascii?Q?clqKY6l42jx7vyNwez4Ul3OWZ5MgUdrpIOkoTBhh7yXLAAMDkH+JfbEmoRX0?=
 =?us-ascii?Q?2AqcrZ+MLwMYZnaFUsxzbI53Gif6nMU7WebMocY0cGLyR//BkM9gj89imArR?=
 =?us-ascii?Q?E9+EHE8MQU3zVc2fcYDb2s9VT/S0MvyR/mgWj6+7+54Yz4nFJBGFluMOzEpB?=
 =?us-ascii?Q?sM7z+jop4fLJEo9lwNnjmnO31KBWz3GuA3fb1kTKQAtr5ShGls1qUnpMKDCA?=
 =?us-ascii?Q?UFdlm/zO9yz+e+a3iDHJ9uxkDuWnQTSwEUekAHelaL0TubNq/gbPW4ORW7I5?=
 =?us-ascii?Q?bBDjwBeWbUf6yHA2FEjIBtQMueSd0W5xThYXZ2vGhhYXCLemDvsaWhzBAURD?=
 =?us-ascii?Q?vwJY9HCE62PTGWclj5tAHw17yw0wK1uGM6q4CCiT5jn+OizVYW8EMyINW6i2?=
 =?us-ascii?Q?x4Q3U2TJ/zum7csofjCvRDA4E0MhgKbVySt2DBm+JKucTZCizDyQhoc6WTPW?=
 =?us-ascii?Q?vmnL105M+Uwh7/DW8Nbyrvaom0Uh2ObIzBQb/yMwuzvrJCRCs+UpcOVPRhwS?=
 =?us-ascii?Q?YMoKea3Msxs5pR5cMMWlEFgeIfhHnTqtcLY9te7HJswYYQK1XjLvRZMwZg1c?=
 =?us-ascii?Q?xFzhQ6nW+2Tf04pXOixYffxTMdWvlu5ghQwqDAINnCefl64qb7eGK1OClQKp?=
 =?us-ascii?Q?MDR4T9bOrD+C1yx2hqn1XzJbzUJYo6OHoAeQDqoPxJVm7Urvgj7UOoxO6rNd?=
 =?us-ascii?Q?eOpd4zgaK3AU+uAonkheeAb9S3diaiiUt5C3bTgEr0W5sLDUgknuvbwVGd+Y?=
 =?us-ascii?Q?tf03kvRIPtWupWqBZNYHj2ijnWPgyLsLMjRu+nOq6EbJ1DfGwNCBdnCBCbv9?=
 =?us-ascii?Q?FubQv/pMxNOakLjakxSx/6zcH01LiQxWsC7o47iI186IEk6t+ToKca4xevtZ?=
 =?us-ascii?Q?uNF7Pqruc5J8deR+a4KjU18JhBk+6Izt7z6e5fQ1J+D8s22vSKqdECRqBi+l?=
 =?us-ascii?Q?Lxr75eMgGM81Bpn5D8CggmMxDxx/5W0OpbgcSS58rPAsZAI797uBOhIidA8i?=
 =?us-ascii?Q?03Daw8k5D6uTaN/TPPgBmc/gkuwkpibrFJxkAsEYlkdgSZhio/hwNVkHn/5l?=
 =?us-ascii?Q?Ohi345e19b1gSJOgX7wyUnpn+Nuriz2GiNnyE8Ttq30SVdqqvwibbPOkfvDY?=
 =?us-ascii?Q?/YKYu2p8MfOOz97PxNtTbWlpt6I0a7o0girgUZDyo/iTBfvj3o64N20m/v7J?=
 =?us-ascii?Q?ALar6YCU3a0W+uTGWJApjtat7O7FZ2eu3XjMp6LmRbkAj9rT+AVAIMDj0UM0?=
 =?us-ascii?Q?cW0BkhCwwP+gL1O8BjJlEWbrL6CHmud+xtqZCtq0B+8E2zRBavfje0BkZomE?=
 =?us-ascii?Q?tgxRqWkw0pRwA0dvsxDxntcILiNw4AvxP70ZYr9usqbPgS0dicp4hSuGVmJg?=
 =?us-ascii?Q?Sccq9tiLjqsYsgocHRd122Nezp4WEbci7SkrpZznkEDzLsNldxgCmqrkZ5ZE?=
 =?us-ascii?Q?kXM9r9pkJ/R5r7ctLmyOxoPGEFLrthU52/R/S/sJEvHaDRi6CNNpoHdrQ6An?=
 =?us-ascii?Q?DkYhshh+MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ddb165-8376-49f2-629f-08da18353752
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 01:23:26.6513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPgnhIxTuBIJzK/UkyucPaf1gdRdcI/5FaRI9aVYi54vNQFjLj6U29u2tfYMhy2/ECbs8cOZxu4jDg0E0iTjng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Ku=
ehling
Sent: Thursday, April 7, 2022 05:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/1] drm/amdkfd: Fix NULL pointer dereference

Check that adev->gfx.ras is valid before using it.

Fixes: f385fc0d19ce ("drm/amdgpu: add UTCL2 RAS poison query for Aldebaran =
(v2)")
CC: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index c18c4be1e4ac..64c6664b34e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -727,7 +727,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struc=
t amdgpu_device *adev, bo

 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *ade=
v)  {
-       if (adev->gfx.ras->query_utcl2_poison_status)
+       if (adev->gfx.ras && adev->gfx.ras->query_utcl2_poison_status)
                return adev->gfx.ras->query_utcl2_poison_status(adev);
        else
                return false;
--
2.32.0

