Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93E4C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB3961029
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB3961029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207CA6EC67;
	Thu,  1 Apr 2021 06:03:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B73E6EC63
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 06:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch9DH7EgC9noH5fy+e2pXpjUGoMlnDwUDRmHRk1kTFWJ73uoXSLvv+j8GkNnSjeE4tN9wFV+fcAXF4CBQjsH34xLueBQr5tySEx8JFpWXpz1mkSFjRSZeoHujMK0NVk+ST+wrR7g6Li11QjBAHVQBtL9yygGTy6kc8PdH2Tjyxxu8Q1v7w4Zp7zVg4j9xtFrSLsgW0Tzj6oqSzspI+RGlX55+ZHgiFUyVLPSbzdL26pYMoBTU8JtNRyBh6/93fxdjZYd7i1dCDP71oRxODroC6W4f0DzDfhAjmlLpgxvjSLhgNYw8N63UoiNGqNR1kn20S6u9MQIlqjMy9bcBQHO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4ZsYr7TiCVgYjEhzIAsonbhiFEH1fB8V+msdxDSCbU=;
 b=J1J8JsA1FmmSRppWlJX+cViHaVtz8eJa8ikSi0xBXq8hIxdLWsQSVQhcanZELUR9bmj+VkadJER9D3Mf6JZh/run9o34tAToRwVEYdPAvPsni8S9hf0W+gE43NC9LLvA+Ybd8kek0tr2VdDkDcQtfRNHmGFW5JqNTU3P6mkN5zLcZMc8S3Z9gxttl+rjwOyb/sExz73T7GdbvzsIjaOCOK2b0NvMFvfRZYsJ9IRPcd4/hE3YTgk3b+JtPCeUyYeLHxIBIpZSgX0c9GIO6JjhPC1vZzPXV+GK3TkJPDXhIbhlYZfHIRnWFyU43rvYUOnMGeBaw9WGoaBkOKbrGpv1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4ZsYr7TiCVgYjEhzIAsonbhiFEH1fB8V+msdxDSCbU=;
 b=vE5T9e1yhBtXBaAr8A/HHt4+u87F01hKFx74ah5kY9BihZ0ZKOFQ6k/pFE122QkJAaKx6cb3/mVU22gz6ZSI1t45H0XmyZ6OVqC1q9grAQw0zoEslCXTgB3R90Q2QVFA6vS1F+aWaL+QllI6Ke2IXxKSl/5lStvgbKMf74F28d4=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 1 Apr
 2021 06:03:03 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 06:03:03 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov navi12
Thread-Topic: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov navi12
Thread-Index: AQHXJR8Bp6NJPWAUI0egesokufsMSKqdzlxwgAFgj/A=
Date: Thu, 1 Apr 2021 06:03:03 +0000
Message-ID: <BY5PR12MB4115344371E52389B0BBEC958F7B9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <BY5PR12MB4115F835283344FDA725BA178F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115F835283344FDA725BA178F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b43f1b08-2b8a-4700-8258-aae3ce376974;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:00:30Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac3745dc-e762-4e60-70fd-08d8f4d3cfd0
x-ms-traffictypediagnostic: BY5PR12MB4132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4132A11B9C89341FFE276E928F7B9@BY5PR12MB4132.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Si6jBBkfn31nXJoffJsXXIlyLUWveSWp6EqgAhNIACdo6HgnCCtm3sVxphJhecQv8JwpGvoa224QPzKA6txEB1FvuhNQyntXk3ehBtg/5ALY4Kv8sjxp+CmtxSZVGKOKOBsifdS9bvqpxSpSMLFAp/+vawRt48wIgSgG9SDKbQt3vpJUSix8fjoQvGVHr5FabivfPtRlCHPMKCFIXmHU6dzI16BIQs4ns8arZcIyR6NJcE/DdKIJ6Evn9jqq3alOfW8oM4bYt+cjAx+nochu0qJ4mW54nTbY1yn/3jqbwhR703r8dPyIUAQit2Y3zuNYR8kcfy2AElbYm4ZkFkGGJaPkDgSaPQtI1vclCKqaYwP+63gesIJ1PredZveR4cBpGMFAuXVlbUbF6bthUeV91Jt9jw3NtpfLaNCz8c9h7B1RDxqJYEOWQMMk1rIZ1SsqaGF5micyy9jbMfXFHLxFIk52FgMBd98TaLcm7/s3Ucz79j/7SY9feZvYHeFwRdLT1vejaijUFTvIPU6FdXhiM8IA61eN4FYVpYcUAUaNSjespolUamXgEdwMpEefqALQ66+ROmVO8CpttYev8uTc+AEZlQK1y6GAUfnbYZUs5Qd86owHz0XPIVX8cVO8CHKwu1gleRZOQmaVFavMVOM4vqCbCYNMrVsw4jBQX2xbgu8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(376002)(136003)(366004)(346002)(8936002)(186003)(55016002)(478600001)(26005)(76116006)(33656002)(52536014)(66556008)(66946007)(64756008)(38100700001)(6636002)(316002)(6862004)(9686003)(71200400001)(86362001)(66446008)(2906002)(54906003)(4326008)(7696005)(5660300002)(8676002)(66476007)(6506007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Cftc8qpsjY5eiLs3N4KCTI8sIrqA9NMaimVf2sUBZEpVNhOezu6hGz3IwCNH?=
 =?us-ascii?Q?wgG8vbcWQ1AcYZT3EQD7etyC+y/tE+1GuLrvDNtsKvgLpcOZHtjgnon/By3J?=
 =?us-ascii?Q?1azk0xuECt3Vj/nQgh686dVJEu8XI72s816CXZKGHF0pW0gJs80xgt/zc72D?=
 =?us-ascii?Q?aZq0YvLf4zGVEFx7YGJPva5Kvcn75KUr8Wbzd3zBfNs2fEn8OA3n2FmWaiFm?=
 =?us-ascii?Q?RcF1dfn0e+IrwMFXPcmbxS0TCYVQ1/DMhNGPiAOXPLJx+bC4PWLgRwxG9v8v?=
 =?us-ascii?Q?UpdjbSqTrBxKl6qxpERukQPbXrzP9z4p0EvqcNMqCYetoVHWcz6vPLctm2dv?=
 =?us-ascii?Q?DEWHI9NPFgpCM+ZHO0DmIUOUVY97e7oaoeZvtfrSK1Oij24O1pBPukN2dAB7?=
 =?us-ascii?Q?21jRMhYngKyB9vtiGGdhWGZE84ix2ethQfSEeYagDH9EqgxUvzpIJ88NKNr/?=
 =?us-ascii?Q?GsDY0SDv6dNbjtjjZOITYGS9CQ2OiNQjzFKKkGysMRg1oiNLMJsbJg+DyYpe?=
 =?us-ascii?Q?w19qilI9tKLuOVEf5cPMoD6Xmwop3HPpFygjSxQWlBXHQ4NSRqI4Tv8CEB8R?=
 =?us-ascii?Q?m/hoifBN71PMBQPNTAiOftvckBw0wcSZa03VbJCIy4vLCtUDK2QIgT0E25Yf?=
 =?us-ascii?Q?+xGzgf9iEsF+luOO9UeY7NcMaEzYEChllFxU5SHpcof7EhaqzkYACwZK8SDE?=
 =?us-ascii?Q?dAj9zzTvlhXXS7phXitrt2CywivBY9yeO2PBt8weFmfw9SbYHfgruXucIH/X?=
 =?us-ascii?Q?ZOD3DKnA/blBKd7+V9HauJcu/su1eM+6Qjt71jowh8kOKUiP1/gzzygpIZ8O?=
 =?us-ascii?Q?K9Ooh0D0a/zk1X3CQz9WkfYAmsjTMLiELKCfWrF809ziGWbgRT+XHv6pL8zP?=
 =?us-ascii?Q?+CnOpyTc1b9uB/9GRhTgAuJKYZt/3nejSrZf8ZJ2hMxJVn6PX73ewt1/xo0d?=
 =?us-ascii?Q?GaYr+y5wIhkyOeygTz2gVG8uemRnv4Xq81e8GH5EA3cIe58G+I8Dj6G4G4Vx?=
 =?us-ascii?Q?+FOeXrAJVOSO3B4cOmFKGor0sj7GanFxOT0TwiNun1IX6LPCsAr9UaViWYDH?=
 =?us-ascii?Q?HVprXawfX27zBxAmmGDc8yljHOhnMX9tR18MmHq3sqhMAz6B8W/5FjY8AKoq?=
 =?us-ascii?Q?FRfOv4kL3Fw6W1Fc8REihiHgR7ef4EZ6REwo730nTzy3IW9aqIP0gFnXzKg9?=
 =?us-ascii?Q?kKdQi/TTAub37mN4CZpww7fLK4tasxIh/YNZis+spu5er7vGs/6lkOjaIZNx?=
 =?us-ascii?Q?8hkhSBvQ3yQj5LCQLdtOCPd+CEz0mluoQ33Km7EIJv2xi+iLqFlQizTT4bWi?=
 =?us-ascii?Q?A45buF3FtuiNB8MrTzuD+/y0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3745dc-e762-4e60-70fd-08d8f4d3cfd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 06:03:03.3083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oI+xht5P58XoJM9F/yjordH2YIGv0DA9i8Za56FBqZmikqbmQk1ZVj0TFH7XCBf+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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
Cc: "Min, Frank" <Frank.Min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Monk,
     Could you help to review this patch?

Best wishes
Emily Deng


>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Wednesday, March 31, 2021 5:01 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Min, Frank <Frank.Min@amd.com>
>Subject: RE: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov
>navi12
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping......
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Tuesday, March 30, 2021 12:42 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>; Min, Frank <Frank.Min@amd.com>
>>Subject: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov
>>navi12
>>
>>Since vcn decoding ring is not required, so just disable it.
>>
>>Signed-off-by: Frank.Min <Frank.Min@amd.com>
>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 +++-
>> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 29 ++++++++++++-------------
>> 2 files changed, 17 insertions(+), 16 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>index 8844f650b17f..5d5c41c9d5aa 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>>*adev,  if (adev->uvd.harvest_config & (1 << i))  continue;
>>
>>-if (adev->vcn.inst[i].ring_dec.sched.ready)
>>+if (adev->vcn.inst[i].ring_dec.sched.ready || (adev->asic_type ==
>>+CHIP_NAVI12 &&
>>+amdgpu_sriov_vf(adev)))
>> ++num_rings;
>> }
>> ib_start_alignment = 16;
>>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>index 116b9643d5ba..e4b61f3a45fb 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>@@ -220,21 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)  {
>>struct amdgpu_device *adev = (struct amdgpu_device *)handle;  struct
>>amdgpu_ring *ring = &adev->vcn.inst->ring_dec; -int i, r;
>>+int i, r = -1;
>>
>> adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>>      ring->doorbell_index, 0);
>>
>>-if (amdgpu_sriov_vf(adev))
>>+if (amdgpu_sriov_vf(adev)) {
>> vcn_v2_0_start_sriov(adev);
>>-
>>-r = amdgpu_ring_test_helper(ring);
>>-if (r)
>>-goto done;
>>-
>>-//Disable vcn decode for sriov
>>-if (amdgpu_sriov_vf(adev))
>>-ring->sched.ready = false;
>>+if (adev->asic_type == CHIP_NAVI12)
>>+ring->sched.ready = false;
>>+} else {
>>+r = amdgpu_ring_test_helper(ring);
>>+if (r)
>>+goto done;
>>+}
>>
>> for (i = 0; i < adev->vcn.num_enc_rings; ++i) {  ring =
>>&adev->vcn.inst->ring_enc[i]; @@ -245,8 +244,11 @@ static int
>>vcn_v2_0_hw_init(void *handle)
>>
>> done:
>> if (!r)
>>-DRM_INFO("VCN decode and encode initialized successfully(under
>>%s).\n", -(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG
>Mode":"SPG
>>Mode");
>>+DRM_INFO("VCN %s encode initialized
>>successfully(under %s).\n",
>>+(adev->asic_type == CHIP_NAVI12 &&
>>+amdgpu_sriov_vf(adev))?"":"decode and", (adev->pg_flags &
>>+AMD_PG_SUPPORT_VCN_DPG)?"DPG
>>Mode":"SPG Mode");
>>
>> return r;
>> }
>>@@ -1719,9 +1721,6 @@ int vcn_v2_0_dec_ring_test_ring(struct
>>amdgpu_ring *ring)
>> unsigned i;
>> int r;
>>
>>-if (amdgpu_sriov_vf(adev))
>>-return 0;
>>-
>> WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);  r =
>>amdgpu_ring_alloc(ring, 4);  if (r)
>>--
>>2.25.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
