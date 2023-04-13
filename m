Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA40AC77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 17:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5803710E008;
	Thu, 13 Apr 2023 17:46:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4944410E008
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 17:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm89JLOsU65DRjURCkBRBLBYhwMg0xXtSWeMoNfouDAsKspKPsGdO58l4iw5Mv6GP3iL64hBQ++x31Uqh5nbZtNp4CbiP6ej84RGlp3DKBFlGSOuipmIYDXA4/+XC7JKWVc//go50A6jgli5+HfYF/XHCAnfGDT4Ky2BbmFmNlcy2yf2GA2Mux0pamLNImV00Wy+69aCMI3g+lf+Bzr7QI710kpvFafrunI6TD1chmaTSmgCDkfzCiAunX0QBMvS5f2diDiCZXjPXhGeH2PZd9fjNpppqNyNa8DOKbIGfHkYHSCj3Ui26Vumui766YMibTAxI5L+mGrtvoKAYK38ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDQY2hLPOHS7s6MxhdiZzcCpgAon+aHFqrQfI+GzvwA=;
 b=f/W3V/Ee2jWg8F49ef05kLvW/TD0+0VlEk8xL4N8vOkiIVi/NUQ7sSQxhui2245h2ZvIKvtml3X12qo3AYG8RpNTXzqeihFf/UP7kGnZv7uQzGO+J5kRyGN4xQSOZbOHz9V79LAYRlNkC5btmTYBy3twj+F9Z3WdmGxoSusL+ZkaT4q6tEr9idORPUAEdhQpq1WPir/h46OUTCIkMY5Qm7S0jteQOlFQRvEegv++pCl7NHo/8qG8Oz597y67niSh9VsSqgER0DDBZjg+Psh63NkewhTFqpPA0adjwwntpRI0c3NMi/EeK0rHhXVhEW8VjIK+4rEwkdB8Q3P82dRnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDQY2hLPOHS7s6MxhdiZzcCpgAon+aHFqrQfI+GzvwA=;
 b=XBdByaR90egM9ZCOYyC+9vBiIciPnyKeHyIeZBBc6teiALh1/KTx7OTGzS7/EfByEU/+f2H3LWExZf5Or/BmVNgcnurz1RR6mKPuoOcZ0kTyvzqNnBV3qayov/h0k45T2VHdvTnYQTu+iGm3C6cB5iuAtPUKfS8DZus/HOCEaVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Thu, 13 Apr 2023 17:46:25 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 17:46:25 +0000
Message-ID: <1d378200-98e9-033b-8ee7-f371848c170f@amd.com>
Date: Thu, 13 Apr 2023 13:46:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amd/display: Improvise error handling for DP sink
 power states
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
References: <20230413161704.2262865-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230413161704.2262865-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::9) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 840a1fb7-59b9-4dce-20f6-08db3c470058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LovvIMFT8F2ZQDi/ghNxE44ON/J84wF//HBhPopjdo4JbzCReO1XJBz2ebKGf9L2GK5b86oOgC6s0vzK7ETWuN7tcsAoeaqS/LhlsZdXUgKBoBL6ZHrXPhL/SZ/a8xVDNRaBnWenDMPAjSJBFZsWBWNNKKZQh3pJbf5F5ia7VzLLM0L+mtZU0qMmxbswku7xX9AWp1JJz0/2wEoSD0hqebwBfM8yE6XnIcYkehFh/3yisPJjmUWbso5CYjvB0358z0K4mUdEbx6s7Bw+0PXVoEHBy57pSEsF5w3fv/jMPUeft+AtmIrTAavFa2gllYQEvB31npB/nV5FEPM20CB7sdJHkqFof5Qt5kCjHz2NZl2BDKsa1iQxaemNom8dFcfKsHpvKM7UlZ3HBDKg5vZzmVCenWvofQXE+xfDMp/PKxwk/DPb8g9GH0EugIuW0Oq7s+xlBHRyA0sbnuFKEXPJMw9Aj0yWRERSGW5zAWrbfgE8mJAPectdNUaIZhZTp9n9iQvRbPEF3UfHHuy7sBbUFfMOQ+Fygx6nRsgJOtYCSSfOsqCA6jR8lEHHVuwTqrOCI3/HBJCFK4uTA51OY1F14m4VuIhbK1jLyqdu8fzKyNARAh5ojxZZSF3dideKXmEpeEcUJqs/x+jILhvsMbmLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(6512007)(6506007)(26005)(186003)(53546011)(6636002)(478600001)(110136005)(2906002)(8676002)(8936002)(41300700001)(2616005)(5660300002)(44832011)(4326008)(38100700002)(316002)(66946007)(66556008)(66476007)(86362001)(31696002)(6486002)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdEa1lJTDhxRFcrZno1amVEZERnYUR1S0gzZlhvckFQNjhYNjF2U2Q3bWNY?=
 =?utf-8?B?VUIyZlZ3MVhJdUxwZHFuTGtTTkxTNkd2c3Y0YU1HYUQ3OHZ6S1hLNGh4ejlz?=
 =?utf-8?B?T1prRkV3MkViUHdyc0R3WUFnRCt1ZVFBU1NVZm40QjhHV2dSMjQ3SWxhTTJM?=
 =?utf-8?B?dHE2VVUxTlAwdnVjUVpXS1JzY0tEa2x5K3RBalM1QVArTnJaOGV6Qmh1ODQw?=
 =?utf-8?B?Zy9EWmo2ZUtyVnliTDN5Z2U1MlhFYjhwbGdSL2xYd1loUnQ1ZTQycG9vREls?=
 =?utf-8?B?U2xyUW5WM2t0blhZZXYxYWpScjZSTzYwd1dVSzUzNG50THVENXhHU2pUQXRi?=
 =?utf-8?B?TUxsd3FaeGF1L1ljTlIrOUhtMlZrUzhqbm1PS0ZnZndNTmxYaWhDRlRTUWlF?=
 =?utf-8?B?akc3RnVCNExvTmxHSmFmdm8vK2E3aXJMTTRLTEUrUkkzeU0reE1NQjZ4cERU?=
 =?utf-8?B?WWJpRWhkR1ZudHJyWXpjZklBNEVlTUlNY0E4a1I4V1ZGMkFLVHE3S0dWMWg5?=
 =?utf-8?B?K0dYWTF1SHB1VmMyVTZEMVI1SjhrTG51NEF6VXl3Q0E2MFg5TU9LYTAvN1dR?=
 =?utf-8?B?dlVuaEdSOXRHWEt6bURxdnNPVnpqbDhteGx5K2YyaGRjNjRVcTcrRkdsVU8y?=
 =?utf-8?B?L0x4MHdOUmUrNkEwZWRlNUdHRC8wNUJFNnF5K3lVaW9tV2VGNmFsK3pQT0Rl?=
 =?utf-8?B?SkdXamEwZXVJV284MlZGLzJMVnUyWWh2NCtjRUdwRG9ubEtVNFJPZmdjMkZF?=
 =?utf-8?B?MllUd0VXTmJYM1JFZEJ4T3d0elJ2WTFHaFRBcDQ0THpaUkEwMTNHaWNPWkxj?=
 =?utf-8?B?QmlzaEpKbHVWeU5WVkNKYllmYU8wRHlYVG5HalpHV0J4bGxWbmRra3FMNHJp?=
 =?utf-8?B?TThtK2M0T2FpVjhPWjk0MVYydU13bDFJMWc5blg0akhsRFU4c1pPK2hvUG5x?=
 =?utf-8?B?aDg0ZnJ0TkJOalJ1YnpvRnBybS9nMEp6U3grM0NqQm81RkNPSFFZNklkVDlr?=
 =?utf-8?B?eXozOC8xQjRmWi8vR0RYUWJxUE1HRjcxL2dod3ppeUJMUnI1RXJIOHdJK2Nm?=
 =?utf-8?B?bVdxZlhOTnU3MXBDTWxIU3Y4N2VEUENnY000T3J5UkhTRmFXK1pNWE1GVFlP?=
 =?utf-8?B?SVUwVjluWlBmZmp2dTNhUkVSNll0TmhVdFI5ZUtXNncxcGJJeUFVN3prRW11?=
 =?utf-8?B?T0lKWDd1TldoSVVySzMvdmZoVklHQkVmSGdwcHBDd2lsN2ZpQVBUMURGZ1hY?=
 =?utf-8?B?WjYrRDE5bEdSMjhnWU5LWHZ5aW5mWkQzSWZZekhWL1pLTDUxNG1tN3lKVWpM?=
 =?utf-8?B?MjhqVnVxR0FuM0o3QmJTWGxRUFVMUHdQWEVudjFuYlY0Wi9JOXRzUlByWGVk?=
 =?utf-8?B?R0pqOCtjMTM1Rys1SU5tUXVrZ01sQjNPa3BxTS9vR0Iwc1VOTm40VEVtVmRG?=
 =?utf-8?B?ZHNtQ0Z2SThRRlU5Z3k4dlpJRGhkaCtqWmpacXVzZzY0NDBrTVpSZEFVamdZ?=
 =?utf-8?B?WUdNQ2NxT2MwWVNkWG0wNHhoRXl6V1cxeU41N0FKZy9OZHZMQUhjaThxQ21k?=
 =?utf-8?B?ajhBdGVPcXh1aGNjK2ZjNzBmbHMvc0lsU2RnY0xQT1kvaVp4OUl4WktRalpE?=
 =?utf-8?B?dmFRMEJsU2RzL1YvVCt6VUJ2alRUZTZnNVhYSGdFdjJsTzJkZjBuN1N4Q2p6?=
 =?utf-8?B?bEpnakI4Mm1XMlJFN1NNMXVZUVZ5Zm1TRFpCa2d5Q3djcWFSamFDVENaZmQr?=
 =?utf-8?B?Q3ZNQVh2cnJXV0pEamxURkgwbG16ekRFS1NER0JLS3ByQmtzNnBiakx4eTU2?=
 =?utf-8?B?dE16MzdCRFRhWWZHWHROSFAyd3R6RnJkcHpqb1I0SlNrSmpranJZNTl1VUta?=
 =?utf-8?B?TWxpWjJ2K0hZc2gzSFd3Q2V3UDJ1ckdjT01qUUtZZ0dtMXRpUW9zU09xTVlG?=
 =?utf-8?B?OEFtaGVaYnVEcnlRakxWTGVqZUlvOUdRZmlsckU1OVkyRVh5R2xBcGVXRURz?=
 =?utf-8?B?eWd2NDJMYXdPT3B4Zm02bFAvM0dnenpMN2J2RDVlaUF2Y0tOWDlEWWRVQlJF?=
 =?utf-8?B?ZTNLZlR0QVhjUFhsWm14aTVnZVVzZTViMHFOdmZ5WXZoWXBiUlZ3WkN0R3hZ?=
 =?utf-8?Q?POEfNAHX5omYBTSAqlr7WprUk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840a1fb7-59b9-4dce-20f6-08db3c470058
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:46:25.1687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDY0doamVY0uU2oOg1BIPyWL9EQVtr+F4Wt5W4aTZfU14mKEhDqSp/IFe83BNxQSciF9Q+dYUZdCHczd/K27HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/13/23 12:17, Srinivasan Shanmugam wrote:
> Log if we fail to setup sink power states.
> 
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index c840ef17802e..adf6a67e0e5d 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1043,6 +1043,9 @@ static enum dc_status wake_up_aux_channel(struct dc_link *link)
>   				DP_SET_POWER,
>   				&dpcd_power_state,
>   				sizeof(dpcd_power_state));
> +		if (status < 0)
> +			DC_LOG_HW_LINK_TRAINING("%s: Failed to power up sink: %s\n", __func__,
> +						dpcd_power_state == DP_SET_POWER_D0 ? "D0" : "D3");

Isnt this more of a DC_LOG_DC ? Link training related code was moved to 
a separate file.

>   		return DC_ERROR_UNEXPECTED;
>   	}
>   
