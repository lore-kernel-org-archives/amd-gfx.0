Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A6DC47254
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 00:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F71021775
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 00:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q/7K76Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F71021775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DCF6E037;
	Sat,  2 May 2020 00:23:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D296E037
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 00:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmWx8Su38rL/Td12FG04cvGSROEbGXT9oEhtKpKJdUcpnPhi/RIg+CASHFFPUMM2n+xgwVs/w34caUbxuNYYJrgIbJDhL/BSktPGoSctN/a00HCYA2cPJGsXHjLkcst/TVDZ4sjaPmnkxIP199ORJpt3Uy3ePsEWH5O7MRZkVytA8y7kefVgxyEgrP3vTYeyIboYVXinuHXp6CvrYG980uvSJogDS40Xw/MoSryjTIy1jGYwsjOmCuZdcw9goqTT/6JU8q/7fmZCR+BVTFP4id/eou5aTT1/fkqbNTayTyp64r8PQ234lnXaXL/QAxqIw9Oi4kaCA5CsCPcda57Jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+olK41u1tIEYrBLCBqounGpPRUCRm40tDcpNLijXa4=;
 b=abU3cYVfK4Xq9dpdIHN7gV+oZt16yJRgBBKDdEVnL/mpfTRwLbTt6Ma/aoXWHjKCkglklt5dHpj69J4t84OwPJLcEvkT7UBUB/RHPsvQQqBcgz4txcQ8lub1lMCncBkU8v3X0B1x3XVQ1YAUgoQzW9aRfaDSK78hMOCCqAI/pIk8CHbV0bn3RK9vWwz+ugJ5nHgvCA9ip2YZNd3+80B68lTnwAA+k5k5/ujBPd+UZr4sfj6E3atM3dDO2EXXnxMr0gv8eGYRo429SPXGC2K4OlUD1Vd5ne10TmjQDSQ3etdV5RURuVCFqOBLJOGVHJFQInQ04Wk59pqW6FXEouS29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+olK41u1tIEYrBLCBqounGpPRUCRm40tDcpNLijXa4=;
 b=q/7K76PixprrpzCqcsZ7Ple47ys04c4U/SfBUkGNW1krDP2WPggAshaZ3n0TiQO0RTYztZgVEssBTkvITUUbSPSuigx0h9Krq828sn7adCaWa16HUTZXvCm0R82MoT5u7JF0Rms4/vvdztXH8A6ZmlGVybbh49n0SH40LZHK8xM=
Received: from BN6PR1201MB2466.namprd12.prod.outlook.com
 (2603:10b6:404:b0::20) by BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 2 May
 2020 00:23:28 +0000
Received: from BN6PR1201MB2466.namprd12.prod.outlook.com
 ([fe80::dd9a:57b3:84e7:15d9]) by BN6PR1201MB2466.namprd12.prod.outlook.com
 ([fe80::dd9a:57b3:84e7:15d9%8]) with mapi id 15.20.2937.034; Sat, 2 May 2020
 00:23:28 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "S, Shirish" <Shirish.S@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance
 edid corruption test
Thread-Topic: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance
 edid corruption test
Thread-Index: AQHWHk/fctx7EE5CRUqNRCrxPp5aCaiTSOkAgACdM6A=
Date: Sat, 2 May 2020 00:23:27 +0000
Message-ID: <BN6PR1201MB24668EC6B161C053C73EAADEE5A80@BN6PR1201MB2466.namprd12.prod.outlook.com>
References: <20200429175857.17051-1-Jerry.Zuo@amd.com>
 <894f6404-3a12-0592-1f61-133c32ee3607@amd.com>
In-Reply-To: <894f6404-3a12-0592-1f61-133c32ee3607@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c65a7c15-1532-4758-a66d-00009d0b5595;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-01T23:36:42Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3de0:20c:a893:af84:f0ef:1713]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45191925-0ad9-4842-14fb-08d7ee2f091e
x-ms-traffictypediagnostic: BN6PR1201MB2467:|BN6PR1201MB2467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB246734E29707E54B64E1A70DE5A80@BN6PR1201MB2467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 039178EF4A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB2466.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(316002)(33656002)(8936002)(8676002)(52536014)(5660300002)(6506007)(66446008)(66556008)(64756008)(66476007)(186003)(53546011)(7696005)(110136005)(66946007)(76116006)(71200400001)(55016002)(54906003)(478600001)(9686003)(86362001)(2906002)(6636002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G2ncxVL0FP3BbKiQ3yz2eEwFZ81QHneDi6Lc7eoub8RqWRm9y2a2LngFAGJeofaQz4H27lz/mMy7WiEAiGQIeMkwcyZUuA85cz8UNY06rrcl0WUgGOR/qGCqOMXmckNMQGAh60hZmataM7AgQ7bz0cNOia4hddP+7COPU1/uXCcQ6jqZUbV2liS6AoDoVFcf25AxkpELUQd6ENzdrBm014Beqjc0ZEP8WVGQ9cUkUuHH5lKU+loig7BwTOyIm2hdIV3WbERsIyD/tWovNJfx7EOawHf8bCMJ1TlYWmPrwV3NAj9oTG/G/mmdX33fzUpYeirrDHJbXLHZ2TEh8DbRNC7KhonysLNzBm8U9PesSesUckDaP5Coh1v9m3tfZfsNcwAxvTTxnATI2ijZERtsLYBMmQknw6OBKDN4ODUsS8qz+cnuLYqDNaIZs59McGlW
x-ms-exchange-antispam-messagedata: FYwP2njKKDvg7AkPo0yaKATIPq+Ic3u6qMiXjp8U/ywrPITQ0S481f3O1wWuLUsogFuSUrnZZzjJgIh8LDYp9KBgg2ZMCZOHWBR87dQlKaT9SJQx+QhbUeKJpq3QvhmrOHiLaAbTX33RGwlrmIk3pu3lZFoX5J5l9lzHEDtoprbsOtvLO4PkgyGVeeY7N9uqLo1kOzvEJ2cxKr5j0rylfDwu4RJH6shM03uYc29zTrjD4FdL6Xzqgwep5kXReQ7GJtiWD3vPdbvDXtAMlRd+XQAd3AktHpYFZkAsBhHJGXWOu4K2wjHJSHR1610kRhoq4xlox00rMudE/YhMuUkwcVuQLxSLniTzT4NVqjtHKfVZokdfMDpRxhGZR9XdSBkRcuAziR6lZYhpvERySB/sUwasBbUyAZ64ghZ5KU7gqC/zTYzJOGlb6mnwpb7vnM+UEGU/p8lFeRpgp2+CtY7u5JuSaWQQM+XjjAjmZHcOkiTAsG7PC2sV5kh+1ysSPRVQAK0MJufV1/4NDNFAlLY1poAz+F2mV3yOapUmbyc8OkTBy/dyvMo3EZH0yD6SAAlsts+NT3RvTj/FyMlS/J2hsi8fAX7OKlQwWf3haIvs5TGbAgITzraJhl7XwCU94SkaGAw4CR2ra007JxkBnoieqWLMMbcz7mRAHJCRNhY3fpZG+zhbJcutrDvKQo0JL+v3pZTSjIHfoBaCcvK0GLMGDoZZS8caPXFzMMrkap/RjNbX22I/XwqK8qmOah+GLV8+QcmyNGsZ3TY7snpWDXQD4gqqDW8FTh8k5q2MAYNwCI92ri8UVRWe93KJzVrYURMEoQdq2jCwaACt1zOt4STCgGiOQ4BkpPe9Ip8UiUfqe3s=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45191925-0ad9-4842-14fb-08d7ee2f091e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2020 00:23:27.8615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTWIgdWpEdooiQPkWrR/ARzMvvPX6hZAxZ2a5LNBdh3TpUq3uCr+B55q1IlOWeC3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2467
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

The error handling for edid read right now is categorized as:
1. If base block is fetched with checksum mismatch, drm will set connector->edid_corrupt and return with Null edid buffer. This case will be handled as compliance test case 4.2.2.6, retuning EDID_BAD_CHECKSUM right away without the need to got ahead to parse edid caps.
2. If edid buffer cannot be created, return EDID_NO_RESPONSE but do not set connector->edid_corrupt
3. For extension blocks, drm returns any valid blocks. For invalid extension blocks, drm doesn't set connector->edid_corrupt. This case will be further handled by dm_helpers_parse_edid_caps() with 3 times retries. If all failed, will return EDID_BAD_CHECKSUM dc as well to enable fail-safe mode.

Regards,
Jerry

-----Original Message-----
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: May 1, 2020 10:14 AM
To: Zuo, Jerry <Jerry.Zuo@amd.com>; amd-gfx@lists.freedesktop.org; Wu, Hersen <hersenxs.wu@amd.com>; S, Shirish <Shirish.S@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance edid corruption test



On 2020-04-29 1:58 p.m., Jerry (Fangzhi) Zuo wrote:
> It works together with drm framework
> "drm: Add support for DP 1.4 Compliance edid corruption test"
>
> Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40
> ++++++-------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index c407f06cd1f5..b086d5c906e0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -554,6 +554,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  struct dc_sink *sink)
>  {
>  struct amdgpu_dm_connector *aconnector = link->priv;
> +struct drm_connector *connector = &aconnector->base;
>  struct i2c_adapter *ddc;
>  int retry = 3;
>  enum dc_edid_status edid_status;
> @@ -571,6 +572,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
>
>  edid = drm_get_edid(&aconnector->base, ddc);
>
> +/* DP Compliance Test 4.2.2.6 */
> +if (link->aux_mode && connector->edid_corrupt)
> +drm_dp_send_real_edid_checksum(&aconnector->dm_dp_aux.aux,
> +connector->real_edid_checksum);
> +
> +if (!edid && connector->edid_corrupt) {
> +connector->edid_corrupt = false;
> +return EDID_BAD_CHECKSUM;

You return EDID_BAD_CHECKSUM here but the surrounding loop uses "edid_status == EDID_BAD_CHECKSUM" as condition to go again. Is this duplicating functionality that dm_helpers_parse_edid_caps did?

Harry

> +}
> +
>  if (!edid)
>  return EDID_NO_RESPONSE;
>
> @@ -605,34 +615,10 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  DRM_ERROR("EDID err: %d, on connector: %s",
>  edid_status,
>  aconnector->base.name);
> -if (link->aux_mode) {
> -union test_request test_request = { {0} };
> -union test_response test_response = { {0} };
> -
> -dm_helpers_dp_read_dpcd(ctx,
> -link,
> -DP_TEST_REQUEST,
> -&test_request.raw,
> -sizeof(union test_request));
> -
> -if (!test_request.bits.EDID_READ)
> -return edid_status;
>
> -test_response.bits.EDID_CHECKSUM_WRITE = 1;
> -
> -dm_helpers_dp_write_dpcd(ctx,
> -link,
> -DP_TEST_EDID_CHECKSUM,
> -&sink->dc_edid.raw_edid[sink->dc_edid.length-1],
> -1);
> -
> -dm_helpers_dp_write_dpcd(ctx,
> -link,
> -DP_TEST_RESPONSE,
> -&test_response.raw,
> -sizeof(test_response));
> -
> -}
> +/* DP Compliance Test 4.2.2.3 */
> +if (link->aux_mode)
> +drm_dp_send_real_edid_checksum(&aconnector->dm_dp_aux.aux,
> +sink->dc_edid.raw_edid[sink->dc_edid.length-1]);
>
>  return edid_status;
>  }
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
