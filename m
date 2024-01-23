Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6375FC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 09:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEA810E17F;
	Tue, 23 Jan 2024 09:14:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E8E10E17F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 09:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9JDGnHdLfyn+S+ep7NF/ubsgyk33ks6kRtwzowOV6d9icd4R4aDyDXxxIC0zWsO3QimOQCmn4Y1GDSs4GAamv7hMGS7Wm5XzO8lK7xwDJck6zAwXOuloywUd26HqXgqxV+HiuDH6JSWEU32xch8x4yE2qjBgG00wywp0QChaHdIDK2fiiFrv3oveXhfyxWslmWUqRGQYRvsYTBIFYluhEw9tgOrE8D/sHRXuAtco+ZFQk89g3lH1vebQ8yzqYQFz/fLfJzlzdoxj/ow/vB+Hhc8/fbm4VE/oxsurU6xFXavLwPSQVC3u8xNxltx1Mz7s6LaVX8YQISV3ScUSDHSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EGvfQ98Tj3TsGFbOSLWhZkdsRtmLpk6mgpJOdLlE30=;
 b=CEmK1Thm+UjH5raNrniHBDe5qBnVa9Z6XDQSI4SZ1/oBzybVzNfAHLdrer+mCwhIvdiaWHqhRvIo8lr6cZob7h1j++Pdmx/HUIVZYwsH3n5NCfg2tAdr2DOW/4p4Wge+rVOfvJyi1gXydz3jMhyXByEMBvVG9OWjaakHBQ1JLjwXDJIYfXNoZUb50hZBxhEukxPr/Kr39vz5otcozXqHxBnbU25Qmp1mmQTCzTU3Thhl3K9QkJ6il5wodWSCvAjeA6mgFHGC5FunfNOgCE+pk9qACiMMuM9lVoFO/fNZ0s+Yw98pF5lhCLLo8ciRlCFB0OxyjyXhrdwo5cBVOFRclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EGvfQ98Tj3TsGFbOSLWhZkdsRtmLpk6mgpJOdLlE30=;
 b=eJTwE/D+cN1bS3IbU98q8eJbqhUj73NrQtVuwS0e3jssqyKSg1sC7etOX5aNpgbwt+npD8XnR2daJ5/v/uom4mBoS6rR64VoeiB1WZ8yvVKwgnY7wcnI3zRZrmnJBkagrMzL55Upv5JlXxJgqNaDy6y1/XJ6BLaoxgtAoWJX9Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 09:14:32 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 09:14:32 +0000
Message-ID: <f26f43b2-991b-4ffc-ad84-1307212d1ee0@amd.com>
Date: Tue, 23 Jan 2024 14:44:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: covert some variable sized arrays to [] style
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240122150001.732948-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240122150001.732948-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: dec1786c-c5df-43aa-71aa-08dc1bf3b57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrQW5F/nMFT9g1xX+RO3TQ0QnZ8YY9EpeCd3Danc8nGKwX49g6cBNJYgSFupCD2nbzhMNP0YkFUBuj9kNBvvc6U7ZvLw/lqMeBeJFqWI/LODVX+tapjl4lGMK2GF/ylqFpV0WVXNTEH2lfPJn+SOIq3ON1CGy0M8w0mWQj00xRlbub0X6v7cngsaSPJ5f1HzspZq+fgMThV7az3eRDED92bMlhH7/UNI+G41PMEND2HACAOfor40N7nXet76uhbSVEjy0lUpP+0s9z/yDZ8RfYdHpw0zrExawoZ9e6VMmZlHfodJcy1azVsjAayFSJeGmkXI/kRMAF5QsYv2jEdV+emWm+qzSezzQBgjYzYKsWev3GKiSeyGEO2mfS1m1pjXsi4Ygu7bmimo1DEhknUCrus0YrDCAJ/Busa3zq7XFHm7DYi1J1QZadgRH5PIOdJ7uBg0HwpBk6ezflIhCKFkojnKO8laMZr7er1osXudoeq9WHvW2E3r/gNxrEuL3DbQllvAALh5IXIEOzWsYPzPSuN1sYdda7Vqwk9imtOHG/zo99wblSUocTW5tDdPi4Lia3zcT0pkR3BRxxkmrYv9kEnbqQFeVHRXxdFKIDS7Xq9CgQocQIGiCkhxTLXnM7oBeFPjfJ0bMo0IC8ElVDoYGyTV6PQ8usrweuquTF2IDsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(8676002)(316002)(36756003)(5660300002)(66946007)(66476007)(66556008)(6506007)(2906002)(86362001)(41300700001)(31696002)(26005)(83380400001)(38100700002)(6666004)(478600001)(6486002)(966005)(2616005)(6512007)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dNQUhDU2JJNVFJemZFWCs3WmJ6eG1XdDJIUWFaVDZCK1FQdkZUR0hWMU9Y?=
 =?utf-8?B?Nld3V3c5a1pkTGUwVjFEcmVUWmtVbDg2MmEwRTk1bnlKUGFjQURlVVNuRlMx?=
 =?utf-8?B?YU9BNWl5WGJ3ZzhEK1BJQWY2dmcva2lOKzEvVHUzK1NHSUY1Vy9aUjB0T0do?=
 =?utf-8?B?ZmtSazUzT01LOGpDZjI2QjJsRWc1U2xsYVE5TWZPRXFNMEI1MUlDaVQ4MXUy?=
 =?utf-8?B?M2J4a1V2RHFjRzM4VHNid0xDdzIwVmFqaXA4NC93ZkRwTkdURGJBVHR4ZU9N?=
 =?utf-8?B?V0dPMUp3QzE4NUpXaldhVDhhK3JmQUlLTzdVNjZNNCtRYk8xd0h2MEdZOXJP?=
 =?utf-8?B?WGo4RXp1b1lmcVV5REJjWXJSS3pqV1JBdjdIVGY5YTdOeVB0RXBmUTBxd29q?=
 =?utf-8?B?aTFSeS9kbEoyQnJIWEkrSUh0RmdLMUVCZUlETUpQVXRGbDB1aU92VTF5YndB?=
 =?utf-8?B?WXVPdE1SektyRlptakd5QXIrcVd6UEtIdlhjay90YURDNFJ3WC9pa3BFNUNr?=
 =?utf-8?B?allmaDJuWG9aZEJPUUlsSkEyOEE2L1pMclpoaHNqQU0zWlZoSS95dDRSNFhU?=
 =?utf-8?B?MU44bWxtWkpxODJEUDZmOWlmN3A2Y3U3WnUwNnRoSnBDN3dHUTNJUzJiNkJq?=
 =?utf-8?B?OTBkU0VkVmp6VFUrbVJnZVZXUTIvZC9ldHFFQzdrV3NPMk00R2FCbzNWZmRk?=
 =?utf-8?B?Z2xqT2Y1WCtUZDRRNEwyTkp4b21jV0ZlU0hIZXRmM1dKOWExM2thOGdRSjRr?=
 =?utf-8?B?UzJUdGRESmhiSGhtTFNGQXQyTytwQ0d4aG11aU9WZ0c1Y0ZCZ0Z3V0kwN3hr?=
 =?utf-8?B?THV4VmpMQzBRcHBySUJ2Y2VHUjE4NnRRWDBBNTh1ck5GcFJMemN5WGsyWFV6?=
 =?utf-8?B?bE1IT3VPWGRReG9uQjVIME5HWHVYMmpSWHE1TUxPNGZNQmZmR05vRXBqM1o5?=
 =?utf-8?B?QWZrK0Q1cWRBeCtGYzlzaDNubi9CbDhla2tWUDcrRXd6aGR0cmx0a2NTekti?=
 =?utf-8?B?eHJrdmI3eWdOQ3JDaVVWMk9FL3FkbG1NbTBmNkpRc1doNGJ6QmFPSy9vaWtU?=
 =?utf-8?B?WnZBOVpTNHlyc2RkSDhzeUlqblEyQVQ2ZGtEMTU5YklXK0EyUHdkWlFLalIv?=
 =?utf-8?B?UGR5cU9LVzBWTVZIb1NmWGpjR1VWYnM2d1hiRG5nSFNGRHoweGlPQktwWHRv?=
 =?utf-8?B?Zi9mcWw0bUZFMkloK2hiZVhEUTcwTFdNcmFvV2RuS01ROG9QWGVLL080anZk?=
 =?utf-8?B?TzRXbW00WU1KbjhaeVJQTUgxTG1rNWFwdkZzbEY5ZlRxZ2pKaklHeTJac0p0?=
 =?utf-8?B?OG9JVlR6b1BHa3VoTmpKR2ZDYjNDSFpPdTVXWFlhNEIwc0NmMC9aTTMxcUh2?=
 =?utf-8?B?ZzR6UGpMTTh2MXQ0L1czaXVWcEd6djlhS1FBUWRESWlhWHF2eXhSYkE0amR6?=
 =?utf-8?B?WEJLOVA5dE4xQnZKUDArVVU4WW1NZlRJeHpnWVVlT2czZHk0Z2NKRTdoWWgw?=
 =?utf-8?B?SEdoUk9FWGlsNCtZMGhURDVFVjJLZi9pc1d0M1dTc081N1IvbmFKUzIxT3dZ?=
 =?utf-8?B?SGgyRmgrZktFNWJ3UjRFelZzdFJsM1FCSldHZkFVM0hxUmhhamdwUG1yR2JW?=
 =?utf-8?B?Smw0aXljRFhBcXNXSzBkNUE0TW5XcEJZTDhuZUJrOWhEYVptdnpRNlNIdXVz?=
 =?utf-8?B?RzVEMXZmL3J4ZnVEN3A3dWFIRitDeHEzeUtRVXRLbnZKTXQvMzZDdGtJYWIr?=
 =?utf-8?B?OUpKMGVXK29Mc2krcE16emxBR0JyeU9LdDVJclpxaVRZc3FRdWV0VENCeUdE?=
 =?utf-8?B?TVF0ZVByRTRmdUUxNFY1Q1VHOFBnVkdQUE91NzJvdW12NG9jTHhDT1dHaVJ0?=
 =?utf-8?B?a0hnTlNYNDg1QkduQko3MEkrSk00R3dHTk1QcmJZS1JnK2ZjeVE2RFpydHZF?=
 =?utf-8?B?eUJVVlg5NWFhWk9yZ2E0RFFBeGZCNWdMMzBOa0Fwd0cxbDNRVHFOMzJUaDZ0?=
 =?utf-8?B?NlFnRVplQm9laVZiZ3hPZ0Zhb28xTXJLczJiQlUyUFhVT0NkQjE1ZjhmdlV0?=
 =?utf-8?B?QnBFVmRXZ2xjRU0zWmtqb1RlUGpOQk5uRWRPZ1pDOWpvRjl5b2pSVlVycGdu?=
 =?utf-8?Q?KME7oaV8f8ref77TU2scmjYks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec1786c-c5df-43aa-71aa-08dc1bf3b57e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:14:31.8767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg7y5ruGAea3UQVae51X82XNxFQKd4JOojpgcFKqTykxla7EKnyus9HWqb5BZFJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/22/2024 8:30 PM, Alex Deucher wrote:
> Replace [1] with [].  Silences UBSAN warnings.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3107
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

typo => covert-> convert

With the typo fixed in the subject -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/include/pptable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
> index 5aac8d545bdc..ef3feb0b6674 100644
> --- a/drivers/gpu/drm/amd/include/pptable.h
> +++ b/drivers/gpu/drm/amd/include/pptable.h
> @@ -491,7 +491,7 @@ typedef struct _ClockInfoArray{
>      //sizeof(ATOM_PPLIB_CLOCK_INFO)
>      UCHAR ucEntrySize;
>      
> -    UCHAR clockInfo[1];
> +    UCHAR clockInfo[];
>  }ClockInfoArray;
>  
>  typedef struct _NonClockInfoArray{
> @@ -501,7 +501,7 @@ typedef struct _NonClockInfoArray{
>      //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
>      UCHAR ucEntrySize;
>      
> -    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
> +    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
>  }NonClockInfoArray;
>  
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
