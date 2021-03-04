Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B7C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 14:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69ABB64EEC
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 14:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ABB64EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E47F6E0E6;
	Thu,  4 Mar 2021 14:00:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2AB26E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 14:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7BK67L+9zWNorqFhR4qehQEvQarqrgWHcNdcQfF2/Pt+sBjm7uTbZG3k/iOPfTN+wq2quM+2N573gbwVlpc2LyiDdITVPFAYGrWhsBArCdodmUUVFPuhjZiP6Pj4lravUo5MLc6ICX4oUVG6JfCDKFebucuuo7JW+tI8SCd3JysejNfvGGVet4iYbSzzyVnc+yDHY1GAzmHRHLYobETR1I8gYQSZRQ292PMQrhaM6pTUmBm+jQ3TFNt8b5b/rfhmXm2Nhv7bxMv050qlTWi8aw3pRWa+E1Rs4uY/+I35SAgxV0G74r0WXhGkoQjeTWE6r18/wTXevRc7SyO0QM3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7cGfS+mo9D6Vh+HbGqEqkGwrgMLUPI6EyhMEAK4N1w=;
 b=AHtNWgjz+xm9o3XsBr1w3V8MVDKADkoq9eZipqytsLOzPmxwQ4vzD7KjFtUhmEeutEMmdVbvx3PpBq3LJD/AHCTeVEd8q/gVE8cKqZW4uV6gQ6BLNGShoC+wdrAfdUm+F0vJumkzrlPlGSxUmoWpuFnD3JumM0NkrcuAW3IB5QxLuGkoUmppcGnfhZUAP2dg/pmjkLm7OnTD6+Rva1WI/cVvS4kPcNBeQTjnn9lqOS7gMDvvNuhwAwqKcFtIXu6NiDSIXsP/+pbRmBHg5WmbaIyy0aywJcV6BYvUOwwbdorpkwi26JO8u5S8LLkWpd6BZwjAezC9+MPRroYP/QLC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7cGfS+mo9D6Vh+HbGqEqkGwrgMLUPI6EyhMEAK4N1w=;
 b=jVVa3vY36GEx+VDTihJ8ek1YVvNUXTxke48g2vSoOJe7IM+dkq+SlJc/9WRCHE36zkBNlU7ypsoYK+eWmpWv0kZzA3N3tYyWdIVTrbrll+ope6Xh8IaCc5OLEggjhx15wj0ca5hyMqh/aBAFA4Fjek9hkEEF7POMW8dZc1tsoGo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 4 Mar
 2021 14:00:06 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::8c0c:5b9b:fec6:e12b%3]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 14:00:05 +0000
Subject: Re: [PATCH] drm/amdgpu/dc: fill in missing call to atom cmd table for
 pll adjust v2
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210303152022.260614-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <2dead0fe-5a38-3c13-f7b9-49682be89161@amd.com>
Date: Thu, 4 Mar 2021 09:00:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210303152022.260614-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::33) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.24 via Frontend Transport; Thu, 4 Mar 2021 14:00:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef585fb0-16fe-4dc9-4a99-08d8df15d058
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0063609119C3DF6FC058B4278C979@MWHPR1201MB0063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hDov3IglglAJYkDewsPBlNTzM+HOzzI7veoW/gHsQ5bSsqmfgAvGXs3DYC9c05v+cwKy6lC0hnJa2O51vU4BEAbqKyWS7pB81RL/4TykWDoSxQjkBaubhCjwCjwB9MjMsMffsWrg0YenMPtOH384zn8Y3NQr9Aer90yxNfxXWWwtj/Oxv7Bc0BJJd3nw8FO34ubys3vnHCmEbgSBvq664UwXM8XMicYCc4Ce9IU2Cdl+mm6Y017Vr9zBGv1+k3kkjsvgu3AAekB0PudA9/m+fVIHoWJ2UFwcjlTqQF39YVAog91O4RO1kOLyisv0VuqLo7a5VqESa03Lbt2Eh5aoeGDAmKP3VK9EKu7CIudBKK70m0f17yb65Gu7mOBRJXXfmUzKRgemvDCWOD0AujNrU7ZckHcId4m+hIrw1/DsK56OoClRNzgLRI0l7w9JeUeZqeF7YwKkiBpQk4+KCEipoYMJy6kP3ZcIBN5o8L/V8I+wRCj3KQ85mUsG9qeBkfbyD1kq9/0uX2wg9/209T7LKBmItSG5WvtYMwTVwtqAhVK1CPwFADKsiXS83r9noGQwqbG8a7T8WkbTy3Fk1Rbx5E3ECrO1shFwcHWsv1A+wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(2906002)(6486002)(31686004)(66476007)(66556008)(36756003)(83380400001)(52116002)(8936002)(956004)(66946007)(86362001)(5660300002)(31696002)(478600001)(16526019)(8676002)(2616005)(316002)(26005)(16576012)(186003)(44832011)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?elR6b3QyRGdkNHE0SUpOc05hc09HVElvc1ZIVDdRZHlNN09LSWxjN3Y2N0lv?=
 =?utf-8?B?SE0wY1YxNnpNbjNIS3FMMnQveWlWTkpQTWc3bG1UVmdRUEt5SEN5cTZSWnl0?=
 =?utf-8?B?S05ibFlSZjNzUzRwZlowY2pGTnhjTi9sblA3VnFLaTlPYUQxNFVseHVLM3Rp?=
 =?utf-8?B?b2VwZWQzSlJ4cmg3YWV3Sk1oRzJpb28wNlVhcHJURFEyTTdEeGVzVFFFb3VM?=
 =?utf-8?B?WUZ2Zm54NXRJL1Zvc2JFeUp0ZXdSWGN1aktJQnVhOUY2eEpwejVpREYzQ1FP?=
 =?utf-8?B?UnI2aDNWdEtVUE1kS0NGdWUvemFaY0ttR2lIeEpiLzlJYjFXNW1RRlVPVURp?=
 =?utf-8?B?bGwwRTlLM2hMNWNLUVhqVlc0Lzdja01ZUnNiM2VKaVFnL2MwLzljbXZJR0Ni?=
 =?utf-8?B?MUlKUDdYbU02Y05ZSVFYWlNPREdlanYzNm8xcEFtTHJubUFxMk9JTFFpZ2dJ?=
 =?utf-8?B?UWNEL0lMczNTSXpPbzVhYytKUWxqN2JGMGx4U0k4MnlBYjNZWnYvSUl1UWY2?=
 =?utf-8?B?cEdSVUszbW9HVm9PaEVibVVEMVB5NGdKTEE1U2Z1UTVTdjN0YUpsY3N1Tmgw?=
 =?utf-8?B?NGpWcU80UUFVRjV0WkhhZU5nSWhiUWpwSFZtSzFpWkFzNHJOa3c1Q1pPb05E?=
 =?utf-8?B?Sk4zTzc3M2lpNjJwelM0ODkwemxOclorQmZIWTB0dUd4UE1yUmJqMytQeEU0?=
 =?utf-8?B?aTloRlBRSlBTZkRyNy9WVDNpL3Q0aCtPN2RCSERvazhvcXhrMGpJOWpIQ3RC?=
 =?utf-8?B?aXNqekJaY1MzeTZsTDJzSzlkZmF6V3RVcExlY3ZjN3FwZDJFWWk1MmEwUDRz?=
 =?utf-8?B?b3cva1Z2cVlBczR4c2ZhTXcvcUNXUmVubjhoYzlNWlA3SG5FNnFpQUJ1bE1Z?=
 =?utf-8?B?aUFyVktvZ3QxTS92b29JdVFLcEU1UXg2TVRHMGRLbkFYNHdnNTczMFd1RVJC?=
 =?utf-8?B?L1JaSkpONEk5M2xkL1psck53OGRldyttaG5ZNDZXVlh2SGRXdUN0bHlzT1pL?=
 =?utf-8?B?WlhQNFVPaTFmMjdqOXRKOHk0K0tETGdoK2NseWtrdmRnUytMelpEbGJKWVFK?=
 =?utf-8?B?dTNUdFU4bk9mbTUvOUh0Vjh1YytyWWV6VmNEWTcrOVJJdXFyTHJaaG9kUW00?=
 =?utf-8?B?S0RRdWhKNWQweXJyeGc2eWU4WDg4N1pmNldMTVhKM2xtSXlYVFpIUUJkMzUx?=
 =?utf-8?B?OHRYbDBqdmlkY2VWdUlqSENUUG9GSE9ab21vZVFLbXBLVEVQOVpzTmllKzZP?=
 =?utf-8?B?NUZvcFRLZUZrWjZXQjB2eEUxeFNicWJYZk5FaG5PVERSWnRGbnd4VmZtZDBZ?=
 =?utf-8?B?NGNpVnhTR2ZqcVREQVhGeWE3R0RLbkU4bml2dndnWng4WjBkN1lDaktxejM3?=
 =?utf-8?B?Nm9ObmszZDRoMzZQUEJjWHg4UWhOYXl1Mm5FVTdlMGl0UlkwRWJEVTd0UE5O?=
 =?utf-8?B?Q09BU3dDZFN2ak96UmVTdU9STFlEYytvZ0cyc3BOdVRvRnYxU2FVVUY0Y1c1?=
 =?utf-8?B?NC9XclBOTW8zRkZPTHllMU8vdEhlWVFDRWlwWFhCaXhSZ01RZ2kyMjNlTkk2?=
 =?utf-8?B?VVgweGdja3RHWWZJdy9ZbEpvK3dPTzFNcHJZeGlIMWtOZU5WTms0TVczTWRo?=
 =?utf-8?B?UVNpaDh2K2RXc1JBemFUd0NyN0ZWcHh0WE1hWkhTalcyb01laFRJVVdvOFUx?=
 =?utf-8?B?Y2xPWm9wMUNIcitkWXNoUzUwTHNtUWk1Qzc5ZDlsNEZndUpwWlVGS2ZsQmJX?=
 =?utf-8?Q?1JlS5I5kNQlCO5IVwrSSopGRbICeU2B2aqY468e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef585fb0-16fe-4dc9-4a99-08d8df15d058
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 14:00:05.8188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHrBoBgCfQjur1HW08FEEh3nMkhudXQgK1rRiLOhfEEvO7EUaPa+uEBDoFtvTynFq3ueM0zSmQBkF/LX5Riv6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-03 10:20 a.m., Alex Deucher wrote:
> We set up the parameters, but never called the atom table.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../drm/amd/display/dc/bios/command_table.c   | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> index afc10b954ffa..ad13e4e36d77 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -1531,6 +1531,27 @@ static enum bp_result adjust_display_pll_v2(
>   	params.ucEncodeMode =
>   			(uint8_t)bp->cmd_helper->encoder_mode_bp_to_atom(
>   					bp_params->signal_type, false);
> +
> +	if (EXEC_BIOS_CMD_TABLE(AdjustDisplayPll, params)) {
> +		/* Convert output pixel clock back 10KHz-->KHz: multiply
> +		 * original pixel clock in KHz by ratio
> +		 * [output pxlClk/input pxlClk] */
> +		uint64_t pixel_clk_10_khz_out =
> +				(uint64_t)le16_to_cpu(params.usPixelClock);
> +		uint64_t pixel_clk = (uint64_t)bp_params->pixel_clock;
> +
> +		if (pixel_clock_10KHz_in != 0) {
> +			bp_params->adjusted_pixel_clock =
> +					div_u64(pixel_clk * pixel_clk_10_khz_out,
> +							pixel_clock_10KHz_in);
> +		} else {
> +			bp_params->adjusted_pixel_clock = 0;
> +			BREAK_TO_DEBUGGER();
> +		}
> +
> +		result = BP_RESULT_OK;
> +	}
> +
>   	return result;
>   }
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
