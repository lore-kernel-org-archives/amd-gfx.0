Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5ACC47253
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 14:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B8020757
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UdYpYQ7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B8020757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B613589C89;
	Fri,  1 May 2020 14:14:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0FB489C89
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 14:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjYQC7UPr2iUiYe1kAfZUNdxcvFAIfcaz3ltYj9ggS/LpdhJAlhlNfl8jDJfJI/npYphJkFWv7i1A8ViVtpxlD5MgjKAZQqE1Uqj1IvXAPZ6DDf9/WI5vhBwi998ZmfBcllfCCMHYy0NZMck+8c00kRd4lbE4wrJA3cqAJEUsf6ToS7BmXSC2gRsfkKkmvmKNHqpHldCc+vlTLLdNwVQ26fQ2fpjP1wLjzJ3qV11vmm8R4S3n/l9dFuc+nNaAiqUpDNiSLD+lkSUGPD5qADndE60QK1QPhzV7ztzehPgPQhI0iu9k2lRXhSxVoIKRVC8bAPd0bA7Pjb+NPW8r1REvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOcuTyEu3OjBeqaIA5qnAqlDG6OPtyOsMUAYBC/xeSQ=;
 b=kNgKoOdRBEVKJxjI3YKukQS4znktJNqAhM+fwpkroZvv6EI/S2dWkuANX+ioCXUOTiVE97DMaXp1pMUmLSjzwdX0I1iXVqmDnNDghMlAvBx1c/n2TYlUKpcTR4IHFIxN9wKrEK9mhuu+g6e+wUdT1e87Aqw4KMj3GZ8WpjKN5YqD7xA2HqifuHtabdrOAd9e5lQQv4+sGKC29G3ZRXvgsS3eWvL3z+FS7TZhcvmypzVPggmLRSbWPZ3rpI7MU45s2SPFPlIsc20w6mVmC2J+xZ5mMVak+Sg43X6Osg6IBjWX0UznkPscfL8B5UkjJlF2UE0wy5Xnd52vuCKlLd1fjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOcuTyEu3OjBeqaIA5qnAqlDG6OPtyOsMUAYBC/xeSQ=;
 b=UdYpYQ7d5Xa3bVER7tpn8CtYjUf624LhTIRv7vWQHSp0VTIX2qlSr89vo1axGm3GJ8wmWkMFja09q483gnWfQ6cne9wSK5u5+e63D9du12qv6upy67lhdnQt7+jeNEwEez9HSzkkGJPpTiZI+mV2bS0zwzFY2byY5v1OfX5jrrA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 1 May
 2020 14:14:08 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%7]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 14:14:08 +0000
Subject: Re: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance
 edid corruption test
To: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org, 
 hersenxs.wu@amd.com, Shirish.S@amd.com
References: <20200429175857.17051-1-Jerry.Zuo@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <894f6404-3a12-0592-1f61-133c32ee3607@amd.com>
Date: Fri, 1 May 2020 10:14:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200429175857.17051-1-Jerry.Zuo@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26)
 To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:9240:c66::3] (2607:fea8:9240:c66::3) by
 YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Fri, 1 May 2020 14:14:06 +0000
X-Originating-IP: [2607:fea8:9240:c66::3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 558f571c-de05-4714-63c0-08d7edd9e96a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4411:|MW3PR12MB4411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4411DD884E1CE40BFB8037758CAB0@MW3PR12MB4411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHUzS5fXmetQMNOm4z9SCLSyQbrXxY1VIhT5jNTwcC5RitEHZHXIxZA7JF4cOWY/UF9YGqWQqL6wsD3xn45A5lQWEsEa+WKnFSMe1mHHP8MamAuNt5cwmb+YoA39j6IX1G4oIMC4G7jfdECEOqkMxPgU02jg9hQf0FlgbkaJF4DkmypQklkE2B82LlHbcurwDeHnf37fKVVRRZfUdpr3HyNERJN7X8mOXprgnwo4u8y/js2o9z4VDNX6LVmGtaeaEfFLxAyjq+417Ib0WlrPg/wuokXyyrDb7AVmEv14BPZo6pGCpUvopGlBukGi5zphplZFJ/nuP+Kl7RNbXi8Adm3q+Hvsoluaz4XHRzrQW9/FWVM3Y1T6RjA9QrnhBq2ykUQVoy1rzwrY/O2JNfVIhP0WfNnhppHmWpwBS4plqROlDL38sNew38BormbdGZeK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(36756003)(66556008)(66476007)(66946007)(6636002)(2616005)(5660300002)(16526019)(186003)(4326008)(478600001)(53546011)(6486002)(2906002)(31686004)(31696002)(52116002)(316002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AgzIvkq92QDwNGN9xnJ1lMvxJvDBLJ95sOndzOpsFyDBq7meyu+g9DtmwDDvOFZI9M1WHl61yG49DQFzFUpbyTPq80UJSx8YBYQw5vjxPhEvPiDbTuM//6txGtMqOJPw2iOGL4OcSzu+AeWCG0IpRIUGCUpETFG9neFcGlNRrbNSrDe/5DVZ8/aELOg5KtcyfVFavSZhBthpb3h4a4os1G4pngDHnpzaWkLe2Jj4ASbSwHJPKgvYrmliM3K+CIMgSSReAhBJoTMF4nCZTU+6OcL4LXoRfSCtEbni4D/nhp/E8wdZyXNAlDdE4nRhM7o9OMp6QSKmOIacgBfbe9ZdBT9dxyD0SCl8WEWIGBpd345dWk4uTAYZeY/SGsbPGMlu5QfB6+9lDjr/84E4k1TzUKDqlE27rqZ+DTwO9ezZUwNyYBVjFY2aXOBnvdjSxaukMb/uitp/cwMY1t4Jj2dApROe/oRPq4n/4UGQfaygtfFMXHIbkKwh35ZGrtk42erqevCmSav/PNiIKjOZIz/rNMXKnsRZr0IsW3cK/S4G7J8uQV84g4+VBanztg0fFi7M9uaVjjkA+Rw4+s3b+w2igXkByhqx7RTFfJJaNXIKOZJy60Z1KLCxIAUuwRZhpwJDBog67mkh7xx312B1tyMmxWGX0vk/AEhLmx+iCLZu+tXyw7sTyZqcoYKFMyWnG5RitN81uIX1rsk0CPp//eb3LStDkiatFBJzTu0yn/AnfZZgEWC08QxLgbWuiDFCHy6/mgaHxjL8184NEF3AwaTwyYmOVCCO0COzI987WTlcxp+PGDvMHcRJTmO2TLB6i7cI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558f571c-de05-4714-63c0-08d7edd9e96a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 14:14:08.0325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6hkccnUDD/dcjdGPyTPM0hMaKJjBzkBd53j8NwTglhdP4jVepPHyS3Q7miuxl46dHKWB+53Lv0Y/iJX1c0k8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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
Cc: Alexander.Deucher@amd.com, Rodrigo.Siqueira@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-04-29 1:58 p.m., Jerry (Fangzhi) Zuo wrote:
> It works together with drm framework
> "drm: Add support for DP 1.4 Compliance edid corruption test"
> 
> Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40 ++++++-------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index c407f06cd1f5..b086d5c906e0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -554,6 +554,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  		struct dc_sink *sink)
>  {
>  	struct amdgpu_dm_connector *aconnector = link->priv;
> +	struct drm_connector *connector = &aconnector->base;
>  	struct i2c_adapter *ddc;
>  	int retry = 3;
>  	enum dc_edid_status edid_status;
> @@ -571,6 +572,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  
>  		edid = drm_get_edid(&aconnector->base, ddc);
>  
> +		/* DP Compliance Test 4.2.2.6 */
> +		if (link->aux_mode && connector->edid_corrupt)
> +			drm_dp_send_real_edid_checksum(&aconnector->dm_dp_aux.aux, connector->real_edid_checksum);
> +
> +		if (!edid && connector->edid_corrupt) {
> +			connector->edid_corrupt = false;
> +			return EDID_BAD_CHECKSUM;

You return EDID_BAD_CHECKSUM here but the surrounding loop uses
"edid_status == EDID_BAD_CHECKSUM" as condition to go again. Is this
duplicating functionality that dm_helpers_parse_edid_caps did?

Harry

> +		}
> +
>  		if (!edid)
>  			return EDID_NO_RESPONSE;
>  
> @@ -605,34 +615,10 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  		DRM_ERROR("EDID err: %d, on connector: %s",
>  				edid_status,
>  				aconnector->base.name);
> -	if (link->aux_mode) {
> -		union test_request test_request = { {0} };
> -		union test_response test_response = { {0} };
> -
> -		dm_helpers_dp_read_dpcd(ctx,
> -					link,
> -					DP_TEST_REQUEST,
> -					&test_request.raw,
> -					sizeof(union test_request));
> -
> -		if (!test_request.bits.EDID_READ)
> -			return edid_status;
>  
> -		test_response.bits.EDID_CHECKSUM_WRITE = 1;
> -
> -		dm_helpers_dp_write_dpcd(ctx,
> -					link,
> -					DP_TEST_EDID_CHECKSUM,
> -					&sink->dc_edid.raw_edid[sink->dc_edid.length-1],
> -					1);
> -
> -		dm_helpers_dp_write_dpcd(ctx,
> -					link,
> -					DP_TEST_RESPONSE,
> -					&test_response.raw,
> -					sizeof(test_response));
> -
> -	}
> +	/* DP Compliance Test 4.2.2.3 */
> +	if (link->aux_mode)
> +		drm_dp_send_real_edid_checksum(&aconnector->dm_dp_aux.aux, sink->dc_edid.raw_edid[sink->dc_edid.length-1]);
>  
>  	return edid_status;
>  }
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
