Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7193C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 16:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABA8112C39;
	Mon, 10 Jan 2022 16:32:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB76112C39
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 16:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOQXXMG851qMtbpwLlYv2dBf5ahzC52KZih3ldo3d51mst/K1ZL2oosyqPF4f8ZFcRysq85PkUli5+09NG5GAIdiPKaBrpCnmYya0nz5CTj0Difxrypa+Bcoec0d9UiA0JhoqD12Zpta33z535dT8RTrgnBtxe9LAK9NR3sX/etOFMAtw18SwgLNWKEz3idBEA6pQrPfeHEBpEANvAR70wgGVQaYdSqhEK6J9dpzN6vWpYBScHT5kqwd++h3hkN614y5V4LPLezu/DHEhrchx4Q7YjebrOPe3QRJETWu68fGj2t12DK+fR9uhHXUr04IIfW4NrQWs5DSfuNPWPK7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atutLfL/n10LEl/9QJ3ULBOqVp2x4Y71Q4k8avzBUWk=;
 b=Y1lhcnmFuTbVJJ7tF9uH5L3vjVl093iI8SNid/gwILpzU8CXsESe/4E/QF1gQnMMbh7KLddGS2MCSdkc/jb1ebBAPh4kWNCgl4Hk57MlYKm8YZzrnK59GNPGmQK4iI9Pb+N0NoCFThZgR2nixbXSBye4mmA7jlhmnxMmiNOY1b9PEvSOhAzjvHrjHQ/RHtwy7UYztv3qb0UcRR6OVvtuwxb40zp2GWoLQBURf2U+/Ku63I+jdL+4Gv6aaHNjUye0mvvztKYZbDZGYCeT8R+fQRzkpo5xD+6HIbAz7l5Y6/5GQm7MvyAJrNCFn0YsX5zASqTPCdVzG306U24AH4XU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atutLfL/n10LEl/9QJ3ULBOqVp2x4Y71Q4k8avzBUWk=;
 b=yhWayIAyJaptuM9kUTol0t+q8cj/iwlzezsntIOzAIvFmAnP5f6NScBni+9OdTutCVvHrqpiwutaWGh+2+iWHpMoUH29HDgVIiuUUfnkpDs2A4wote9Os+Hn1d5U2va7XLuweve5MmZ8xuQO2CNBYFb6iAYFpgAIgQG8eUkzo6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 16:32:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 16:32:39 +0000
Message-ID: <44d54537-82b6-b1aa-c9a6-8dc6b16440e0@amd.com>
Date: Mon, 10 Jan 2022 11:32:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Content-Language: en-US
To: Rajib Mahapatra <rajib.mahapatra@amd.com>, hersenxs.wu@amd.com,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0251.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67edb019-8970-4a88-9532-08d9d456d13d
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54909973634C68BB613FD6528C509@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjbrZduGnxlzEIUFeK9VPgqEtYDU1ZPEVQ8qtxg6EyIki9gXdGZuSv6j4kn0mdisoylivQZCYOLbxZ6Zq7aZM23UrR8pKe2H0cwaA/X+FxjsanQYE5KNwE4GTh0LDLIR5hk3w/voVOoXpxqO0VaLdVB7mcZTmZYDYPzT5mgU/vHbti1thQndMJgYKkl3Wv7Ys2bVrGkNrmvLZY8qLZfq9jzsQQTBunJ93PlcXX1ZgyaQrv+EzDslqS5Xdu3G1vAu2Sw/BN075jvmnazk5Dk3XgPuiFOprULmPO7Nb5irU8ZADiESQ7MazFJCyHeMGa5873msFIq8f7gDrOO96xi6e4wjZUqSqeCs6sn1rG+CeQotXzP96B+2obkZZaLzsY/yJ0EyDRaR7CYE2L3j2gaDA/DevwTp6my9+R3KbHNP8EOCWjWHzNsTnEHto3ZQfFH7aZDuf3iUTfN4Vuopgp+RxF1Jgiqy7oti4uoTDdtgD+OXcVM2c0XpHH14xAfHP9MyssUFH7p5EUtUa8S+4ZERtjPpBgLa/ho64zBsH1RycOb/L+Y2/xlboRwVswyset46TPP2aBsGx09oHpeqRa/lzLoXeQl5n88a0zujNWy/gqqZlYvzKXaCxxEmKx39CqJF4g1C+5FYrxxp7fLLh2bgWObY83qhMssQzktNDLb2aWpgSkbSfwo6sU7w9RJR/0GpKMvBEagKPNMJaerA7p1Ys4mKfZ6rbEsNQ0qcedoZSPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(110136005)(6666004)(38100700002)(44832011)(31696002)(4326008)(508600001)(6486002)(31686004)(2616005)(53546011)(6512007)(83380400001)(2906002)(8936002)(186003)(6506007)(8676002)(5660300002)(86362001)(36756003)(26005)(316002)(66556008)(66476007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWtLMUdXenFTNU1HRFNpc1NKeUhjVG5sVVpjSUR5RDVKY0V4WnNTc1BZVHF5?=
 =?utf-8?B?Z3k4ZmhnMG1VN2JPZ0J6RURUN2E4bGZxWGJRU2Znd3EvMEZkM0ZsZmQycE4r?=
 =?utf-8?B?bmZ0eWNlVHNlYUZtV3NRMzdhODBVbmJvY2RkMGF1L2RVZmlhWDdBWGhDbWYx?=
 =?utf-8?B?aG1FZXBNYVRFc3RsRWVkZHJSLzJaS0RGNUpQa3hDVGZNNFcwQkppMnQvb3c0?=
 =?utf-8?B?bmxyM3RMVkRuY3AxaVcrVGlWTWgycmRKeUJ5STJqK25Rb3dhK0VCUnNTVEd2?=
 =?utf-8?B?aThIa1J2RWFaMGhoTVY3QURjcm1wVjZPVHF0K0g5eFlEc1FaR3Q0bGROd0U2?=
 =?utf-8?B?aks1T2VIQU5kcXFSZjFGa0lLNFlLa3EzZkV4VkJ6cVUvMkJkdXVHRmFoT0tC?=
 =?utf-8?B?QUVDTmdYa3RCYWdIVCtlaUQ1c3JRdGxGb2hTT0dNbmx6bUNLUy9JWTlHaHU4?=
 =?utf-8?B?N1k2MjIzWEVqdVVGL0RnaEpRYkpzY2xxSFNic1lNSHNBbHpTZGh0TS9xcU5S?=
 =?utf-8?B?cUZBUmJDRDRnTGo4U3BYc3QwTWZHcFM4OFB2bGg3eTJ2bXJqY2Q1SHdrdEJo?=
 =?utf-8?B?QTBQNGV0UGw1UmFDcmwzNERSQXF5Z01NTDdvREhaa0NCRUNXSW9zdWdhcEpq?=
 =?utf-8?B?OXNsbUxENENQUmhOaU12ckV4UlQxRkdodVp3ZzE3Tk5zUjdHd2RnQkh5VXRr?=
 =?utf-8?B?dDNUbDNuMFZYTXlyQnljd0VxY3dyMExWc0Zkb2cya2Z6N2lLS25IWWtiS2pT?=
 =?utf-8?B?NXZBbVpmTXU5dzdNQUUzNWdsdGljaXhHUUlCUDhyN0xXdlhzU0hxMmMzdjRx?=
 =?utf-8?B?MlhLYUFEYWhMcXJmU3VTcTlZUE5SeXpHUm5OQ1F4blhQdzdwOFBoVHZ0UVpk?=
 =?utf-8?B?NHB1emFWV3VLc2xyTGpWaVpWejZ4MTdtMmYwSWFkT09ZWW9hWnRLamtjRGZp?=
 =?utf-8?B?T2l0OVViQWdSbk9SRjBDaWNjNk1JQU9qemhSd2JMSTAzSUhKVU1adUt5ZFNy?=
 =?utf-8?B?V3hoTkdsUVM3MWxsU2toZ1Z2RU1EYjJCUnlOOUtPaW1MV3JZVER3eHBOMjRu?=
 =?utf-8?B?UW11eDlrU2YvZklBL2tZRTVVeHhZc2NOUGNpb1dxc09XMGJFMWRlQnk0Ump5?=
 =?utf-8?B?RWxYQ1RoSDBFMkpPTlRUV3czOHJCS3l6YzU4NmNPWHdwSDRYVXhIWnJxR3Rn?=
 =?utf-8?B?TEZzUWVRYmVad000aWZ5bktCdEVhVHd0S21TUC9WUmRSNjdjWEdTM0xEQlZr?=
 =?utf-8?B?emg5TzFUNzJreENlb2dsVlppMGFYRjJjd3hRaWh5MktHNlZBWFRlNVVIOWxL?=
 =?utf-8?B?ZGNiNng5OTNsemFsVm9vZ2NJeXNZM0c5SjFVNWRJTXljN0JRaTB1SUxibGpj?=
 =?utf-8?B?ZGc5SXhtb2ZBdngrWEQyN1cvZlhGcUs5TThnc1FmWTdURFJ1cVQ0ZGpjWnBi?=
 =?utf-8?B?MHpSM0dLR1M4bUgvMUlReWVSL2M5QlZ4S2xJOFJrZGZ3LytmODl6KzN2MVB6?=
 =?utf-8?B?VFpXTndQS0V4S2JNWUtlNHJKWnRONmUrbTdKQ0ZhUXQ3OHM5T1ZvZnlDNktZ?=
 =?utf-8?B?VmMzR0dVMjFUQzJpdXZTajA4UWQvM2ZxNlN1aXBRNmM5TTBBajVhbDhJaVNK?=
 =?utf-8?B?eUNZRi94Q21BVG0vVmpSVDVxeElyTWZSS01tRVJ3TDlXUUVCQlhhYlhXWjVx?=
 =?utf-8?B?Q2tFVU5NbzJ0U0JhalFQa0p1R2IwWk5WWTBSNXNjRFFrMjdKUVRpWmhrdURV?=
 =?utf-8?B?L3VCeUFJZS9tcVJDMnpDZ1JLUEJpOE9wVFRHenFDOWVnZVA3d3VPOTRqZ2lW?=
 =?utf-8?B?dExqMjBrLzA2blUzSVdjaEp0cXNwb0tTSHl3Z1lGTWl1Z0w2TkhZWTI3Szk3?=
 =?utf-8?B?MWw3QkJZcDhpbHExZGlQb0ZWNUFhMGdjYzJSS3JjYmppSEljaFVnL2svM0wv?=
 =?utf-8?B?YmRFcjRkZVV6dmkwejIrdHhPbUxNVU8zU2t0VjlOKzNoYmd0blczeFVyQ2gv?=
 =?utf-8?B?ZWZJbzdyODRkMGhucjltOXlRRWtHVStxSlJZN2dDemN1ZURMZExXbGpxNkpt?=
 =?utf-8?B?SkxIZnBmb3NaRWIxdEsxQUptRXhJU0Q3SnAyQ2pMY3R4R0J6My96czU5ditq?=
 =?utf-8?B?MjRxcXZRd2Qzck9NYkx2Tm05Yk93d0RWbDVxZHcwemg4K1IrNkdiWmd5cFlZ?=
 =?utf-8?Q?wePiM5QGKHNTeBngNd3ZOXk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67edb019-8970-4a88-9532-08d9d456d13d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 16:32:39.6447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1kVtyCCMGQb98cMHwUzCi2PsCdMkOc7Z5C3e6mJo/v53Z/k23UP8u/5reKi7TYDVkY1diMemj1vbOZeiaeehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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
Cc: amd-gfx@lists.freedesktop.org, shirish.s@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-01-10 04:06, Rajib Mahapatra wrote:
> [Why]
> During resume path, dpcd_set_source_specific_data is taking
> extra time when core_link_write_dpcd fails on DP_SOURCE_OUI+0x03
> and DP_SOURCE_MINIMUM_HBLANK_SUPPORTED. Here,aux->transfer fails
> with multiple retries and consume sigficantamount time during
> S0i3 resume.
> 
> [How]
> Not to call dpcd_set_source_specific_data during resume path
> when there is no oled panel connected and achieve faster resume
> during S0i3.
> 
> Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index c0bdc23702c8..04086c199dbb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -892,7 +892,8 @@ static bool dc_link_detect_helper(struct dc_link *link,
>  		(!link->dc->config.allow_edp_hotplug_detection)) &&
>  		link->local_sink) {
>  		// need to re-write OUI and brightness in resume case
> -		if (link->connector_signal == SIGNAL_TYPE_EDP) {
> +		if (link->connector_signal == SIGNAL_TYPE_EDP &&
> +			(link->dpcd_sink_ext_caps.bits.oled == 1)) {

Is the source specific data only used by OLED panels?

Do we know that this won't lead to regressions with any features on non-OLED panels?

Harry

>  			dpcd_set_source_specific_data(link);
>  			msleep(post_oui_delay);
>  			dc_link_set_default_brightness_aux(link);

