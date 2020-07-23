Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EE4C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 03:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD018206F4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 03:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EXaQJKoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD018206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AE86E3BC;
	Thu, 23 Jul 2020 03:52:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2CF6E356
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 03:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXV4aLAmUFrMkGVR3K8Wi/JbDQZfOGmMqIbJ2FDAbmlmaJNK4aLjyc9MZv7Jnvc+NNiuCuWn8MMD8ayTjkYcrvC0Y+WIdhehtBWmDzxldVr+yGSCkdr9ZvsVpg+jwVDJyZb4qmxK7Sns+h4sIkIgPpIaYHn3DfJRDDatM+SbXZC+QYNo/+6q1Be89FOGASCQ57+/dIxkHfphKkf/NFNDoO6vFXjInYoaIVD2nPESZ3pRaodFd1PKWniNYfavytq6BbF/LvDBNVS7GPOEal2ik0Ng9+JeiX+DMkVdPo0iwHFHVj0aMAGe7TnOhlAg54ekvPX+q4v4uvqOKKuShJqbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elk3acjJibCroYttIFIEnJsf/9UKL1ck4+tEwfZJ668=;
 b=DK3gf4nq6E801FkAw6Hn22NfdRcAm0N9e1mvmvIJCniFPPPHhtSgoZwhfom+vYts6N0xkOQDgX62CrR6gesO8NZQO3OATDNgtaNQpB9KwKw0vDzagJT8SudSYXMpScStYgkRj31bvpsWz3W3Qs4JO2APMxIm2HjVHW9BgT6N8mSO362EQRDoASf9Q62IywNn2pAZjXEp8NAmLrHajAqWTP+vPuaPPQY+WxfbnD2EIhP2anwiAs9PC0ZBV3658rwWDbYzQnsP8SWjVa7+ZhXeQq1+BsU3e9X8yknM4hiXBcGFWLKX+635xGLxPrShO9Gm3JDARF0rsogqxxKzu+/Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elk3acjJibCroYttIFIEnJsf/9UKL1ck4+tEwfZJ668=;
 b=EXaQJKoyMYzJhJ3UHAOSmxF3t1zSKKJchnfye7+Gbw+XOAZlm4t6ExRXZ1FUUvPxXyKGyVpptwZPt0l81kmroAzItnQ+yfM7VleXErWYTr7E6FzdGXTcflxwoSHADykP7/Ku0lMMjOA5q48X1lrBTHk9d2O8GhOH8zPGHXlmHXY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3276.namprd12.prod.outlook.com (2603:10b6:5:15e::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Thu, 23 Jul 2020 03:52:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 03:52:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: add msg map for mode1 reset
Thread-Topic: [PATCH] drm/amd/powerplay: add msg map for mode1 reset
Thread-Index: AQHWXx65HEsgJixQyUmtideGdmf3LakRrkaAgALbR2A=
Date: Thu, 23 Jul 2020 03:52:10 +0000
Message-ID: <DM6PR12MB2619DEDB5B63025999F45711E4760@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200721052039.1246295-1-likun.gao@amd.com>
 <CY4PR12MB127017AB5F12A8DFE3F02CF78C780@CY4PR12MB1270.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB127017AB5F12A8DFE3F02CF78C780@CY4PR12MB1270.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-21T08:09:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=972a73fd-3240-4974-9a42-00005af50b0d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee22954d-241f-4a09-323c-08d82ebbc738
x-ms-traffictypediagnostic: DM6PR12MB3276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB327673364C9AD9A1F4552154E4760@DM6PR12MB3276.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yb69xbPIyjfDVFDrV8DYVPKV/vHAz1vFrOV+qJd/v0ckDVtxhfowl+E9SpDpXauEJWyP7fq0NuR7qRQpL+XVkwep4kk1PXcQcwrxWC0RiXAhkLZYtvApljXieLBZzxrzXvtlSICZ7Ww1+kZw0hi4ELHRt1e0eAR7fEFnJrFU/Yms28ZyiaSooM1yZDnsV/IuxljRcSk1RAWLlChii9SIVTTsejGd4XfbYw3JpOLGIJnRrWTdhQxRdYlXnWb5U5uBA6zYyjjfwqb7G9UQxTPvHAPkiMNjEUrXyDsO2jv4X4z8STskRwHnytb720+5MdqH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(66946007)(76116006)(33656002)(8936002)(186003)(55016002)(26005)(9686003)(5660300002)(8676002)(71200400001)(6506007)(53546011)(86362001)(66556008)(52536014)(110136005)(7696005)(316002)(478600001)(2906002)(66476007)(64756008)(83380400001)(66446008)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Wa96Ij9Z072iSb1DDJfghfpBTjkRCEfQwZEGLoQpmAs24nqk9+4VV3u8xV76ktiIoIMk81mJIhfXkr/49vx1jKqCVaVNFRjQ0jASf7TvZYCs2k3QhTUKDzgElXpLmg9uu/+nF4wAjMdIQfkh9DAwrxD5cOq6DMdyPRUgzlTlEuK/OYi2cJA+P1F70SerJuw+b6F2iie0lNYiT47Wd1etfBiK0bQOETghHw/ONzhVuFO89AsRLxY1U4ztC+ApDV3uSCx5S0x6oyMUyOZ0ulF2X9VMKcpqUj4yIfQtpDtnG49VJ8coykPwIBMDXL9UTWFAii3Zsm39OuXwhoicwAP2f0Mif2MRwANnZ1By0Nt9KWBZLlJrMqhFdsTU0pM6a9fZX6WpEA/lJdAuGgKbiqSoTpJjLp08v5zsk6hBoqjXqEt6RUd4FDGXBikjvSwDKh8x7m3VYi572LjusjdmJwodsnXK22hj4RPZKYlVdfXdlNxwO0AZUKHwEhXGGpNV6PKz
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee22954d-241f-4a09-323c-08d82ebbc738
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 03:52:10.7796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28kFU3zUBIbeUiHNVbjg4v+pLrWgFYQaanZw+tgdkPkxH/EPPsos0X6iH2PUh3Vq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3276
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's Ok to have the valid_in_vf setting as  1 for now.
As I know the sriov support for sienna_cichlid is not ready now.
We can revise these when that comes.

Reviewed-by: Evan Quan <evan.quan@amd.com>

BR,
Evan
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Tuesday, July 21, 2020 4:09 PM
To: Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: add msg map for mode1 reset

[AMD Official Use Only - Internal Distribution Only]

Commit : 81a5f33903a30574 has already contains this change, not sure why it disappear in current branch.

And does it make sense to set valid_in_vf to be true? Mode1 reset shouldn't be supported  in vf mode I  think.

Brs
Wenhui
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Tuesday, July 21, 2020 1:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: add msg map for mode1 reset

From: Likun Gao <Likun.Gao@amd.com>

Mapping Mode1Reset message for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I9b8d39b10c7723af4589577fdbfa4acd5af6e85d
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index cae8e776fafe..bf3d6bbba930 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -118,6 +118,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               1),
 	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              1),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       1),
+	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       1),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
