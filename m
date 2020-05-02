Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D18C47256
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 00:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9F421775
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 00:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RshMJbJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9F421775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38106E037;
	Sat,  2 May 2020 00:24:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304E76E037
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 00:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhg9cg+KNHXcekU4Y5zHGjmVNtkutrpx3kdcdN8EiRHocTsSXp1uyW0yRrcjbwB9eKbl+JQLJeuFS1HcigGYWFTOAIJ3KgIr7ll042jL3xPvH0Yjxb3zpkCXkGhjWUX10s/SFSZXsE6kV9dxwVCIXlkOuiZdlTqX8aXXB7bWZyZoqVeMyzUQT77Hfxz5bj24TtDL7PeKRDwC9p0zm+5brZfMr0RJca2WP6hfonhs0ZbIZCTyRzd3E57U4ar8l1crXxUG7gq+bo95h6F8eBf/0/NVeSljl3yK76rzFFMttO26rjIPFD4l5nduszaCLPRD5JXx1WcP/Tg23o1+BlxKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F20cdIhTp8Y9ic0qQKK/3ufiri9D6VDjhZUEZhSqbBs=;
 b=bB+dVBaKFsahWShfHcDfhMIf/GZbFCw781n56EwCEaEtkf5xL36tkI0t4WAeDUWgKBp1xPRlQ4tRuchgNxzVX84fWb9G3vJ/RPbyAujueX/zIO9duMMj/dTFWPkLb+ScDg4WxMX/PWdF3r9F+D305Fx0swzyAfhzII2sgtQoHsESi6NBonyxcCgPdzHuDQSLX7RN4cbmP4nr5SPXJ22uKhZ0jxlM2D3pxh0LWiXL8xyNW5kPV0K/3qOkeklfToPqHTmk7s0amZDceB9X2O4AvJ1y7wRFn6+GDRzTtKbfjaovsltbp5VE74YmGpSvq4Fn26cr376YDlYasj4GAC6ijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F20cdIhTp8Y9ic0qQKK/3ufiri9D6VDjhZUEZhSqbBs=;
 b=RshMJbJL7veqoXou/q4xXU4JGIrJ7Rcn46LyYKBHeGCWnXrRtcu3Ad2RCTdaZovCnTBK0zkhfORW8KUaqwC/GPMvIZCk8m219cnbENmx3kfaE5pt43tlacs1KUg6UrbIm0gfLX1qM+6xuKTNfD8i+SMcrVY4b7deBx2h0fIJ1NQ=
Received: from BN6PR1201MB2466.namprd12.prod.outlook.com
 (2603:10b6:404:b0::20) by BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 2 May
 2020 00:24:32 +0000
Received: from BN6PR1201MB2466.namprd12.prod.outlook.com
 ([fe80::dd9a:57b3:84e7:15d9]) by BN6PR1201MB2466.namprd12.prod.outlook.com
 ([fe80::dd9a:57b3:84e7:15d9%8]) with mapi id 15.20.2937.034; Sat, 2 May 2020
 00:24:32 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "S, Shirish" <Shirish.S@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance
 edid corruption test
Thread-Topic: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance
 edid corruption test
Thread-Index: AQHWHk/fctx7EE5CRUqNRCrxPp5aCaiTSOkAgACdM6CAAA0ugA==
Date: Sat, 2 May 2020 00:24:32 +0000
Message-ID: <BN6PR1201MB246625DF34D778084210D216E5A80@BN6PR1201MB2466.namprd12.prod.outlook.com>
References: <20200429175857.17051-1-Jerry.Zuo@amd.com>
 <894f6404-3a12-0592-1f61-133c32ee3607@amd.com>
 <BN6PR1201MB24668EC6B161C053C73EAADEE5A80@BN6PR1201MB2466.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR1201MB24668EC6B161C053C73EAADEE5A80@BN6PR1201MB2466.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: eb6b4b5e-835f-407a-d2dd-08d7ee2f2fae
x-ms-traffictypediagnostic: BN6PR1201MB2467:|BN6PR1201MB2467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB2467B59B0F7B8B41F3123949E5A80@BN6PR1201MB2467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 039178EF4A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB2466.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(55016002)(71200400001)(54906003)(478600001)(2940100002)(9686003)(6636002)(4326008)(86362001)(2906002)(33656002)(8676002)(8936002)(316002)(52536014)(110136005)(76116006)(66946007)(66446008)(66556008)(64756008)(66476007)(186003)(5660300002)(6506007)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+hu27MvbJWIURrtuFXTxh0mUHOzVhr/OccEv++kg3/Y26YAay85ae1/aKGYlwNlS8GkaNqABBBs+OI6GEdR1+RrpQKzdXORMNEYul3vjfnqNKDrE+wJeukgNNtdwNMuAMKGU9KMTPanhlWnztEO+ewA2i8yFtTKZeDCfBxTdir35x9Y5SEIYzLDoo7eSuus0JgwzcwbCVlIbT+2uNpYz9h8Ju41bzZ/Jmnth1lhDuB3RP1Eyv2axQwYYRQ16NRs6oYt67Lvq1OsTS7HPGhbv9HF51r/E+i42gPx1caGWqIF1KUS2TZBCFP+a0pHbl1EYOxKpYaeTKnkYUuvD/+3JjbFg375UWUDdKyx+JstBmr/Ih16WLMu1dYjbngQtgAr0f2VOHS4mspkFvBo/oqu6hq9aBbFgxoPnf4sEMqIa6DBh8dsECVvu/qqf1CBsieO
x-ms-exchange-antispam-messagedata: 75QEeTVukXTKB7TZZnmPA8YlDRUhLOvrAFBZ8ISqRsvnQ8TRJNQYJxjn9xoGtTEtNL8P2HkPzzqc0Q5BCqa3b0gNZf9NG0nGil7Fnh7rgC3myNUN/rzbBNwMGF1VsxcFcXvJ5nfwjtDcta3qXfGrzd3ZU7vGx1ecqiY1m8itInoRRB4mlPqBUjGqf51pmdgcM2EedS8K7hzbpjfO1OvwQrTet0c9XOV4Xd/5n0MlBR3JL06ziGNbcMITKQ5gm9XQCx5T4NRwqGq3l8C5Kms81Z4d/TMKQRDO+mON847zhPoVAOGkGKTLX93HE9hXmP96Ji8fxffCYyE8/IFeRYfjM815nST9U6UWCFcEo2BNt7zhJb38v4FPh/elxoKHUKcYpJnJfHLPrSN74u13H4Ii0RR5ZESr3i7ku1I5MF9hELWsjeNAlwru/SNhIQSaI1z5lp02eIMeOdMZV3chiio7IIM+GF1WPz5pkEzcWiysnY7bQb5Sq93wJBlkgALdNu5lupzDWBSV+Ahq6jhK9IUF+tWmejBtUMGvHa5e+xd98GYCsJOPgA2y/o9O7gpTENzvtjOQ3bBZAxF2oNq2QvFOkk30WoUL93LKZlWvCoMrR4ao3w4bLqvXw8rgJ2epKv1I01VDhyYgNrqZ70Jpvpk2P8a4UwnPtETmx7cVBikmgTkpZTa+Nie9Mi7j4MMPMDzJJQdFHBkVrigoDJpw0QhgtANp2/9rzY5qd3xidAOWBK+LoPYIgUD0g3j/cx6Y8rGuCLT/fjkj/VErtDDHI5PKvORb0GFyVoWrJGBtzJGiZtkNrtf8dDLhRPmW/2Grlj6xENsQZMenfxGOr0cupK/ps7MX/+yP8fwoh2hVXyIvh84=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6b4b5e-835f-407a-d2dd-08d7ee2f2fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2020 00:24:32.6434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZrsTBZsxEYOO3jfsD3noBgEJ/crHTe/E56MHVdi8aqBaYnSy8RAYT3qnxVUBLn3
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

-----Original Message-----
From: Zuo, Jerry
Sent: May 1, 2020 8:23 PM
To: Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org; Wu, Hersen <hersenxs.wu@amd.com>; S, Shirish <Shirish.S@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance edid corruption test

The error handling for edid read right now is categorized as:
1. If base block is fetched with checksum mismatch, drm will set connector->edid_corrupt and return with Null edid buffer. This case will be handled as compliance test case 4.2.2.6, retuning EDID_BAD_CHECKSUM to dc right away without the need to got ahead to parse edid caps.
2. If edid buffer cannot be created, return EDID_NO_RESPONSE but do not set connector->edid_corrupt
3. For extension blocks, drm returns any valid blocks. For invalid extension blocks, drm doesn't set connector->edid_corrupt. This case will be further handled by dm_helpers_parse_edid_caps() with 3 times retries. If all failed, will return EDID_BAD_CHECKSUM as well to enable fail-safe mode.

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
