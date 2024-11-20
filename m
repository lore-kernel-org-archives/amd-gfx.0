Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14602D44171
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 09:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE9A10E3BC;
	Wed, 20 Nov 2024 09:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DmBEvVSn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6AA10E3BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 09:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax6ghSOSKCbORWOx4p1vFTIXOENiePfnQv+OIYQqai5AkJnV/zJgGsnGW5T9gNKRXlaT4MmGB9lKJK98oulBHYs5ZzLPFNybzGBb5z0mAApY64hOOruAr/7028r/0LfMkPtT2x/MwLCpDH9No9z7zmrNK5auW6za+4HKXbIZbUmmSg7QIkq8yyPDk1g9MdBRzcGvg2QBs5jMXlRmDBWZnFbaN2VPh1E0b0O4drcytfNtZZCQEBxIckXLRpKkeZrufNFlXCvK1X/0m+voL/JfLS6xifyMSWSivn1Nyejh/K/eS3uiUtwbT6e3dTqK1Ala+oiyDFX2FSDBn03HUtRy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6H2tAtYV5nbDlx3k1jU7ua9n+swkF8z6sR3Ln65FFI=;
 b=DwLFsIIVxp0SvpViOcdgSgmiXM9BB5YYfRXzq4khUWb5j2Anw3/VKlVIE5vdEdIBAO1mIg7JlOr2PHyaJ3/DQan9MBCxg07YVBL7jgtHgAs5LDCjb9FuVsF5aQwXrJbhbUcelsA+IPaU8PREky+6dQZATqdUe75neFvFrocTF48Kr2CXsM+SzhtXcsF5Jy5x1qI3OysJiqE2Fwz1TOXHHDoVQwFfb4uPIXuYheEAJuGD85L4enXQLBKIHqhzrI+3+LCPraM6UmJIfypmZonONnsWYvwBqOiz+MsEH3D0Aw5OkHlDxj6+L1OXX/9ty4NhxSebva5oak4F9Neo531adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6H2tAtYV5nbDlx3k1jU7ua9n+swkF8z6sR3Ln65FFI=;
 b=DmBEvVSnWpPW+qtwjfLAOSsIqkGatFoKHumEYDFyO566LMihfle04ltW/u+MZ0wN5Af4FxhyUATjiYVEZVljYXJDFVFGmrcoj147XfRKlHEAUc8LdmYjGbOwNa5roLPig/wY+3Na5Hs+iWD6WNLK7w7IEx6lRX8PjdYpO8m15a8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 09:45:03 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8158.017; Wed, 20 Nov 2024
 09:45:02 +0000
Subject: Re: [PATCH] drm/amdgpu/gmc7: fix wait_for_idle callers
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241119192304.72501-1-alexander.deucher@amd.com>
 <44246f11-33d1-4922-adfe-3a46ec5211c9@daenzer.net>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <5424baf1-d456-369f-2f37-77b6d61c9cef@amd.com>
Date: Wed, 20 Nov 2024 15:14:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <44246f11-33d1-4922-adfe-3a46ec5211c9@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 2500c193-e875-41b7-348b-08dd0948019f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlpBQWZ3dGlHZFdWb1M1UUVSU2dwK2lueFJJY1lCd3VXVldzSHd2ZWFucDZy?=
 =?utf-8?B?ZHhoY0lqUWI0RGxkZDVqMEg2UThZM1hOTGI0WkRGVTBFN2lXcGcrTWQ3b3Zp?=
 =?utf-8?B?d3Q0VGEyU1kyaWNPYXhBZzY4SHY4cmhSWU4rZTRTeDY0Szd5cjJoNWlXRXVr?=
 =?utf-8?B?cmQ2MEVqL1hURE80ZlRBdUdYZnJiTFl1bjZpM1I3WlVQMERXMUFwYk1pWXpl?=
 =?utf-8?B?MzJxWEozYWJjUFMwN2gzeXdlWWNCZXM5S0VDT05GVG5QZTRtMUFTa2dLbmNs?=
 =?utf-8?B?Vm1QQWZ0eTFVZjFzaC9ENE1LUW5aSkhFdEVkTGxZK08wSVdVdW5ad2ZtQ2R3?=
 =?utf-8?B?ZVRYVFNtaStpNm83OUlaNUVvNU5PcTFtRFZmbzlrTjhLQkFQL2x4RXFleVRw?=
 =?utf-8?B?dk05Vnh3V2N1L3h4RmM1SmZVemxMSEtaZWE5Q2xZRDFVdWpGd0hpSFRRRmdY?=
 =?utf-8?B?V3NEMy8vcXI4bHBKb0F5YllwNHNkVThmc2ZBNGkxNDN3eTNuSmlySVdmNEV5?=
 =?utf-8?B?bVVlc056UE1wek52Z2d4ak9OOU9aT25GbCszYUdJc0p4UkZjTlpoWEZxVGZ6?=
 =?utf-8?B?L1JlZTJUbFU4b25oc1Q1ZDJrZzdTVzd0QUpybmkrNjJSVGlpdjhJRmhOYVVk?=
 =?utf-8?B?ZzNOWHlXYlpLeHdGSWY1NlZYL0FnRktwMjJpdmRWR3hLQ0R0Y1N3d1VKU1R4?=
 =?utf-8?B?S3BxKzh2OTMxQXlrWWtJTTNoaGtHZEpkNDBDUjcwMlFVL0M0cld3QzZqMUdU?=
 =?utf-8?B?WmFMNUhYK2tiSXd6RmM4azhYVzlrL2RlcWd4TG9Qci9VbkZURzN0YmplcGhT?=
 =?utf-8?B?MUdVOExUVjV0d24xMTdqR0F5ZDZPM0E0YWt0Y0V5MmhVOFQ2QURDZHR2TDVs?=
 =?utf-8?B?aWpHdTFaT1R5bk5iS2lWQWhSbCs5QXB2RG1ESlo5QXhxbXBQZDVpY2lLZU1s?=
 =?utf-8?B?bDBHdVI1QUF6RmtTbjhpOHQxa2RnNnlabmdCQktRcWFGM29LNGFDcXVXUStS?=
 =?utf-8?B?dllTa0JNU09Mb2Y1T3pBYmNROEp2cXVuSnQyT1JsZlZ1S2hUMjJwcUJNR3RD?=
 =?utf-8?B?SWhsaE1xTXBTcVpsM1dsbjhCM0ZHWDNlaUdkOTc1SEtIa0NlQjZKNFFSTitl?=
 =?utf-8?B?K3JoaFV5ODZlN2ZWZ3pRUktxa3hEZTZZYW0wYTgyVmlrTFRtTi8xdXk4WnV6?=
 =?utf-8?B?SjFybEEreHdWWUozOUVRMWU0aTRGeHR1WFBoTzZtcjNrRWdmME15KzVXa0U0?=
 =?utf-8?B?blAvU3hTSEhwQTAxNU9aWXlBY2tTSDZYNmcyTWlTdkIzL09oZmV6UVZ0M1Q1?=
 =?utf-8?B?Q3UxTHlWanNCOUVESFh2cWUvVUd1ZXZQVThramNJT09xYWJHZkpYTFJvMC9u?=
 =?utf-8?B?eG5KZmIvQmUzaFR5azhydU5NK2U5aVpxSlBFMkdrQ0VrMnpMbUFFOUxhQXAr?=
 =?utf-8?B?NFlxaVZ2SHduOVZWc1FTZy82U0xrTS9sQS9rNHRyRTBYWXlPU0tmYUFERCtw?=
 =?utf-8?B?L1NrcVhCekU4VkNnNWhJbjN4TFo2dHVEelorZ0RpYUVwVVNPQTIyYWZKdEFS?=
 =?utf-8?B?eEdkQ2JBdHFVSEoxUWRXZmlQbDc0V0ZXUUIyQWFXVVlaeWNKR1RkcGgwMGlh?=
 =?utf-8?B?cEZwSWdwUlQrZFF3MFdBN3Z5bHdXYzdCWXZXT0hWbEF5Y0diWVJodE5oRW1V?=
 =?utf-8?B?OHE1UE1jc2tSYzF5NTdabHdFbWZTMUpRTHhjMWEzNUpaZGVxbUFCMXhaa1NR?=
 =?utf-8?Q?Y543HkY8DSXde9+obHyapUFIxAdZJJMYw32zfrx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFF0eURIRUFla3oxYk5iVWpIY1BpbWw5RHNJN3VOV1puZG13c0hoSGd0L3k0?=
 =?utf-8?B?VTRLVlRkcXVxSDZ2Y1pWRjc2bTVPNTI2NklZZHE5a1lDd0hPL0N5K004cldL?=
 =?utf-8?B?Tlg3ZVNnZUtuU3AxR1hGakRtR0haVHAxUWhVYnhQcWNYcnNiNlNnRlg5QnJR?=
 =?utf-8?B?RWN3MjVQYk5RSkdmUFJVQ2hGWnFZM3RJUHFacnRtUi9nWGRreFF6bWc3Q2Zo?=
 =?utf-8?B?akZVUXpka21oRzBmWUhMWXJGUWFOZWhvOEROZDQvL2hCbU04cXhZMmhkMFJT?=
 =?utf-8?B?dy8xa3d0RVY3T1JCdVdvWEN0anU4S1JIT1NISWxTZFhoWEJHREJjZW4wdCtH?=
 =?utf-8?B?L2xnUzlqTmRlSlI2MG5NRHFIYmxQM08zZnA0MEtLZys0U3JuVWdHZUVDSC9o?=
 =?utf-8?B?dGVUOTlNaW9va294UXprbUVhSms0aUVna0MvTUxmQ1gxQWlhdS80cHhYb2J3?=
 =?utf-8?B?S3A2TjRBVHJJaTV4WktsTEp1M0UxWG9WaTJNREFpZTliM2I4SWFxb0VMRXJl?=
 =?utf-8?B?aS9SQ1ZHdjFwd1hwOUNRZXJKaGRxZlJKWmdtSmlXd0Rtb2RSOE1MV1owa3ds?=
 =?utf-8?B?SzIrV0MwV0dCM0NjM1FIQXFkajB3K0VobGwrbUxTQmVJU0RCanJCVG5Tcnhx?=
 =?utf-8?B?V1kxNFk0RHRzaE41U09rQmplVm1mV2ZQN2p2bEF4YTROcHRqRC9sbWpWLzR1?=
 =?utf-8?B?dyszdi80bGs3TVZuR01UY0g2bkxGV1BzcWdzT1lxdmVvMTF5c1J2a25lNWlk?=
 =?utf-8?B?cmQxWEJpbXY2MEQwZmh4THlTTFpBbCtiVDdDc1U2VStFV3ZnbTdqbkdsZmNR?=
 =?utf-8?B?TC8reXF2MEZzNWFuQTlNWmkxUWVhQXlkY1FOaFBKRjVPRVlidEFRSTNpN3dD?=
 =?utf-8?B?TlJ0RnVtQVpXYnczV1JZU0hFVTFhaDBRa1JaWjRWc0t3Q1NhZjExbWRMWnow?=
 =?utf-8?B?cGNWSlAzKzJqdG1LWkdsK1UxMzQxUlM5cXh2cDhOVFU3OVBGU01OcTgwbE8z?=
 =?utf-8?B?ZGpjQVpxT01DTEphOWVOc2xIek1ZRXMrbkgvZ0JNN1E0OFFYUHVqQUJYaGE2?=
 =?utf-8?B?OEl5eTUrbkFFcStoOGx2NGxPaURiTEpnYWU0YUVicTBpQ0gydVFjRkR4eGg0?=
 =?utf-8?B?TEtGdHYvZkZSL1ptME9MRy9QTEl1T0NuTXlCYURuTC9XUU16WVBxOTRGejNv?=
 =?utf-8?B?NHJ2eFB0MktOOUpuaThrYmtlcHdCNzl2Tk5KeHVtRlVET2R4TVJneVFRK3FE?=
 =?utf-8?B?UmFWclVYNzBqUDdBOHM0dEc2VWlON0k5UEdZVUdIM2kvbW5mbTk2VHF5b3kx?=
 =?utf-8?B?bzdZVzYxTmI3NS9xcjNQWEEyaExyL0ZpN1FxVllJRXRiem5PdkFLdEgxWDQ2?=
 =?utf-8?B?bXJINmoxS2daa1R0VUZUdlRhUVhUODFGQ3A1NlB3azFidTF0eUFYdVlSR1VM?=
 =?utf-8?B?aDlRSHR6ZThVaGg1TGJsMDNIZDNCeEg0YlYyM2tOdVBDYjJhZ3NqZ0pwVDRo?=
 =?utf-8?B?QkN1SEszbUQvUHlQZE9wQXFQSGZIZXVFVkJOVWkzem9Xclo4SzhYK3dvTjRj?=
 =?utf-8?B?THpFUERRd1kxSURndm5WTExZaVJnWVlONlJ3cDRFV3U2TEkxQlhBMk9PV3du?=
 =?utf-8?B?LytHbnUxTFRJSiszTS9jd3ZZNmhNZ1AvV1JYdnVLTFZZaFRnSlo2YVdlVlVX?=
 =?utf-8?B?aU9zZGlFTHRSWmtrMlh1VW1iakNSMzlOaEI5UU9iWk5seTNoRVRoTFA5eU9L?=
 =?utf-8?B?Q21VV2owOVEwTHJuRFpDUEw5djNiRlN5ZTNhRnM0SkV4Q2podzhLN0RXSnU0?=
 =?utf-8?B?ME9oUnkzN2JhNW1CeXMwcThscnRaRlZkeWtyWUJpdW90RmVSZzZoTWcyZ3R0?=
 =?utf-8?B?TENzSDNnTXJjdU1nSHhuejN1cE4zdjdUNisyQzlIdTNwWkdTdTU2bkhtaXNX?=
 =?utf-8?B?blFiaVRLTTArbElDT2VxMVdodnhjMi9rVS9aZ3JYL05WS0thaDhiSVFTc1Vj?=
 =?utf-8?B?QmVyM0lzV0g5L2ZmZElRRHprWXJ3clRxMi9RWnZWZjNCQmZIS2psd3B1RW14?=
 =?utf-8?B?dnRoM3Z4Mm5lU2tGWmZ4eEN4VEJDc09tS0JmazEyMXUxQzYxbDc4QTNPV0xJ?=
 =?utf-8?Q?LNH14n8F14deBPAg7tfz6eBGw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2500c193-e875-41b7-348b-08dd0948019f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:45:02.7378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDpEk+/CCzKnqjFQwWlxlPYe/3+TZDsUMKtRJwBuhBrtLJC+GgFcPcoFpyXjLKAjqIgguultybJkPuWYuCeIGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 11/20/2024 2:45 PM, Michel Dänzer wrote:
> On 2024-11-19 20:23, Alex Deucher wrote:
>> The wait_for_idle signature was changed, but the callers
>> were not.
>>
>> Reported-by: Michel Dänzer <michel@daenzer.net>
>> Fixes: 82ae6619a450 ("drm/amdgpu: update the handle ptr in wait_for_idle")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index 8f6f2f067641..347bccd92696 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -87,9 +87,14 @@ static void gmc_v7_0_init_golden_registers(struct amdgpu_device *adev)
>>   
>>   static void gmc_v7_0_mc_stop(struct amdgpu_device *adev)
>>   {
>> +	struct amdgpu_ip_block *ip_block;
>>   	u32 blackout;
>>   
>> -	gmc_v7_0_wait_for_idle((void *)adev);
>> +	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GMC);
>> +	if (!ip_block)
>> +		return;
>> +
>> +	gmc_v7_0_wait_for_idle(ip_block);
>>   
>>   	blackout = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
>>   	if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE) != 1) {
>> @@ -251,9 +256,14 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
>>    */
>>   static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
>>   {
>> +	struct amdgpu_ip_block *ip_block;
>>   	u32 tmp;
>>   	int i, j;
>>   
>> +	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GMC);
>> +	if (!ip_block)
>> +		return;
>> +
>>   	/* Initialize HDP */
>>   	for (i = 0, j = 0; i < 32; i++, j += 0x6) {
>>   		WREG32((0xb05 + j), 0x00000000);
> Seems simpler to make gmc_v7_0_mc_stop & gmc_v7_0_mc_program take ip_block instead of adev as well (and fix up the comment before gmc_v7_0_mc_program).
> We have changed the signature of the functions which are part of the amdgpu_ip_functions and not for all. The existing change look good to me the way it is.
>
>
