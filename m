Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98448C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 16:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7FF64E85
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 16:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7FF64E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D5576EA9E;
	Wed, 24 Feb 2021 16:11:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD1746EA9E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 16:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nC2z4V+zIXjIrqBrQt5iymuyITKt6YQb5Ai/lDD57KNaDZyI9Vkxxm2sPsbAWotvlVPGumJneAmGcHNzPtvobi9Otve+6nUgXbW9FEuAn03oh25nFI59codFf+HqAoWBul/7RP2YccJ5DC4HIjpj62n9QgaVeCIZGJAoMeSAiWx5pqJLX/Jhd8Cg1n1dFjJGx6Besksnh1VPZSyDIkoiONCjj8h9GnXHocip1r3IYziCv/TQtIg0Nfte+R+5QcPhTtBfNyEJ50U2wZ9iA3DBtXNKlG7AeWxGl4AxAmGDO97oTloM+W+8EUbrv/snY1mdUYTfgzFmukYjFYwGPaT+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAL541yE1laBq0bPeKO1ST5SM8s/yI8/MlCkiCI3uLA=;
 b=kmQIoibEl0CK7BbZPLlNVCymkVhlZzE9nbuES/Ukoqor+IxxTY4Y+UiKxBmMEYxyt4VSrdVMbsqhKbyaeylebl2rfzagEzN4gKg6PeHkhxkz6wA2Ml8Ykjzm28VPirtzoLKcvwn8/4rrKiosx23yJaIZXj8b1sWocv+KWeiItmuh8d+GvIX7+TZibWPACKSu6NrxbicMlxj7JEvYKWanCs+O9aX4ufr6StiQN749piLQraZXZbyI59OlLkxd9n53PhpH9BU5aBdkpubrRY5AoHLGVasGjfLXRdfMB0xEX57mmDeqiWETM29Xum5WK0giSdcM4xdQnAxHG8i6TGTa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAL541yE1laBq0bPeKO1ST5SM8s/yI8/MlCkiCI3uLA=;
 b=qF6UVof0vv9S+OPQeRhmzwFzbHeZkH7xyhDCI5MwaESzewuxBUk6EFrBQXufR/1NGuGo7ciaRe/YH7jGBvEFHcWzTDUammM2YQd4wCmkk9d8CFdgtlX2YYPDX/l2cKuHbUuN0r3As9VJz0VCpCnGTo41ibBaud0zjbO5sE02se8=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 16:11:09 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Wed, 24 Feb 2021
 16:11:09 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 4/4] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXClQGSj1/f2bQNEWffNOHu6IFo6pnVWeAgAAjE4A=
Date: Wed, 24 Feb 2021 16:11:09 +0000
Message-ID: <DM6PR12MB3835082EE7AE9F006E5EBD9FF49F9@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210224022307.23521-1-shaoyun.liu@amd.com>
 <MN2PR12MB4549C9C9BA565812EA6BB03B979F9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549C9C9BA565812EA6BB03B979F9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-24T16:11:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6606fa3f-07f3-4f56-9b6c-66fe2e1e0596;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:c0d5:387b:19b:615f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85c0c5d6-d6d5-41a7-9fd3-08d8d8decc81
x-ms-traffictypediagnostic: DM6PR12MB2812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB281229EBFB670BF7B5249CACF49F9@DM6PR12MB2812.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDYV/TK81foxGkZzyzFsNLM1bgbwLoR//XpFVEWaBdiJo5n1ScRaZqCn2AeACmv8Kel+T993btjLjLxriO8jQSkgUfRIlNosiqeEgj9ZjNsLoJp1/vmfpw1mMqXabgf0GefQYSyHZYL8U2Z89W9P4pnnudKqZj6JUKLowAHZ5JrP0rycs936XvvPgnfvjr38FlWeL4F24nECMJXVRQdUSVSiDLEmd9j2f+uRQ4id2pBBHgqtP4p/wdSYmRyXD5Mrk7htym3ykc90vPYfCXuzpTuCrmXc+5iWLFGUbPVBw+gfW7IeY7EEIOCBH/dk33vJM5HpMMOYz8EGdFioOhBh2CJcH9XvvicXvB/glqagNRFTmn+8cKBwsYGt7LqRamM8tpGmDl5Vh7o+Jl8ni5g3kSFvz3AKmnB5WBTAVRUChYfr00qYYPjvfl0L9F7kjirrH2Bw6nl9omOJzKi5swEzdea3xKcBJpV9ar2wyvtiyANSwBCw1gZOlaBRukgtRnL4dnLiw7j5ntqJXBeGHsN1uMgNf1e4ssWy0CACDkfySoIli247TM6vk5ZF4kHAzjSzbv71jsZPzno2STSMJDrfcpgz0C1moww52THdMXnAl90=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(110136005)(83380400001)(478600001)(76116006)(52536014)(66556008)(6506007)(66946007)(64756008)(86362001)(66446008)(66476007)(53546011)(7696005)(316002)(5660300002)(966005)(186003)(2906002)(55016002)(8676002)(71200400001)(33656002)(9686003)(30864003)(45080400002)(8936002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0DB9yiD28xKQg12a2RvgtSLQpW4BNJa6UJuAt/jKWbRyMYZpUfHK2OPg4QM5?=
 =?us-ascii?Q?9O4AK9mxNf5MTAcztzaRTNztjH78gjMpTl5MHg9FYKkzKwHJdKEDDeJLbhuE?=
 =?us-ascii?Q?ZryGsAPwTDqtpxNIq/XALzciZcyPylqgrWlFG09MyYR9046govab0cTTXje1?=
 =?us-ascii?Q?TyDpOUJp1sy40wezMSfV1FMD7X1b5BYa6so0sVcJu7pVumucUeL3c0WLZOsN?=
 =?us-ascii?Q?xFOlRraxBjllRkDlNtx7KXBE9T+JfIjzlSvvNebkcHhPHqHRYY6xclksnkqf?=
 =?us-ascii?Q?5G+sDJIebchxk7NMzLHwX8EtfA1KZdblsgxBxx+K0+awWCaJzUlfkQlgXJpU?=
 =?us-ascii?Q?62iO5gjnBbq8pJWgVUmgPGWiU5f9Fi0PTYGYn2ngePCrn38DkbRCWGTiUxMQ?=
 =?us-ascii?Q?f9y+kDJUr3x+pZB6ANkHYQiNOWO/3KEAr5b46UN2x5AFadaRfYm4SF9lvuLg?=
 =?us-ascii?Q?8AOP75jinTJwqMzYo97xy3RPHVaeSJ6SYvNB15gItNwu3GeRtA9mmu5rgljs?=
 =?us-ascii?Q?lw2SvCtu9GPaTCxRnUrMoOqpCTyCiBXCOTfPi5+Yji3DRGOr7LgcK/AE5Ydf?=
 =?us-ascii?Q?zDUKdi1glMj2H9iwPwRHG4iMif+MQRXF7166XYAWhSi/iA2URloyl81fqhD4?=
 =?us-ascii?Q?CnvpapFH5T8+Z530B4Xo/ldwyf3vh0ppL7RmKiAh387KwFawWSZQV00H0hbL?=
 =?us-ascii?Q?ccvuhzMX3QtPLZgZ/PyEce051MDwFN6wP8vAu19BwWtChhMkzAcgaW6LF6Jg?=
 =?us-ascii?Q?8ocIySxiaBie9ybCnpx/qTC0ImgBUWoaTwdsK5PUW1iRr3FawZTexCzQiW3Q?=
 =?us-ascii?Q?IGuIriK9L67O32HACCg/ZODLSwPcpBesdODef2Kgk5tSuAoGc0Qr2CgZ84n+?=
 =?us-ascii?Q?Lcn0QQnOli3E1lkMWZybCy25rqvEXZLL5fXL8IxAvCnQOa3wBr39GueHbEbe?=
 =?us-ascii?Q?mg1DUhlxsCKCXTn8jyzhXOpQrodQHA0UkjNuCom38TeVWZfPs1/MOW8ntbi4?=
 =?us-ascii?Q?UdMrV2l5eV8KHXe0vx0ldmbCWPm4+PndEzzeELY12WHeVp01h5qmmIhooUb0?=
 =?us-ascii?Q?T4AHc+JfENgSso7SKmNbxqTgO2jUIvs6RDsJBOPZfE289QI1eefGkr+6vRqS?=
 =?us-ascii?Q?lpUGyqKLU8XcC0nbZnHnmbqk0DzKPJQDaHtrE5bmaMVh2uY13s8VUYaYydUh?=
 =?us-ascii?Q?xximKXjjKx4+nxnMqdm0EJZdUxXRRDbM9A2EOhZwqOMSDjmCbQkygWnw+gO4?=
 =?us-ascii?Q?FcecFSsoCTI8Xi/ZbVjFTmeDK5vJ9HqdCNRkPkh6qnuE0yK3tuVqV56f7mhB?=
 =?us-ascii?Q?Q3e9A6LJ3Yu6s3lLGOyEQMdTgmEGewXQEYok7w2teinWIoJLem/0+dBlka/s?=
 =?us-ascii?Q?NSUihrGs/tsv9JWKl3IUtfZPlJN1?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c0c5d6-d6d5-41a7-9fd3-08d8d8decc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 16:11:09.7202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLoajJNsEqPFFn6aj3aysDakAG4qTtExc1Xcx2arv27i4c8yagwXahwmcqMu6V3LdI+/CGtB0ZgIs3SLFrzGhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

SBR happens on hypervisior begin to start the VM . I think the purpose is hypervisior try to reset the device in a clean state  before the VM starts.  The  specific issue for XGMI is  HW requires all GPUS belongs to the hive need to be reset within a limit time slot but SBR can not guarantee that  .  For none-XGMI  configuration , there is no this requirement , SBR can reset  the GPU  correctly . 

Regards
Shaoyun.liu

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Wednesday, February 24, 2021 8:58 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

[AMD Public Use]

Hi Shaoyun,

If this is SBR happening during device init, how different is the handling from the normal passthrough case without XGMI. Shouldn't the minimal init be done and reset performed in such a case also? Wondering why this is specific to "xgmi.pending_reset". In case of XGMI, wouldn't this cause issues if other devices in hive are reset without HV knowledge?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Wednesday, February 24, 2021 7:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

In passthrough configuration, hypervisior will trigger the SBR(Secondary bus reset) to the devices without sync to each other. This could cause device hang since for XGMI configuration, all the devices within the hive need to be reset at a limit time slot. This serial of patches try to solve this issue by co-operate with new SMU which will only do minimum house keeping to response the SBR request but don't do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time with existing gpu_recovery routine.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  6 +-
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 420ef08a51b5..ae8be6d813a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 		}
 	}
 
+	/* Don't post if we need to reset whole hive on init */
+	if (adev->gmc.xgmi.pending_reset)
+		return false;
+
 	if (adev->has_hw_reset) {
 		adev->has_hw_reset = false;
 		return true;
@@ -2147,6 +2151,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!adev->ip_blocks[i].status.sw)
+				continue;
+
 			/* no need to do the fw loading again if already done*/
 			if (adev->ip_blocks[i].status.hw == true)
 				break;
@@ -2287,7 +2294,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
-	amdgpu_amdkfd_device_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -2731,6 +2741,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = false;
 			continue;
 		}
+
+		/* skip unnecessary suspend if we do not initialize them yet */
+		if (adev->gmc.xgmi.pending_reset &&
+		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
+			adev->ip_blocks[i].status.hw = false;
+			continue;
+		}
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
@@ -3402,10 +3422,29 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 *  E.g., driver was not cleanly unloaded previously, etc.
 	 */
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
-		r = amdgpu_asic_reset(adev);
-		if (r) {
-			dev_err(adev->dev, "asic reset on init failed\n");
-			goto failed;
+		if (adev->gmc.xgmi.num_physical_nodes) {
+			dev_info(adev->dev, "Pending hive reset.\n");
+			adev->gmc.xgmi.pending_reset = true;
+			/* Only need to init necessary block for SMU to handle the reset */
+			for (i = 0; i < adev->num_ip_blocks; i++) {
+				if (!adev->ip_blocks[i].status.valid)
+					continue;
+				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
+					DRM_DEBUG("IP %s disabed for hw_init.\n",
+						adev->ip_blocks[i].version->funcs->name);
+					adev->ip_blocks[i].status.hw = true;
+				}
+			}
+		} else {
+			r = amdgpu_asic_reset(adev);
+			if (r) {
+				dev_err(adev->dev, "asic reset on init failed\n");
+				goto failed;
+			}
 		}
 	}
 
@@ -3536,19 +3575,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable clockgating, etc. after ib tests, etc. since some blocks require
 	 * explicit gating rather than handling it automatically.
 	 */
-	r = amdgpu_device_ip_late_init(adev);
-	if (r) {
-		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
-		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
-		goto failed;
+	if (!adev->gmc.xgmi.pending_reset) {
+		r = amdgpu_device_ip_late_init(adev);
+		if (r) {
+			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
+			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
+			goto failed;
+		}
+		/* must succeed. */
+		amdgpu_ras_resume(adev);
+		queue_delayed_work(system_wq, &adev->delayed_init_work,
+				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	/* must succeed. */
-	amdgpu_ras_resume(adev);
-
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
-			   msecs_to_jiffies(AMDGPU_RESUME_MS));
-
 	if (amdgpu_sriov_vf(adev))
 		flush_delayed_work(&adev->delayed_init_work);
 
@@ -3565,6 +3604,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	if (adev->gmc.xgmi.pending_reset) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
+		if (atomic_read(&hive->number_devices) ==
+		    adev->gmc.xgmi.num_physical_nodes) {
+			/* Trigger hive reset when all gpus within the hive is ready */
+			dev_info(adev->dev, "Trigger XGMI reset during init.\n");
+			amdgpu_device_gpu_recover(adev, NULL);
+		}
+		amdgpu_put_xgmi_hive(hive);
+	}
+
 	return 0;
 
 failed:
@@ -4241,7 +4292,9 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
-	amdgpu_debugfs_wait_dump(adev);
+	/* no need to dump if device is not in good state during probe period */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_debugfs_wait_dump(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
@@ -4304,6 +4357,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
@@ -4343,10 +4397,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
-			if (amdgpu_device_asic_init(tmp_adev))
+			r = amdgpu_device_asic_init(tmp_adev);
+			if (r) {
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
-
-			if (!r) {
+			} else {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
@@ -4797,6 +4851,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
+		/* enable buffer function after reset */
+		amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 	}
 
 skip_recovery:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index aa0c83776ce0..8c71d84a2fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -149,6 +149,7 @@ struct amdgpu_xgmi {
 	struct list_head head;
 	bool supported;
 	struct ras_common_if *ras_if;
+	bool pending_reset;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 839917eb7bc3..cb59facba17a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2261,6 +2261,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		goto failed;
 	}
 
+	/* Don't do the real PSP HW init if we are pending on XGMI reset.
+	 * The above init probably should move to psp_sw_init
+	 */
+	if (adev->gmc.xgmi.pending_reset)
+		return 0;
+
 skip_memalloc:
 	ret = psp_hw_start(psp);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385b27b5..b1c8fd90c1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp);
 		if (ret) {
 			dev_err(adev->dev,
@@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
 			if (tmp_adev != adev) {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C4984d6b147c74129b4ca08d8d86b2aca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637497302087638243%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ITXvs4vUbDxQYsXrUeDHS3Jpd6dwrcmevvGdXT%2BwLTQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
