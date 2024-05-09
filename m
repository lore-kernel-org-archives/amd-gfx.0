Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F18BC10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 22:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981DF10EAF4;
	Thu,  9 May 2024 22:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NGhD//qB";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E2710EA23
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 22:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fszFOEPlerMNIMy9AY9xKfeRTVg6DK5jWEX/IFhuTh1xM9OJAgefEOn45MA/AOVRSF/w+2Cujl1kbPOtungXeitbjGEFG20MnXN+jNLyYIYYFNbSQuqzzWWfEiXmt5qrxVxViqTigjQFJULPVqrRikWbQ9IwuonIxPyC1oZAZ/Zl311Q0QaNNDo/pzBx5Z9pwu0ATinneuBCAbpMxAEirZ1UolwKEtgirLEJx02TkcFQRI0FFpOhYHvTkyZWuoGra+lCfAOiBGYvXsNoyOUDMI+LrbVwf/tU6VyD+fsfh4wPE0rJ4viTQbZ57CGtsPgSDjFNO41BOv1s2wFjwKRTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Syvnc4F9R4wElHW00GslK7mXim7bpQBTn2DdbxpRSjE=;
 b=WpWuXpmx17pj3oCO2dat7uUiU7gM1tgu86Lw+FWRUXlM9SBzWidhm0YSX3hitx+US9M/FELXHPgmICKXM0HqTVfF8P+TvjsChl3dRMnGR5xBbRxpa3LWl6TGDKSc/6FHM+b35z4H9wNkZrxXt0fnWvDHN1jyo969gwnAXs55wuDJpoU25GoIxSEVEmwlp0PbbqsOYSndOMvQwL2265kiMyKMKQ2Ai6fWLoDuBHUbsObCy/jnkeP+CoHnfqrhmU2fTlWCx79EgrdRyyBdNyWu2iI1FyNx+yayUngYJneK4cSxJGpaxSLJn8IBYKVJ35J/Sg5B3bN28f8XRoNHY9O5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syvnc4F9R4wElHW00GslK7mXim7bpQBTn2DdbxpRSjE=;
 b=NGhD//qBwWfNAkJQSh8OHbS751WLJ2EjfH77lcGWNbotCILNIf1hgnWIWMqvfxr/jWigtIU7z0y18O1F5nYfeZDSUz7tymdyYWQawrQUabVwuZD+DSAQbDSxfb6ZYoTSb/wOetnXgHzkUZJ4uKxnaUZ1SRLfW2LG8sYnt7se/HE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 22:03:38 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 22:03:38 +0000
Content-Type: multipart/alternative;
 boundary="------------DERVUe4ElAjWNIsdv7e3crUe"
Message-ID: <678ac44c-4105-461e-ad32-83b0ecf04576@amd.com>
Date: Thu, 9 May 2024 18:03:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/jpeg: keep drm kernel message consistent
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Christian.Koenig@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
References: <20240509204631.1489565-1-David.Wu3@amd.com>
 <CADnq5_MMDTkoAnj+174wu_X762FvUc27_7RkzU+KDLrCrO55pw@mail.gmail.com>
 <cdd46ba4-4ceb-45d6-a204-4097216df9e2@amd.com>
 <CADnq5_M6+yMtMDz5kr6FYZyMT0ZB7pNc5Ln-vSb6e45Cn71V=g@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_M6+yMtMDz5kr6FYZyMT0ZB7pNc5Ln-vSb6e45Cn71V=g@mail.gmail.com>
X-ClientProxiedBy: YQBPR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::22) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bd7b76-0603-434f-093b-08dc7073e18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlROMlRMcE90bFVKS0xaM25oYXNIcHZ3NjVzdlFrbU9SUWdEODJVZXo1Q2hy?=
 =?utf-8?B?Q05UV1h2QWNKU3VBWk5Udzl3QVZST0tpZGNJNSsreXBHTTVVWnZKeDRrbDd1?=
 =?utf-8?B?VWU4N0NyNmxrOFdKM1RnalVteGpqZUw1SmZQZ0lLRG8rc051RllnWGZCdjAz?=
 =?utf-8?B?alZmKzZwUnR5dHhzRUtnUktIVDN3Tmt2VGhZNXRTSFhMRVo3TGhSY2d2aCtx?=
 =?utf-8?B?Rmp5dloyNHgvcG1HeFY5b2N3b3RUNFplTHlONjZFQ3NjSHlLWjZocS90NVZa?=
 =?utf-8?B?c3Y4YTNrQ1lxNGMySzY3cXBxaE15WDFNQk9ja3JzYi84OHR2bGp5MXY2MmFo?=
 =?utf-8?B?Y1NOM21ONXU5ZzhKK0V0RC8xSFlKa2JjUGNOQStwZDM5bk9hMUh0RGc5Ky9Z?=
 =?utf-8?B?YVMrcmZ4UFA0U1JrZUZlRjRCMHFuTjZ0WDZxT2llUWhMbTA0RGRQaGVoZXAy?=
 =?utf-8?B?NUJEUEV3YktmRlQxb1dveVRsd3g1TDM1UElYZFE5WkpOcmZ4bndGT0lTaFpD?=
 =?utf-8?B?ZU9ocWluTXcvRzFWOEE1cXJGOU9HdUlaZTl4TlY1T3ZZcU5aR0Z6bHFDdVRt?=
 =?utf-8?B?QWxjTU53TnN1YXM1L29uQUF2RTRWcEY0MWF5WVpjYVQwaXN6SSsxMXJ1U29S?=
 =?utf-8?B?YWxXZDh6Ny9RenJJL0lMNkpML0haejNMRGIxbk5CVEFLK0xkK2h6WjU4VWVR?=
 =?utf-8?B?YXdMYmV5ejlzd2t5bndVUWZ5d3NQY0hNNDI4YUduaHlHYkpaeVF6dDdCOUJ2?=
 =?utf-8?B?U25zVHRYcjBhYjNkRWlkODhVRFBidmd6aFdqN2x2NkRwVDBZL2FOOE5sQUY2?=
 =?utf-8?B?SFBOZ1FtenVBN1Vmb1RUMEpzcUZObVVoNFdrRHkwVEF4SStMM3F6Z1dBZjlQ?=
 =?utf-8?B?dTREdUVkQWt2SlFna0hMWDE2Tnk1bkR5ZGhEK3pVWnYyWGxRU2M0K1ZWOVQ5?=
 =?utf-8?B?Vjc4YXpPdU1sR0lCZXJicTFuUlA1Z2tmelZqV0dHY0duQzBzUG1GNVIrSHRx?=
 =?utf-8?B?RnZ1bDE1dThUNjlvSjJHenl3M2xBbDN5dlpQTmxCNUQ5VmtXVWFsTkRzcXpG?=
 =?utf-8?B?M1ZEY3VOV29wMzRtQVRad0ZqMUx4SS9NUTE0NFRhY0NJTk8wVmcyRzVJU3ZU?=
 =?utf-8?B?MVZlZ05WTlZBMVNGRExBb3pVYkNqdzE5YWNGeUdoWDFGbDFZMlBMaUtFQ0Fi?=
 =?utf-8?B?cVU0QU1KMkh2WG03S0NQdWlaZzlZbm44V1NibTNWU0hNMS85dlJicWFYTGp2?=
 =?utf-8?B?Z3crT29QbXdRK1FFaTg3YWNSY0FHUDZEZ1ZVRjh6TDNyT1dnMGl2TkdPOXhq?=
 =?utf-8?B?cWs0Qk11QmVLL2Q2LzVheXQxbFhyWForblFnUWxuWnIyS2VBcUdHK2lvSUlt?=
 =?utf-8?B?WVMvQTgrVWVOTXpiZ1Z5SzFucE9qL0xLWjQ3VHgwZkE4VXJLMVVVS3lkdjl6?=
 =?utf-8?B?L2xiQ1ZBVkFSL1p2N1M4K3YxYkw5Wno3eDMzckpHOWxpdXVQdWpSQ1N3amts?=
 =?utf-8?B?ZHdiWGczNnJUUy9PZ3l3OU1LNTRYRnV6bWRHbmlzbm1Wb0FqZGJmSzM3azRY?=
 =?utf-8?B?V1VLNjR3bXVBb0RIaG1tQk5NTXVSdHBWVVhTWXJ0Z2VHcnl4eHgvTGlOY3Fa?=
 =?utf-8?B?a1pxUElQN0RSWFN5OWF0cDgxTFh4RzRXY3ZIK2xEbk5CRTZGTzZaazRxdXJz?=
 =?utf-8?B?dFB2OHozWDdwK2RHRjlEZlJxb2dUU1lmeGNwTTIvT0psblRLMU1VandnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEoycnhSZXlySjRFYmFXUGJROVFEQ3hVVkN4eUNEOWowY1NTNjBTeTI5Y045?=
 =?utf-8?B?N053MCtmZDF6dm1WK3hXUFJLMmhIbFVHKy95V3VSbDZ6UmRuWWtDcVA5TkVm?=
 =?utf-8?B?eEdpVXpBRys3dkR0UGhLU1dTR3Vha25QckFRYmprNFkxZXI3QUxjTjI3S0My?=
 =?utf-8?B?YjBQQzRnek1NK3BJZ2c2MDN6cnl3NnNvRkYvT3NCVTRYcnRTOXVCSmg2clJV?=
 =?utf-8?B?aVZVZHlNTzZSNjNGRmFtUlB1eStiQ3pwSHdpRS80anltaEtlNnRqUkJwVVRn?=
 =?utf-8?B?MU9hQjFubStUZER5YkIxRUQ2Y2RTSWZ6clBRUGRTVmFkWk45emxkQStFQnhH?=
 =?utf-8?B?ak9kR1lwYTRQMXdVRGsxb0tvZmowWHdUaUtTYjdETGFBUmF5bGNOeHpIcXd5?=
 =?utf-8?B?TXpWWjE2VXIwRHFJWE14NUd4YUIxVU1Ea0UxSGdBdWxBZEt3SkVINUtZRXJx?=
 =?utf-8?B?eEpCd1YrVnBpbW5za2Y3Tkw2UWdFVUowWk4rY0FldlBnTFdmd0xia2kzRVJD?=
 =?utf-8?B?YUhZWGI0dmJ1YWNQdGhYeVRLUGwzMThUZkhQUjZKaXhZUGxOemk1UjJnN2Za?=
 =?utf-8?B?cXYzOERtbDF6UU5JSXNnRUJ5NmhkR1pGeExaaEZpNG83cExDKzZHb2dMVHVy?=
 =?utf-8?B?dHpYL0tGN0w0aHd1L1BVVDZYTUFUbnZXV092bldnTmdCWGtTN1VZRkJaUHYw?=
 =?utf-8?B?Q2NJNEZGeHNWS0UxUXFLZlZPcVMvOUdkVUkyR0FleTdENjRhT1duZHdzYitD?=
 =?utf-8?B?b2syK2JRUnNKSXF1V0p2UEFFVDVGanI4QnIycmdTclFYZ0p3TEdpYmpKWDlK?=
 =?utf-8?B?aFFGUGtUUWYvdDZLUkhNTjQ1d1dBNEZIZEdKaHVQa1YzNUN4cXkvTlBsbmpt?=
 =?utf-8?B?bitCRnRJcHowQmUvVXlMV1BrUjg3WWcxUU5iTXY4T3dDbTd1cHQ5TUZWRDg1?=
 =?utf-8?B?QnZOSDVQZ041QjdNUzZWWEdHNUd2ejlVTkpuTmtlaXV3ekJUbjJXNktHRkMr?=
 =?utf-8?B?ZWhSMVpKbzIzL2N6TnF6c1J5MExzYzhLamI0Tk1HeTA4OTRRSENxTzYwVmRB?=
 =?utf-8?B?Q1ZqRERncHdpa0lmS05IOXQ1YVdjQ2xoc1RwRjRXSWYzVWhKa3MrR3dHc1RY?=
 =?utf-8?B?ekYxaHZuWnNxWC83OVJtRDlEVWRwVGZJR2JGVjNJaFN2bzZ1VlpZQ1Z4OXF4?=
 =?utf-8?B?MnJUZmZwNlV6ckNJSHF5cmlwU2lFVThFWTBXT216YXMvRXc0UldXcEJ0dE44?=
 =?utf-8?B?eEhJQXlyRGpXZzFULzF6YkEvL3NSQ21LenFwZ0pQSkV0VmtqRmkvbXVRTThM?=
 =?utf-8?B?VWZKMVBaOWMrNU1WQnRTbUlLeWJ6OTZydFg4UjU4cWFYdktGbDhCN1psZ0s4?=
 =?utf-8?B?dU8xSkE1UkhlTjF2dUFtQnU0YytWWWhIN1MyWFRjRXlLRUpWRFcvNDhwdEJn?=
 =?utf-8?B?ejlPMlpVU0hHazBBV0pxM1VIdDJFK2Nrc0lBeVkzemZBYm5tdmxxVDF2b2Vw?=
 =?utf-8?B?YzFxVVFkcjlPTXRSb21YYUt5RU1KSU0vdDZuSmtqdXkxM0g0OFpiVTNJV1dX?=
 =?utf-8?B?RSt2dktSZmVBS0dzSGRXZ0JRTDFMdUszNmtFSDJpN1hCNElQUytRdTJkWit5?=
 =?utf-8?B?L2JJN1QrZkVuN2F1V3dYNk9jZnJ2b2hiYkhNdkRiN0U4NWxzNHBQcU1aOHN4?=
 =?utf-8?B?emdvRitWZVFKTkQvVkFNZGpIcFFDOFgwNWpDZGI2ZjFuMURGRTZNWUlVeGto?=
 =?utf-8?B?M3N5d0JVbWJPNjF3RXVvWU0yMkdEUGhHZmZLMDJwZk1kTEF5WnFNeVROK1hi?=
 =?utf-8?B?U21ESWIxbjVQcSs5Mm9aL2daNnhHK2hVbllKeEdZRysyZUJGTVJ6Z29mUDRa?=
 =?utf-8?B?by8wMFI2czZ6bW4rUVNLekxjOFJIY2c1em1rRHFTN3JKRGVWZXJ6RmRKT2ZK?=
 =?utf-8?B?K2NWZlpDczZGQ1NWZm5uN3FUVVRtMU8xSW9jM1MrUUpFei9CZEVjQ1czcncy?=
 =?utf-8?B?QWJPb0pHWWxjZVRaZW45azBHMllBaTVVMlFVeGVBVHVjbXIrZDJqb2NHN1JH?=
 =?utf-8?B?NHFmVElHSjk4WXpQblRGREVGMFJHdjh0eElNaWswRUc2dVRQT2xNQzB4anlU?=
 =?utf-8?Q?3VrqdjknQYTnZHBuu758JTb5x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bd7b76-0603-434f-093b-08dc7073e18c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 22:03:38.8391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVg+yMIt8R1IS8U6Di3kzokQfLUMFMz/jttyHRn0EQN+PsWqFp6FK7gpsh+R9lw4kZmRyUHHVe1F1R4zSxWRVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
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

--------------DERVUe4ElAjWNIsdv7e3crUe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

Well - the dev_info has 2 "amdgpu"s.

    [   67.227121] amdgpu 0000:43:00.0: amdgpu: JPEG decode is enabled
    in VM mode

In practice we use "drm" to grep the GPU info for VCN and JPEG support.
So I believe the DRM_INFO is the best and it is used by most of the 
amdgpu code with exception only a few jpeg code and one vcn code.
in case of a need to convert all of them to something like:

    [   67.227121] amdgpu 0000:43:00.0: JPEG decode is enabled in VM mode

We can just change the macro of DRM_INFO.
Do we agree on using DRM_INFO?

Regards,

David

On 2024-05-09 17:36, Alex Deucher wrote:
> On Thu, May 9, 2024 at 5:31 PM David Wu<davidwu2@amd.com>  wrote:
>> Hi Alex,
>>
>> Thanks for the suggestion!
>> What I am thinking is "DRM_DEV_INFO" should not be the one we want - as it is more like a debug message.
>>
>> [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.
>>
>> instead I prefer to use this format:
>> "amdgpu 0000:43:00.0: amdgpu: JPEG decode initialized successfully."
>>
>> but again I dislike it as well as there are 2 "amdgpu"s in the same message.
> You can use just plain dev_info().
>
> Alex
>
>> To make it consistent the "DRM_INFO" is used everywhere in the amdgpu code.
>> only the following jpeg code uses DRM_DEV_INFO and one file for vcn. All other jpeg versions have already changed to DRM_INFO.
>>
>> grep -r DRM_DEV_INFO *
>> amdgpu/jpeg_v4_0_3.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
>> amdgpu/jpeg_v4_0_3.c: DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
>> amdgpu/vcn_v4_0_3.c: DRM_DEV_INFO(adev->dev, "VCN decode initialized successfully(under %s).\n",
>> amdgpu/vcn_v4_0_3.c: DRM_DEV_INFO(adev->dev, "VCN decode is enabled in VM mode\n");
>> amdgpu/jpeg_v4_0_5.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully under DPG Mode");
>> amdgpu/jpeg_v4_0_5.c: DRM_DEV_INFO(adev->dev, "JPEG%d decode is enabled in VM mode\n", i);
>> amdgpu/jpeg_v5_0_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully under DPG Mode");
>> amdgpu/jpeg_v5_0_0.c: DRM_DEV_INFO(adev->dev, "JPEG%d decode is enabled in VM mode\n", i);
>> amdgpu/jpeg_v4_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
>> amdgpu/jpeg_v4_0.c: DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
>>
>> If the rest of code in amdgpu uses DRM_INFO why should we make VCN and JPEG special?
>> To address the identification of which GPUs - we need to check the kernel message after each IP DISCOVERY.
>> I do not see a reason to mess them up.
>> Regards,
>> David
>> On 2024-05-09 16:59, Alex Deucher wrote:
>>
>> On Thu, May 9, 2024 at 4:57 PM David (Ming Qiang) Wu<David.Wu3@amd.com>  wrote:
>>
>> amdgpu jpeg kernel message is different than others such as vcn:
>>    [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.
>>
>> This patch is to make them consistent.
>>
>> The message after the change is:
>>    [drm] JPEG decode initialized successfully.
>>
>> Please convert the others to DRM_DEV_INFO instead.  Otherwise we can't
>> tell which GPUs these messages refer to on multi-GPU systems.
>>
>> Alex
>>
>> Signed-off-by: David (Ming Qiang) Wu<David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> index 64c856bfe0cb..4be0668ab97d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>> @@ -145,7 +145,7 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>>          if (r)
>>                  return r;
>>
>> -       DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
>> +       DRM_INFO("JPEG decode initialized successfully.\n");
>>
>>          return 0;
>>   }
>> @@ -549,7 +549,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
>>   static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
>>   {
>>          adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_0_0_dec_ring_vm_funcs;
>> -       DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
>> +       DRM_INFO("JPEG decode is enabled in VM mode\n");
>>   }
>>
>>   static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = {
>> --
>> 2.34.1
>>
--------------DERVUe4ElAjWNIsdv7e3crUe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Alex,<br>
    </p>
    Well - the dev_info has 2 &quot;amdgpu&quot;s. <br>
    <blockquote>[&nbsp;&nbsp; 67.227121] amdgpu 0000:43:00.0: amdgpu: JPEG decode
      is enabled in VM mode<br>
    </blockquote>
    In practice we use &quot;drm&quot; to grep the GPU info for VCN and JPEG
    support.<br>
    So I believe the DRM_INFO is the best and it is used by most of the
    amdgpu code with exception only a few jpeg code and one vcn code.<br>
    in case of a need to convert all of them to something like:
    <blockquote>[&nbsp;&nbsp; 67.227121] amdgpu 0000:43:00.0: JPEG decode is
      enabled in VM mode</blockquote>
    We can just change the macro of DRM_INFO.<br>
    Do we agree on using DRM_INFO?<br>
    <p>Regards,</p>
    <p>David<br>
    </p>
    <div class="moz-cite-prefix">On 2024-05-09 17:36, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_M6+yMtMDz5kr6FYZyMT0ZB7pNc5Ln-vSb6e45Cn71V=g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Thu, May 9, 2024 at 5:31 PM David Wu <a class="moz-txt-link-rfc2396E" href="mailto:davidwu2@amd.com">&lt;davidwu2@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Hi Alex,

Thanks for the suggestion!
What I am thinking is &quot;DRM_DEV_INFO&quot; should not be the one we want - as it is more like a debug message.

[drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.

instead I prefer to use this format:
&quot;amdgpu 0000:43:00.0: amdgpu: JPEG decode initialized successfully.&quot;

but again I dislike it as well as there are 2 &quot;amdgpu&quot;s in the same message.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
You can use just plain dev_info().

Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
To make it consistent the &quot;DRM_INFO&quot; is used everywhere in the amdgpu code.
only the following jpeg code uses DRM_DEV_INFO and one file for vcn. All other jpeg versions have already changed to DRM_INFO.

grep -r DRM_DEV_INFO *
amdgpu/jpeg_v4_0_3.c: DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully.\n&quot;);
amdgpu/jpeg_v4_0_3.c: DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode is enabled in VM mode\n&quot;);
amdgpu/vcn_v4_0_3.c: DRM_DEV_INFO(adev-&gt;dev, &quot;VCN decode initialized successfully(under %s).\n&quot;,
amdgpu/vcn_v4_0_3.c: DRM_DEV_INFO(adev-&gt;dev, &quot;VCN decode is enabled in VM mode\n&quot;);
amdgpu/jpeg_v4_0_5.c: DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully under DPG Mode&quot;);
amdgpu/jpeg_v4_0_5.c: DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG%d decode is enabled in VM mode\n&quot;, i);
amdgpu/jpeg_v5_0_0.c: DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully under DPG Mode&quot;);
amdgpu/jpeg_v5_0_0.c: DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG%d decode is enabled in VM mode\n&quot;, i);
amdgpu/jpeg_v4_0.c: DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully.\n&quot;);
amdgpu/jpeg_v4_0.c: DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode is enabled in VM mode\n&quot;);

If the rest of code in amdgpu uses DRM_INFO why should we make VCN and JPEG special?
To address the identification of which GPUs - we need to check the kernel message after each IP DISCOVERY.
I do not see a reason to mess them up.
Regards,
David
On 2024-05-09 16:59, Alex Deucher wrote:

On Thu, May 9, 2024 at 4:57 PM David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a> wrote:

amdgpu jpeg kernel message is different than others such as vcn:
  [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.

This patch is to make them consistent.

The message after the change is:
  [drm] JPEG decode initialized successfully.

Please convert the others to DRM_DEV_INFO instead.  Otherwise we can't
tell which GPUs these messages refer to on multi-GPU systems.

Alex

Signed-off-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 64c856bfe0cb..4be0668ab97d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -145,7 +145,7 @@ static int jpeg_v5_0_0_hw_init(void *handle)
        if (r)
                return r;

-       DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode initialized successfully.\n&quot;);
+       DRM_INFO(&quot;JPEG decode initialized successfully.\n&quot;);

        return 0;
 }
@@ -549,7 +549,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
        adev-&gt;jpeg.inst-&gt;ring_dec-&gt;funcs = &amp;jpeg_v5_0_0_dec_ring_vm_funcs;
-       DRM_DEV_INFO(adev-&gt;dev, &quot;JPEG decode is enabled in VM mode\n&quot;);
+       DRM_INFO(&quot;JPEG decode is enabled in VM mode\n&quot;);
 }

 static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = {
--
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------DERVUe4ElAjWNIsdv7e3crUe--
