Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0292AC47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A31613B1
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A31613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5A66F4B6;
	Thu,  3 Jun 2021 15:31:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF29B6F4B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7HmqMGj74n8Ko+QljZPaiT58dhO4NckrYiHIhticTX5MDTg+PeruLPVrsety+n+BWNs2Ov6jLEnIoS7FdJFrwHyJHEGxLveyLx4lU+KDi/S/l8OM0WJKjoHq9SzjATB5bdXcCH8yIjxtN443w3IYUvfPZuPb5OvJ8XW0q16h/mCL1xiMMAaPUmwCNm3JA0ZWwfo7vLmYWCGZ6mHbl1hd9/MMyhdnbGSeM/qNdjBcZBugSSJ1GEKJ7hxL8LgZq09k2r+E+nL9RZ/ri/0/Dd2860bzcEPB61Kj95N8r9JWQ5dmy4VgqpCZaKsqUBJhk1OhHAop+uf7oYWwte1YjR+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnNdRDIhjIS0Aoxgn1Pp22TODA6X1pxDllLlxl55qMg=;
 b=E7uFWo3nwEyUFi3klI2S8dUntbHrt1kFNUO9V3mCwIsdXcinlKIlNxcD0upRfwygi41dYtdFBmoT+c3j5msgoIu1mICxj0guuxi41x2YCy5xZG9Us/ruJDMWQb/3oDEIxRQ7s41QQPB4a/bD/+7+2JJFIfEXfBJyYzY6ydQsoF46fvKrcfE1Ki4UM61fI68UPMRXdIdmM5X46lfxLxjuaq9lgPP9X5YISCBm9s7ifeQQredT4hMYccw1VNsAqhWiiA/1zuXsYWP0tsjKpSo/TEMcGb8FMX45oM/mGpspDGcp2oD53tGYCs3IQnUXu+M7MIgDtxn5q7OTdopB5iyFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnNdRDIhjIS0Aoxgn1Pp22TODA6X1pxDllLlxl55qMg=;
 b=xZeDwEnBNdyYu3oplP0YRL6q0xVmd9agYQ3bEis7YThNHMSBkJ7ydK1BvFmhG290JXPBOb4180DycWyw447FVNbvs6J85XOJ3Fc6C6RQF7fzY2kaE56fLELAcDxqO/j1GQO1BitKudfksG6hbqTgwo6788W+IZV7eB2Wu+G67mE=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 15:31:39 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31%6]) with mapi id 15.20.4195.022; Thu, 3 Jun 2021
 15:31:39 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Thread-Topic: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Thread-Index: AQHXWIKfcL3O3knLbk2rT6fkgWUYlKsCZMYAgAAEp9A=
Date: Thu, 3 Jun 2021 15:31:39 +0000
Message-ID: <BL1PR12MB53179B09844D1195B7DB3B47F13C9@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-4-zhigang.luo@amd.com>
 <DM6PR12MB55344CFCAD9394BC48B36665F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB55344CFCAD9394BC48B36665F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:12:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=537b63f2-7f85-4b82-902d-0032578406c4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d945a86-540a-4314-733c-08d926a4ae98
x-ms-traffictypediagnostic: BL1PR12MB5063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB50634CC805B541FF24DEAAE3F13C9@BL1PR12MB5063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCeIdOVRmvLpWtvnAoWgQ2d6e4tqS2VmEMyU0+sfgkf8gcQ8ytQrbHbbEwKB4R+weqB7RBPaucbHmXb9zdEJSkB9m1J5O7ZeQHr+B7RYYGhUiHeUPdoM/EUh0aV3qdRt7d/vNrB33Xi1S1KSdgTR6KBSLmUWHkTzMpxrhy/owg26Jvmof7qGjhJ/9Zfa63Yej5RnvKFu70tv0owFzUAgo84IbS95BgCBiz3wuOMu9TMLgNXtl8vSB75cMgi0JFpLgsIM3B3PWi0NrYsy1IVTmZ/NJTiLC4Fkt4n2zGAVWKoPbU7RZyOs98HpqfAMx6Z7l+gPNg+Ph4ndZFvnk46g9JAy/mfm8uxdG5AqcDQzwYMxw/EM7SZlX9YMQE7X8/AVoXvMz+0POQW+k5C2ZT0k0npMfaBmrVzJjGg7Nud9yxCo/LewDGuec2JYH2K6gyNssj+nc37RdmMBdxG0XkaR0YZgaJqLxQFoIbViPmP7bpBc674KKM0AxMPB6VPSDbMywhIsdkj/69JXIYvfZmakEbZ3ujI4ujZ5icUnD9fRi5XnXjDUn6XfCg3ym/E1CNH/wcHC7BmmJDZhpqDaE1scmccpggHEA4q4PvvU/tsYbS5jtd0o+a/fNlnHAAW0QjuwTgkg0czXHSkE7uopzGMU2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(71200400001)(33656002)(478600001)(2906002)(45080400002)(966005)(52536014)(8936002)(8676002)(83380400001)(316002)(38100700002)(186003)(66476007)(66556008)(64756008)(66946007)(55016002)(66446008)(76116006)(110136005)(6506007)(53546011)(7696005)(122000001)(86362001)(9686003)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GDF2EtwVlCPFFww7Yxj2PKXIT57/DT3Shv68ws3H0da9scfdiKbzKqv5vpqL?=
 =?us-ascii?Q?cji0SVqbObGAioIMtDJNEH75JC/M1VoGdhDu/Mua8pdRPymzFUktkWm9n/Ol?=
 =?us-ascii?Q?0YiopMrkyUqliFeTBBdvkQfHzpx2y8k4ZhWEMPFzST6RgzT4hkoRU+Du6nnm?=
 =?us-ascii?Q?Z14FYMizb5mwUTMMuMDvuEscVrzBNotghMTfonXXbTQrLoHAsX6Wvwfalymu?=
 =?us-ascii?Q?LzeaVHzHHzjrCkcRVo07MbYOrz+egLxB5kKT8WWi30maRvGPJoT88ZNCMZ2O?=
 =?us-ascii?Q?xBKzo/ux557jfkR7hKuNBGiysiT9JNh8Ug+wrDTow9mUtHnVAE1vkf4mFxA7?=
 =?us-ascii?Q?t4Sj+je6zol91fXbw5oslpu/LPnaqbWwfiOqRourUB/8KnHq6nsGdT1PSf0b?=
 =?us-ascii?Q?4HPVhMYLymA9XfnLyaR0cUlLlQzgCJB9nh2e4A8yDYxS2qAhqgWmZbYxVIyO?=
 =?us-ascii?Q?Bj+WTTKaAfThOGHuWMdj2DnZUC/pwMzxPPlTTsFjoFzLdtBubT2jfx9NG6uA?=
 =?us-ascii?Q?FlNKW3p6U0lHgxWgCVOMkbb3kdjyknlFluGKN318D7kowTkwEMG+KNblgBfJ?=
 =?us-ascii?Q?76l7N4EKnN+2uo8zHmLihCu4AIejzM6U6mHTwZgcs1vLh01t0uBCHpP3gSxb?=
 =?us-ascii?Q?Argn6IDCz5HOjlYc4GkNeEPeZPMxJP+/NkQQyl0hBIdbnXf0YSwAKwnPQcSK?=
 =?us-ascii?Q?a9ofinnvT91iyl8mB2PMdoK3gx6Rfwqh7vR3VyTDIM+4KtpnkVihyTeyLXxe?=
 =?us-ascii?Q?Z3+6O8I/88zxEIskk6eN3QnbkD6i9lFjYo87w1HFioy52NDMZVxZYGOkabC3?=
 =?us-ascii?Q?b9bvmbwod+ShSxp7S7yFWYAyizIsyBwZqsrbgNLq6URe7t8+GMYAOOCdJqKS?=
 =?us-ascii?Q?OZh2p9IktQlppT43DlRnvI29Vp8fPv2PYyb5tQ0EhUCR6uC8SlIxn8gLBV58?=
 =?us-ascii?Q?8mDX5a/yXlQbQhowJlo1cAY6VNDyxsuwnpeAHwF+ESgUaqWKO8klKxkmmYX3?=
 =?us-ascii?Q?zVyb7WGUWM6pGQp/3JlF6TXfgKcbZI936GqJP8CG8qz4xYCY2iK29WhKjD2u?=
 =?us-ascii?Q?w44LRBLUwG+wkMjXk47aoo2F4gTPgLFfEKv27xGMMpQIr85jHoV/kNkQP80s?=
 =?us-ascii?Q?djP3FFv8zjecDsrrtj6ExojNd7qfdtP45YpIXuvRakQ0u9CoJt+mLX53D0+e?=
 =?us-ascii?Q?/m9xEpKmXqUNH7kETx0QsyIXr1BuKQDXff6t7TLA4dY8gW2RrdEzeYuDC+vu?=
 =?us-ascii?Q?+tG/YzvTU/kFf16LoMXX7ePNGN41uPoZ8As3rMmE2M6njHYSKZlHIo+9xPGG?=
 =?us-ascii?Q?5ZU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d945a86-540a-4314-733c-08d926a4ae98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 15:31:39.4309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avicTV6x6iRf8ujLILXmx5Ac4c3ofXmpZy0W3dTCqNbdD3x85uOu9sSwap2t7UEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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

Yeah, it will also init psp sos and asd mircrocode. But I think it's harmless.

Thanks,
Zhigang

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: June 3, 2021 11:13 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

[AMD Official Use Only]

This one  doesn't looks apply to  XGMI TA  only , it's for whole PSP init , can  you double check it ? 


Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

need to load xgmi ta for arcturus and aldebaran sriov vf.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..6bd7e39c3e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -170,7 +170,8 @@ static int psp_sw_init(void *handle)
 	struct psp_context *psp = &adev->psp;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type == CHIP_ALDEBARAN) || (!amdgpu_sriov_vf(adev))) {
 		ret = psp_init_microcode(psp);
 		if (ret) {
 			DRM_ERROR("Failed to load psp firmware!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C7568bce040b840a5a20508d92699c7ee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264190861368%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZL8oC97Rnltg0gbqc8AUqnZS%2BEuUSq8%2FDFngzjjFtbI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
