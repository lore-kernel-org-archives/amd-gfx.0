Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48198C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008EE65013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008EE65013
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10746EB49;
	Fri,  5 Mar 2021 15:11:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A10E6EB49
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg2IAW1nYSrU8Z0MWSxZA81nQBo828AimR7A/NzoSl6fPOQX8TgiSdwfno3I3qMBsmKEMj5gJGYS3ZsoCofE9Y7Lauf8nzoXfAeZnrJFBbGBeqIJn4nEVMmrG4sm/It31SF7OwV/IG9AFhxZ/o2meDMYC7pCSEjbEnTIPO3XY2Up09L7ozVQlG5mDeupBqqEr+brt7jSMfSZ5fBN3EJ/YQBxXORsQIzHkhQCxdYh+NuyeNJ1yKRamNMwhmKNUys8cW9haQgWQLMBXxDByvnMrJrXnD+Qhp0rzIURxX+x4fxKugWKSpVnJq9f+ngCXnSO+4i8eGGDjIQrcaeXUtKuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FE28tdHtCRAUmLM4N2a1RMTEa3DLXPv8kRx5luu7tI=;
 b=dZafDFvR0yaZBJccYvp376E87NeItEXZcjJtApi+YoBWVzQ/UFZ4dAg8oEFO6Nf2ZqDpQSGM36SH5Y1/JDQi9Dby6xanZWKPVWpMoBRMKKYt382MFoj9zYacsId2ON6/NPLzuSljCIDzGSRGz608zLTjDIE4OarFRjiV+JrkXA4u8PFENQ084SEVQiOzZYmEUUELVDhZUojCS4p1GnH4yJrHfsias2Ta4DPr9OR0tGwvxdeEfk3ULe4Gcy1TII3BqBGdudWp4HwQj6XTYtX1aTkkXPGU01kBJf3ygSwCFo6XGI4yngeOrHrbNgJUm6fSeW6pb/Am4WpevvUHamTmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FE28tdHtCRAUmLM4N2a1RMTEa3DLXPv8kRx5luu7tI=;
 b=4xeB39uqVkZBqC69Pf94292dVKRWIJhvcBJCf+iaamd6t2el8htyJIhG7+38L8JeSiZVxQIfZC4KBrFxj8CEnaL/4HPXcsQcFojPth93jExT8uMR37cFb1UNZAqRPsRQVy8E7SQotnNFyvVHEHbjkC6v63ouWcgO9/+DXwAZurQ=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 15:11:20 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.033; Fri, 5 Mar 2021
 15:11:20 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Topic: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Index: AQHXETJFMXdW8W4cP0aGwExcYJ2edqp037lwgACg+hA=
Date: Fri, 5 Mar 2021 15:11:20 +0000
Message-ID: <MN2PR12MB4549985D925979B5FBF534E997969@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210304200851.4937-1-Anson.Jacob@amd.com>
 <MN2PR12MB4549D18EF741EAC54C46338C97969@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549D18EF741EAC54C46338C97969@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-05T15:11:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b799a2c3-2349-4e4c-bb6a-5ebfc105de13;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.212.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3feb36b0-a196-486f-97f3-08d8dfe8eefa
x-ms-traffictypediagnostic: MN2PR12MB4303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43031A276A0A099283B2723997969@MN2PR12MB4303.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pxsu3oLHC8XuS29B3ZyneLllcNZsdmeBbK20e2AsJMqqbXaIvb7TlRYO15NmlQHN2DZsmetc78IiCbdszk3a1pFwObxQZnCMtxUws3jjrNFjVABhe/lfKz+FFSBl6dzFIh8en9Ph0MH32mGVK00ylUykIOjLUvU+cdatdQRkGhF13h8tYO97vDjUsGGdYeqdt5tLNlHm4sYrrrYeWdOfK050YYm04EL3nGSosXNOa5o711++XQoUW8IwPa5N6XxNTZJTc5c8Kcpj/P2+ovqqqye2yTqReCo64HAdwAH30V4enrYmq/kXynvFaMng4Rd6Dy8cbfCOjEVknci4iBFlKLmi7v7zJahn6BduOQncecI0Je7fAcO6WovZHVFtCnERr1LAETu3qrL1BVL+vNBmPt2R/7+1JB0wVz5nK28ydV4z0XaM0k963DPxUJkapiXnrUDs03pAYpgGqPa05E0GDnQydzMjGrXOV9lUq2Wy9kHiEGmQ8kpkjjr2qtKbv9BZOFEc1R0BgohRSmiz+f20f6UyzV0zGsMVYhLGaP4Ofp1gIFublObbHQe5f271LIuQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(71200400001)(9686003)(54906003)(8676002)(55016002)(53546011)(7696005)(6506007)(83380400001)(2906002)(66946007)(64756008)(76116006)(33656002)(66446008)(5660300002)(186003)(66476007)(55236004)(26005)(110136005)(52536014)(8936002)(66556008)(316002)(478600001)(45080400002)(86362001)(4326008)(966005)(2940100002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XJyu9o5cx6VeAvuZpqUq/tZ3qsc89IF0qy5FsDZPXrP1zK/W2jtHqH0bjJ8q?=
 =?us-ascii?Q?KUytOkTt3CJyVhUYrW45q/amK+pOGxM055/mHQxgHzh+ul2l3Lb1/2+Dc8s+?=
 =?us-ascii?Q?P0MZ8/rPUGV9q3RhmkI4lv5ZjXq9hQr6Q3GNwn1ftlXSBLJ21iP9d7Mmn7KO?=
 =?us-ascii?Q?fi8IlKRscOEejYJFiPu9H+PZaAc3kyoKbYrfCz/Qhh2vYYgla/DqyJmK3ZhL?=
 =?us-ascii?Q?jtK/pk/GcDujo6EPnHTUliM4xCUBCe+JcYBBOfSaVRtPaWI3ERTJvARfJh8P?=
 =?us-ascii?Q?IjJ+fjUvSlznJwaoODGooCtHxG2sD0bHEXCvnamsNqTG8wN0YF2QSMw5Mtuc?=
 =?us-ascii?Q?Gc5Ih3G47+/fwAuSHhvUTr4hvak+yKPQy4kT+0637mqkBpPw/a20dBlfTjK1?=
 =?us-ascii?Q?Zq+36zyn9+1Vwgn7rKUnglNexo7pGeE45Ql+VQOabVXXpWRpAj80KntYRuHb?=
 =?us-ascii?Q?aLac58LsQUXJsmm+rrj/+6zsuQRUzO1LBGmxLz1l4Ju8fWvaIGP7ePF7rVdW?=
 =?us-ascii?Q?7lHD9ipWDjLAzcHD+srf7WdvxWNUZJSCq4lUdThGhnh6Da6sF3Wf+b4S7lIm?=
 =?us-ascii?Q?5k4KsTRMH0fV/3rY9EXhlvfgkduDx0mv2cOs0aLp056xHtWtd4r6ueUcQr6N?=
 =?us-ascii?Q?exLRbFSKE6OfSxv/nmAhw5QbPITlOsArr+lb/euAeFz7fKedPlpDjTBc/Wgz?=
 =?us-ascii?Q?6xbAIYtqI7dB+JNMoiApWyvL/kH7givAKUmOlCYCriMg8FX7di0Igxxko3R4?=
 =?us-ascii?Q?ykAGdC3o77hUbf2eTFzu6+yH6jZNu1c8tdpP4IHV+xyYaaUKTtRB2Pms8pIp?=
 =?us-ascii?Q?mVhTTJ2uvnZMVC53Bhb59ZU5DP15L7kQQR/eay995Tpmi4+wYEl8vrtznoWR?=
 =?us-ascii?Q?tb00jaPCw97Ew2gN0vDzdpMB+G5cer4tJlj43KR2AGVRp++4sFkr6vC3++Uo?=
 =?us-ascii?Q?MKM15b+au5vtdILytFveqRsZhmofccnKlFv1r5Vpuz3Vb1JvdoCNgtfRwcjP?=
 =?us-ascii?Q?gRLbA0zQMc1Wb03OH/e6t4nr7uT14AZWI2kO1KxE2XqPpdCxH2cywPs+o9bt?=
 =?us-ascii?Q?b+w1FvTRxG7RrRhIDvqq9ky9ZN+2rd3875xiJq12wkai3KBlbHnKYjTng0Sx?=
 =?us-ascii?Q?eSsqXKJ9MwxV0IUZ/dreAp5VPEVlNavpWFJ3IrjDpuHBrWIEWRnT8hjCbmST?=
 =?us-ascii?Q?jialP1kz2cQIVEQOQihFs5yjrIfkkE4cnh315ALfWQMkOC4WLeL977Jg6Xkx?=
 =?us-ascii?Q?CMV3ZatcP69mrV3h1SxV9rwoRszOJhTfoTz/7yp2VTh8PfYFJxGHlQnfmaWj?=
 =?us-ascii?Q?p2A6lEz+l64hmMYmhZVCiWIk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feb36b0-a196-486f-97f3-08d8dfe8eefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 15:11:20.6726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqavLq5z8zotz/O+GlWK9iAq6hxBhYEVpUOZ1y9qe0MuPQSOlayEdCCh9U+/vcOP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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
Cc: "Jacob, Anson" <Anson.Jacob@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Anson,

Please ignore the earlier comment. 

Thanks,
Lijo

-----Original Message-----
From: Lazar, Lijo 
Sent: Friday, March 5, 2021 11:05 AM
To: Anson Jacob <Anson.Jacob@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Jacob, Anson <Anson.Jacob@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Jacob
Sent: Friday, March 5, 2021 1:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Jacob, Anson <Anson.Jacob@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning

If get_num_sdma_queues or get_num_xgmi_sdma_queues is 0, we end up doing a shift operation where the number of bits shifted equals number of bits in the operand. This behaviour is undefined.

Set num_sdma_queues or num_xgmi_sdma_queues to ULLONG_MAX, if the count is >= number of bits in the operand.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1472&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cc731ee10b10b4728138808d8df496648%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504853648181515%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=iNLxyPbJfbuUeKFA6ygwcBGDSRJcfgOGjMFNHwGzun0%3D&amp;reserved=0
Reported-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c37e9c4b1fb4..e7a3c496237f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1128,6 +1128,9 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 
 static int initialize_cpsch(struct device_queue_manager *dqm)  {
+	uint64_t num_sdma_queues;
+	uint64_t num_xgmi_sdma_queues;
+
 	pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
 
 	mutex_init(&dqm->lock_hidden);
@@ -1136,8 +1139,18 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	dqm->active_cp_queue_count = 0;
 	dqm->gws_queue_count = 0;
 	dqm->active_runlist = false;
-	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
-	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
+
+	num_sdma_queues = get_num_sdma_queues(dqm);
+	if (num_sdma_queues >= BITS_PER_TYPE(dqm->sdma_bitmap))

< > No assumption about bitmap size here

+		dqm->sdma_bitmap = ULLONG_MAX;

<> This assumes/fixes the max size. In that case why not make the earlier check also consistent?

+	else
+		dqm->sdma_bitmap = (BIT_ULL(num_sdma_queues) - 1);
+
+	num_xgmi_sdma_queues = get_num_xgmi_sdma_queues(dqm);
+	if (num_xgmi_sdma_queues >= BITS_PER_TYPE(dqm->xgmi_sdma_bitmap))
+		dqm->xgmi_sdma_bitmap = ULLONG_MAX;
+	else
+		dqm->xgmi_sdma_bitmap = (BIT_ULL(num_xgmi_sdma_queues) - 1);
 
 	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
 
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cc731ee10b10b4728138808d8df496648%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504853648191471%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=EpuPBBf03EMa0S7rOqI8JieOmcT3GvsnsQMaYujGgeY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
