Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D660C83003
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C53A20733
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QvjEuQk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C53A20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B089F6E111;
	Thu, 30 Apr 2020 02:44:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3BDF6E111
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 02:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiYp+JqB4noenjsZ0Fp/4ZIRqlsTXml2cz227R9VndPo29v8dOCiHIE/0X0lVE/bgh6KCJQa0CFNXZZAnnZY4JqDUKGjHrIPlipQhxQpf/QM5fqYlwwI6fk4NefoTMwSu7d8/7mBW2KE7OxMa7xBe5vI73XypSu1DL1s2AaNrqkM5xbRtZvcuvLbexnpe3XZBHg+XzAd3O150o8JfiKklPC0YE1D8bSJZGINN5ic6OUv6lIWLUja64mxPCBGjSS+bvm4YLBguhCWvtwx3pmNHPSwD94uBFbYdGFyHUXXn3eRHgJdEyyqUo7RW3E/IrxI2wVhezOSzdgIkZAjDSdFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUqjS4I0omeTESeuYkJvTknWaWOIDcLfzYm9/bzVL0M=;
 b=F867yEVC6hn5RlJi8jxZMMTXvCk5FzZEQIbi4+8o4J6doiHf0Fs5oBR4D5XeWUiFpFnJIyzTpIdUE6rtFsZiqDFo97+Tzd0xfkOEkzAyqYRFKwFD2jquGmtcHEXlBNHZD1WvTCA6mbrEWHIJ5u8gwFIXARNfAd33BcmTNFXj2wByNJVN5jtw+FNRBWcVeXODL1FNS+6eHyuhEhQ7ODkMxyIIiFBAkeiDlTza9mO/sI7fmy67mLxMqGUWFdx0gbPpOQ0rp0q+0yHwZSzEpIF5m6k9VnQ7Ru6/dnbEqchxVKX3hayJ0/1XtgKusfWdQNXMhZMtbWJ+EFoGp9WLLvzOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUqjS4I0omeTESeuYkJvTknWaWOIDcLfzYm9/bzVL0M=;
 b=QvjEuQk6/rGJ/SZ8kYlSydud9BcQ03AlBOwsfMIyD5NteVMP2WRgynuohw5AvFk7rvGoY2y4/5Bxd6pdJdcKH0EPuMBQeD9Irovl9CPJiD+WN61XvRM+kgflfgBZg5VJPgow+Xe9WqH64lbnhxaJYJ6Ql3TGLaTrr2c6G56M490=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19; Thu, 30 Apr 2020 02:44:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 02:44:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
Thread-Index: AQHWHLObWE3uFYDglkWBZzx5UqxNS6iQ+LaQ
Date: Thu, 30 Apr 2020 02:44:15 +0000
Message-ID: <DM6PR12MB26193AC385A77F3E6BF7D647E4AA0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200427164735.27409-1-kent.russell@amd.com>
In-Reply-To: <20200427164735.27409-1-kent.russell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5ec7ee91-7a13-4794-a9b0-00007d8ca3dd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-30T02:42:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fff16551-224d-4065-bf0a-08d7ecb05fbd
x-ms-traffictypediagnostic: DM6PR12MB4433:|DM6PR12MB4433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4433F338C81FCC71E59FCFBFE4AA0@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9r0RLxK58J+S0poWGoJX9e85xJRST6e9D3qLseSaMWjIGm2QGhSEnlxVqfmV/I0TFx2roKk+0dsvAWgEIRZ4gi0HrcbgPerUWgst4amOLYh+w8v73FBJPuuZs3DWx1MPiODdbiCq+JgxkFq6SrDmebcQr92AyVqoGkbO5hMTL/CvFnA5ubUCs7NzRt1naocdR7YIVNe72WJi4ZImE7wVwmRM4/uVxUdUjPvHOPS5TEyW2D9AihZX28RlqOFGOLMNM/FdO73NaGjui6zgf4qvO9DMhCO+6yk0Fvs9MFshmk5GB/Fx86eX5VLQ5/wydrvWdYVIALzBq0AOhIcfuaigh4aXshx2mVlJRKrd1EUI/+cvC/+g3Q1k3SYFDEe0Z+HS7r5lXUAo9pxYvqVFQh25iiLi9IyRxFsVYyPz49i7bbrDg5AQZCRqdMwWL5P+PqvQhTMGu/43DiuEQ18BYfHhyn5jtU7zahtjsaMrrz8WgVs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(45080400002)(316002)(110136005)(478600001)(71200400001)(33656002)(64756008)(66946007)(8936002)(66476007)(66446008)(8676002)(76116006)(66556008)(53546011)(52536014)(966005)(19627235002)(2906002)(6506007)(4326008)(5660300002)(7696005)(55016002)(9686003)(186003)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NON/VrcKmAZAJhE674vsnnvT1Au6fmvISeFpAHUCc22sFF5OAJabJgqW5114b1JYJl2LIkiF6jmo7RlG9bAcB3jKC618wRMfqYLbuWi05KHWMMUJmSdfsS9Zt40T8FFvrIFqwjy61CQ+egh3B+DtD1QUA6izyROGL4mTmavD59LEehQmb5WilFAtzPqXJtbaEv88LpawYiFntIF4DFNWhFZa/qHhff+gyQjVSbsS9WIxpprGOYldAJkV7GuSVpfO1aDaKvTH4B7htajpkutYVgiae1xOepGmLqyLsVpLH40tN0Rbh0FUZKLFChJtC/E0RL18O5D4t3X4g0wiyHY4NHegRkL4eaeBVK6UbDafCNnyxH/T6KfioJvtjx71UmzVzeJdnIA2kA+tSUMQS0NIhXM5Zm3dxV2K/GUDWvZZ+ksKgEmmbMPMBdGqzYlhyTwmF4+m+fO137enhKwuRBefYrBduesJ1iEb/LolEW1e2QeRkI0PQsG1ZI56dQ2cqCfGuDk6dOxctHG/VGWpwPxSyvi6Ae7iwU1vgbMa+Dig90KR1mtzQ3ohn/R8sfKhnRkmMsyMaQtzk613UBmjV3UTwWqS0quX2OP5AEEWFpd/QdGfPdAWx6PQGjAXicNmACL8E0DcmSF1pu/4g7cf6vlPWtswVAunxynYURgKiYegm12ovLluOM1KVndyujdM2IS7r50BHij70KOUKZmQ1f7IDhBtin1NSwJ6g4jyAJW5cYf9WBB7w8lGGht6TOjyl1Xyy7uLeijTxjNNMZ5Wb7gCaqUm+l3zH+udM0ryHYaw8VA=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff16551-224d-4065-bf0a-08d7ecb05fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 02:44:15.9472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGWyHUhkPe+Yfods1OOR96iHhMUbtMaKklKXLDKzYD50vXkHLG9J/7mVhQXbZGAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Russell
Sent: Tuesday, April 28, 2020 12:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus

Add the ReadSerial definitions for Arcturus to the arcturus_ppsmc.h
header for use with unique_id

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I71849ec381730b1803e54cd6040aa3b245b53de8
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 ++
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1c66b7d7139c..e98d92ec1eac 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -128,6 +128,8 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_message_map[SMU_MSG_MAX_COUNT]
 MSG_MAP(SetXgmiMode,     PPSMC_MSG_SetXgmiMode),
 MSG_MAP(SetMemoryChannelEnable,     PPSMC_MSG_SetMemoryChannelEnable),
 MSG_MAP(DFCstateControl,     PPSMC_MSG_DFCstateControl),
+MSG_MAP(ReadSerialNumTop32,     PPSMC_MSG_ReadSerialNumTop32),
+MSG_MAP(ReadSerialNumBottom32,     PPSMC_MSG_ReadSerialNumBottom32),
 };

 static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
index f736d773f9d6..b426be7c76c6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
@@ -116,6 +116,9 @@
 #define PPSMC_MSG_DFCstateControl 0x3B
 #define PPSMC_Message_Count 0x3C

+#define PPSMC_MSG_ReadSerialNumTop32 0x49
+#define PPSMC_MSG_ReadSerialNumBottom32 0x4A
+
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
 #pragma pack(pop)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cc2675663f55d426a634108d7eacab850%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637236028782497186&amp;sdata=ezFXnyPtAUvbkwhWr54gHggH7ejxxCeAtvxjWx9e2UI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
