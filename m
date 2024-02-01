Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C907C4828D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 16:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC65410EFD4;
	Thu,  1 Feb 2024 16:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jSP5wlK5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A1D10EFDB
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 16:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfszGq0bmDKjjPEWHtxqzrIuXS2rjDNZeos90lokaUlxWosOXHbMWtZvT363E+IEkf3KjCP+y+YUjpR9thV0AFG7VSjn6H0VfUO1duz/2Z8fvVJSwNjRh9pVOyIGVvTT5MLbTto1h4eJUUoXNQqRK1iZytbQ2GkfpuOMEur6edVaoPA3LBRH+8xPKf9pnlht2ux4j36hH9vADCGxGR73982Cab/2atYOcmzARiI5Pxim1goWb8v4BXRAy8sF+5TzC20fVcFRFoYPlDBZMnoy23tYAqg+iQkZhu9plFSNjPjXUoIfP61MDQke6whJK9yPpSdrIbdUWa+zWJyBGS7saQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPwkHT7ZvhaWVjnYsQ2bOmy6/yTDgpwerg1kzNSMPDI=;
 b=mN37yCU1coLdtomsebbWkYJRR0+9ki92tRV2jquu7znB0+9Xch0J5umsilGnk/olMFevN521OsrRrWNuBAhDw7wK4vb1yh75UhHes9s/aEAYhf6nuyyC6iSm6exUD0ArWJXORf7Apc8pJMJ+P+BEtbhUALSDz9CClv7QVuxNG4t3iBzomYWBoIy9RW/CDxLWalUXUDc/z0XeXGrGG7lJD2RvPPxEGbTNh9aCkRUPPFbgdDadSzkFNTn528GdEC1BaQZB4UewtERp/Bu/kAdcnbiy9zQjuNNZpzY7G8GFI18d2thipAba9T6pG1gJQRtvLz17YXF+KDLI+XdkOuPqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPwkHT7ZvhaWVjnYsQ2bOmy6/yTDgpwerg1kzNSMPDI=;
 b=jSP5wlK5Apcjrrd35zhPqqIr+c9ttRsEttupWJpCf6/exULUMqF4rghVfNLnKjOS/YIPYzNuPEUohk/9S8kij8xUZG6ARxytNOrZtnzmnverttDyynsHnZjdRKs8ZNI1VHd0hHxdLmPPPhyl7cpMBaLxUGugvcOBjpgh2taRwyA=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1eb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 16:10:11 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::1d05:912f:c481:44b]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::1d05:912f:c481:44b%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:10:11 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Only create mes event log debugfs when mes is
 enabled
Thread-Topic: [PATCH] drm/amdgpu: Only create mes event log debugfs when mes
 is enabled
Thread-Index: AQHaVFF9xgBTEcTwckqbOkbl10KLQ7D1pj0AgAADQCA=
Date: Thu, 1 Feb 2024 16:10:10 +0000
Message-ID: <CY8PR12MB7099CD1196883AA1AD739BAF8C432@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240131142600.679750-1-shaoyun.liu@amd.com>
 <CH0PR12MB537217E8CEC612D674012493F4432@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB537217E8CEC612D674012493F4432@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d405d546-5491-496d-bb1d-8e6c48a51328;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-01T15:57:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|MW4PR12MB7029:EE_
x-ms-office365-filtering-correlation-id: 83623594-8eb5-4357-1281-08dc23404444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SoZHfgGNa5Oop3+EjpzNvn7l3A3TNienCtK66eBVPXwn9FnGC/pFitqBnYZcOuS8YAj1VIgY8rKgk2H7qRzkORBcPBOhqLusOZn/kIMvZE2oFQ25sRHzy2eFSOtrRjtgoVo3flR95XDXb3Q6HPyOKQPXVB/EzlMaNQJ4YixCs2AZnItJ0fvUJcevE9IbBWVUnWNJGLQvlSIcOB147/mVZkmhnOCePz2R7wwMGQdzvFNCkdof/+VXrSxosWewYz3xLkau46XSK4tp3H8QrDDIY+mqlDwEsWnreyVDJisisk8Uc+8jCh/CqBiB+1d3PrGshZnfhgHU+HGVi36hHUGx8c51vqXe7SrzViUk/i8rcIOl8X7Nq8U9fqzDKGvAj0xRl5vjra6r36XFel4ibptIZVaR4xEpGzbbJuroNTqZmv8ds+J+rgJqO9L0FcEwhhvDUDJ199jBhCrAdU/gCRGWLqZqeoRVfymPV+NJ1gqj1/Bof/Z/A21d+jsOGcf3l9ZMdJrIuy/Wd1xefxZaq9xK0qJ9huFQwpeyO8GCf4+cJaT6mEhOTrEvvdfd5/wap9u9sltE/95PimTCvrz0bfrIu7VFne5SgLCeAq/qF/0X1vRvRbNR4ejynEnEwco3+iUY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(33656002)(83380400001)(38100700002)(122000001)(9686003)(26005)(52536014)(8936002)(5660300002)(8676002)(478600001)(66556008)(66946007)(2906002)(6506007)(7696005)(66476007)(64756008)(66446008)(53546011)(76116006)(71200400001)(316002)(110136005)(38070700009)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+soQINzJBJ7+uXnEnsaeoKPqupy9auKsKdpycl5Rtc2JTPZA7tNae4ByJYQ1?=
 =?us-ascii?Q?YjGnWVxmKaWwNRCECFPx305OR+OHHhL7ZtsbH9AtdSX3AoTjAEh6genLvwX0?=
 =?us-ascii?Q?tZbZ28NKf2yJ0DX9V8jMO20ntPnB7GGkq3Cd2dIFwDZQC5lLEJDaG8CWlZQ5?=
 =?us-ascii?Q?X84hQ8ZKjTtaQDG21c4dbNtkUWJtLgcRxJsomym1spApLMLK644FiwTxALqg?=
 =?us-ascii?Q?0kvLzIRn1kUKFuoIvEul03G400t82O5cA8j3VO2Y1XDYGvmc/8j5KnUiJnhu?=
 =?us-ascii?Q?cnlfAkNAjrwYtWRLZgeiQr2l7gmXQZjyN+KwN43Js1wkq3tRZ+srmIjQz5rs?=
 =?us-ascii?Q?9DNfs1SXGY20dRv/ISwCHgPmdNzudY7z1dlibv916uEMsgxBA8sAsBrQwh3r?=
 =?us-ascii?Q?R1hzlw3zVHCS+CM+bTuPveBSVvtGDuLKlV73e3DQ88kEfAHI2+W0BJVXg1I1?=
 =?us-ascii?Q?v9MRQBPIHryKi8/yc94AoSVPrOGFhPLVbCjJ4/Tvxn4KLq63MzvXT+J5/7Wn?=
 =?us-ascii?Q?KzEUQ6TCT5RuYPhL7kJAq+TqhHsBuUXpb1+xHAEkooXKQQWhxiFijGDBVffC?=
 =?us-ascii?Q?Alt9TZZ8fulq6fdOPhIeEgwJsS5e687ocjRqc5iRiPU2j9iSPny7FnuDBAr9?=
 =?us-ascii?Q?r1X+km46gESQuI4657jR4CKDZBKFqOt+IUhSfyySsgLLAZSp8QA0MublDl86?=
 =?us-ascii?Q?DdYG6pz2e2EigcXbmf5/J0z6OK1DVNFRs4rv7q6KS0/YzUnj7BfdEeh5tA5b?=
 =?us-ascii?Q?PAfU9gdGZRtutf8yFEPIQLeZHAFRtAgZEsr2s7LzOIi4Kf2lM1Y0jmkBcJ1u?=
 =?us-ascii?Q?xNSRM6oN2MDEiMNWJL4OPs2VCTPbF5XM/yu4Da5qzGDF8J7MvJIEdQXII0TR?=
 =?us-ascii?Q?rRCjYJGYU0f9O5qu1fzwrkz0oD4opq7WmFJt/rYcKrn7gFaawiuuGM8HulHw?=
 =?us-ascii?Q?CF5xU+Ujw+2T3xTI4Vu8sC74zhoh5Y+jekooOzfeDs3eMIEE0ppDlNWMWeIN?=
 =?us-ascii?Q?jLrR78nXFlO6TofoNGomTlQgnHtS4reh8UHcld4KjaCm5Ib8PhS4AjNtgKa/?=
 =?us-ascii?Q?tqU4cMDkNgCg196RP3/VoQL2+5YVD8wTt/1TgqBIPF/PePLVSH3wV8sGVNIK?=
 =?us-ascii?Q?4waSJZ8R5q9+SB3NcGgdPnnA77i/EY3uOT5r6UBdAKERdCPL7qUc68TAhzv9?=
 =?us-ascii?Q?lsqla2slIGgQAkN3y35Foxj+QQbyQJsS41RjMBizFyNY7H5bINX3o5tchme1?=
 =?us-ascii?Q?hGXMqN0ehDJ1rGuqnMpG7rBifwHi/Q7D8betLOpPbcEK3cGX82MOe8L8aQJD?=
 =?us-ascii?Q?TZFb5GmXan5ruiAuldMzH5Jy1On6RLO9f4yAXKnEDzG4QIwNNo3Xf70RYxvR?=
 =?us-ascii?Q?AjWtoPLFj1nIg4PmlEAtqkuBroifXSpGOUiIPR26TPm+MjgFI7MVIoOtU8Dz?=
 =?us-ascii?Q?T+NENe02bEz0UMKjJrl9ujG6cgIrKfZ62isII/mrJnlD8bW1VJZWlQYtksCF?=
 =?us-ascii?Q?aMi34n1D0tm1WavX9yknr4g86ApT+0Sxoft0fcilB+6JhSqPNsO++53cHmRi?=
 =?us-ascii?Q?JO/81hd21lkhwMBH37I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83623594-8eb5-4357-1281-08dc23404444
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 16:10:10.9741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2uFEMCfUbg9rXxyZxSHDXkKsFSG6QWgWFhjTo3mcowLLSP6V/hrDxcCjwW9wFXAFC0fnZcadTA6CrSJpBQFZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Sha=
oyun
Sent: Thursday, February 1, 2024 10:58 AM
To: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Only create mes event log debugfs when mes=
 is enabled

[AMD Official Use Only - General]

[AMD Official Use Only - General]

ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Wednesday, January 31, 2024 9:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Only create mes event log debugfs when mes is =
enabled

Skip the debugfs file creation for mes event log if the GPU doesn't use MES=
. This to prevent potential kernel oops when user try to read the event log=
 in debugfs on a GPU without MES

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 0626ac0192a8..dd2b8f3fa2f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1565,9 +1565,9 @@ void amdgpu_debugfs_mes_event_log_init(struct amdgpu_=
device *adev)  #if defined(CONFIG_DEBUG_FS)
        struct drm_minor *minor =3D adev_to_drm(adev)->primary;
        struct dentry *root =3D minor->debugfs_root;
-
-       debugfs_create_file("amdgpu_mes_event_log", 0444, root,
-                           adev, &amdgpu_debugfs_mes_event_log_fops);
+       if (adev->enable_mes)
+               debugfs_create_file("amdgpu_mes_event_log", 0444, root,
+                                   adev, &amdgpu_debugfs_mes_event_log_fop=
s);

 #endif
 }
--
2.34.1

