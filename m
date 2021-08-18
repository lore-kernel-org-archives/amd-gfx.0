Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D0BC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 09:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37ACD60551
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 09:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37ACD60551
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C43D6E4D4;
	Wed, 18 Aug 2021 09:35:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB6C6E509
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 09:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OliOWp0wVgktxxgpy+0K6fi0o3uKUug4I7gvj5mcu6TUUk7vmtQq0jRGNEDBsF56zieKPkHNMlt9ZRA4/Fs1is31ZTsk9gqmUyQeEkVykwQipNzIwfVHjhTsvzEuACYz+Oms8XYAlbVEJSxi0xgRNQmojYamtdt8rbN0Gl3C0QOcjZLDyLS2vU0Nd0Vls3Lmr2nrZ7fQ38PfVHYIKxpCMP26YW0ZF4yfwMLdxPtHyOt5jHQjWC6uSPWP/BeLcB/MH6ek595qhRHMPdbWq7WYT23+UGpjHOS5CqBzj1OWvobtvuY+gd3EGkLeR15aTE+vNqs04eydeHDs4f9TS89B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os5g0U++4VgvYZtwhihwgqc1j2AOgGhAtEal0AtGO08=;
 b=bZ/h6NzOrn1XxouZcpZ1mbEK/hJs/1HbvpSq3zjdjxWmGORvJSe5IUmICbYnelwxvX3R7dfIv1jgCbLCMGMItyVdkRdwz2HcQZ0ldMLFTVSn2apmlndrMYuj6eBANsuGTDx67FxjSWXSIBpXSMCLwkN2WFGyw5/uhtGDCQCPiIiBxHdt8zgXQHzq6OH6/TrPx0ujiwLL69yaRxWrpeOzW9KpHdZ2JptrZJPM6mRBpkIh8v7F/+64/ydUBBYPOmGQJpsNRh2Ih6o0lw7wa+UL1vRP6ekAp/i/eV+dlUor0LJwymxjBMFLi/fkcmglJVpVO/z/OzBiDMEV2bvySq4S/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os5g0U++4VgvYZtwhihwgqc1j2AOgGhAtEal0AtGO08=;
 b=izj165EFOeKpAT4WhzxCmxf2MrmjKFkj7ShHB0zFpiMhlXq82mCFKcrEh8dfw/F4mktbNSDwpq4hzUBTLCQ9eELyz0kiJcD7qEAvOu6KQUSTcYoqpeHlmFgNF1xOXfwkAHqOQ4CrBvb9IuBKJLKn5cquWWx0S7IpZUfqw6HU8Mw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 09:35:01 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 09:35:01 +0000
Subject: Re: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE on
 suspend
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, Leo" <Leo.Liu@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20210817064005.1437328-1-evan.quan@amd.com>
 <374e0b56-e81f-b4c6-ae97-0ade2c0f5b36@amd.com>
 <DM6PR12MB26198C4D8A712DE7E7EC0580E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <2bb2f248-41ab-9c39-0881-c4ea97a7813e@amd.com>
 <DM6PR12MB26190AACC7D8882455FD0819E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <d3dfc77a-a2c0-7fae-8b7e-8c5f027d79dc@amd.com>
Date: Wed, 18 Aug 2021 15:04:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB26190AACC7D8882455FD0819E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0104.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::20)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR01CA0104.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 09:34:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21295326-4b1e-4fce-0495-08d9622b7370
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317CE524AC0B98F64566E1797FF9@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvq7C6udp3jyxD3G16y0xDZFGB1jZe3Wsuaj/I1McBEfNTGZlW4Cd7Ghnr5DfOwIT2pQgZ2UZJanW4Yqe+O7s05YnknrWjYz1kZRIKGzmnZJISpDA/CGinVnFe5pq6PRgCgLqMzh2LsFNQMcCEHm2PLi0XrIywrpl9yexZ8V/ArbKCHZivI/TgftCEHN1O89UfUQIOWStVg9PrHC9JUPmM4xB1vRRoigFknzqTEhklVB3w2yBvnhRJYgTdca/OuDQK1Ngb8CzfoazsOlA+Yebw41ME4FIFcDgB4ZL+0EvFwhgJKTG6WUKjkcCfHFKzZlRZcz3JNtFBTG2NC3EXheYAKU3hNJwY3h9KBlS+VRagnOI8ixraw8cbfs/07mBYvPzdZlug5IDTIDyctVvlCvlXmm1lmWbUxzN53uUph58kjZ91NYC4hlNJfb0CUAFoTg7L/JLmyTvGzMgXsf80Dq/rdsHcBOK6Ypg0cnhmGiB3OnExiRjsG8gU9ChJSPBdB1Jft7zI3ZRgjOXlsAKZhWfcDTfioKCh15rpqGVVKGqDXIqsCQQP7xQggiw6HZ/VN794q3iBP8GkGu/wk3N+DRSd08HMM8orwXrM/6D1+7Ux71/2oPhca/rQMvu7WcfLqeW6aGqffouA7Lzq80tWUylx4ONOrEaJBnUNCmAP0V28rTUdKOSNEXQXClsDpLc2qIpvGkM+aLrBtYlxb3U6sL5+VFwP4t6c0BVf5ZSeaM11U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(2906002)(8936002)(5660300002)(83380400001)(53546011)(4326008)(6666004)(66476007)(66556008)(478600001)(2616005)(6636002)(66946007)(16576012)(956004)(36756003)(31696002)(6486002)(31686004)(54906003)(186003)(15650500001)(38100700002)(26005)(316002)(110136005)(8676002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFc4MmxIT1ZPdWxSbjNhUUMycUlNUzl4TTlUbXZGR2V2bzdaZ1l4dFZZanhO?=
 =?utf-8?B?UDAxc1BWU3RJRXovSnQydWNmYkpZNUxVU1ZmQmRkSURudjRkU1RRejJsVDlS?=
 =?utf-8?B?ZFhzWkNDUmFyT3U4cThzUVFsSFlJdm5qUW1SK3d1bHdzNWpWOVNPMWJaZGo1?=
 =?utf-8?B?b0JOVW1YSDZBNzFYS01GUU81MU9WVDFMUzB6bXZ1VzBPZmRGWEJPRW1kUDRx?=
 =?utf-8?B?aHE1SmZha3FSTnN1cEFTbUFOcnppZFI5cW1wR05SUkR4VGdGclBreUhvOUJZ?=
 =?utf-8?B?Skd3U01mN0lFN2tnOXoybnNzMlVGNEJPZHRCZTdpZmpYdnROR2gyQ2szUDUy?=
 =?utf-8?B?K2hYQmdHdUZMMEY4K1lXa250OGNPZ3FOY21ibUxKTDd5cmRmMkdaRE02WEJW?=
 =?utf-8?B?U3RZRjNZZkFsb0FmalVOUXVFVXdpdGk4RzUwenRKYlRWOWJBbHdyY0NnRndk?=
 =?utf-8?B?Z2ZhRklnKzdrWU1pNTQxVURjWTNjaGpMU3NZOUdWdGpvWW84cjFYMVdjc1px?=
 =?utf-8?B?Rloyb3pYbWE0dlZEM1RobStPUXdZRkViRm9Qc2MxVG50b1NWaUNRL0hMZ3JM?=
 =?utf-8?B?c05pWVhUM3VvVUV4YmF3TCtPN2gxa1pETXZwQ0NrUkFqNDAxQjUvNzdKSzlx?=
 =?utf-8?B?b09lN29ncTlKcUE2VUtNaUZtRVF2Z0ozSVVRL0J1RlZQeUVtSkNGcWpCa0ow?=
 =?utf-8?B?Mk9EbkgwMGdpZTI3ejBIVUpJVG0rTEpsWVBBOHFFMCtUQnU4ZjJMMGx5WnRM?=
 =?utf-8?B?Q0FaRzkzS01TSEhFcWNSVDlCNVhER283UXVPc3ZneFFhWUp0VVJmbGRoU1ZX?=
 =?utf-8?B?b1A2UzJKZTM0Y2dHTXhGS2xwUTdObDE0c3ZmaHpQRlA2SHRSbGE3MnpZaUNj?=
 =?utf-8?B?VlNIaStTb3A4Q3hwaUs2aVdxYVI5WjZmVXNBck1UZkk3K0hJdEowT2ZRUFNy?=
 =?utf-8?B?WlU4VkxCbDIySEUxYlZhZDBFRWpDNWN1ZTNPNEZQTDZUWVkzT1ZSYzFBc1Rk?=
 =?utf-8?B?T2Vsc3Z0OVUvM3VleWxsSGtNUGdqVStNcEY3T3hqQnpZNmtJSEFQOXBtb1dU?=
 =?utf-8?B?cENSYkE1MnNWcWVkZ05SV2VTbGpQa2ZQaTZYZ3hEQWRDWkpEMm9Ha1VOTXRq?=
 =?utf-8?B?WHV6V3Z2VStzbFVzdG52b0dZNm9rMlRJTVN5SXlLUHJ1d2h3SUptSldiUW9s?=
 =?utf-8?B?NVNpRUlqTlhqWmw4b0xHNFZ2TE5odjNKazdKcHhjMlp3L1lCUWNTbi9hQ0sx?=
 =?utf-8?B?OGhPOHZhdDBXWUQvM01JeHlrUmtzaFVqbThuNkw0cmF0a2FGZUJPQUZyQTJU?=
 =?utf-8?B?S1J0dkNwNUNpdFpPNndBNE0xMmRGTnpHYkI1dkp6NGNHK21VeStYbDF2ZUVW?=
 =?utf-8?B?UFdvQjBiOW1qRC9qeHpHZTcwaGtOSU15VWJWYm5KQk83OVRSVlFHaFlEQjFN?=
 =?utf-8?B?Zjd1WUVmeU1vd2JQOU9KNGJzd0pyUi82ZFI3d0hzL3gvejMrL09HWFQwMlA5?=
 =?utf-8?B?RytrWnpyZDZUZWE0RzJGZmdrdFVyeGgzZW55azEyeEZ4dXBzT3NMNlVicWlW?=
 =?utf-8?B?SEFVNnpFcTFQY3k2NjhpSlVqQmxUOW40RnpCM04wNTgwR0JJRnNRR2lzMTlC?=
 =?utf-8?B?K2FpdHlBblErQWV2aW56UG5vclRxalpGQ2grQmlUZEVFOG5oUW9NR0lzdmEy?=
 =?utf-8?B?RnFOUWxUek5zMmxRN2RwWUJ4WXpqMnljVXpDb3l6ejQ2WGt1YWwwS28xVXNt?=
 =?utf-8?Q?S+UJ9YhdPTjkcVhZM/qwqNR2mCBblZI3rlVWTBS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21295326-4b1e-4fce-0495-08d9622b7370
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 09:35:01.3962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCbFlsut5f3xfnjPZ+yoFtriy669zN9NXYtyboTZObBgcA9qgG2Iza24nhBaY8VV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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



On 8/18/2021 2:15 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, August 17, 2021 6:09 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org; Liu,
>> Leo <Leo.Liu@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>> <Guchun.Chen@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE
>> on suspend
>>
>>
>>
>> On 8/17/2021 3:13 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>> +Leo to share his insights
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Tuesday, August 17, 2021 3:28 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>>>> <Guchun.Chen@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: properly powergate Polaris12
>> UVD/VCE
>>>> on suspend
>>>>
>>>>
>>>>
>>>> On 8/17/2021 12:10 PM, Evan Quan wrote:
>>>>> If the powergating of UVD/VCE is in process, wait for its completion
>>>>> before proceeding(suspending). This can fix some hangs observed on
>>>>> suspending when UVD/VCE still using(e.g. issue "pm-suspend" when
>>>>> video is still playing).
>>>>>
>>>>> Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 5 +++++
>>>>>     drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 5 +++++
>>>>>     2 files changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>>> index 4eebf973a065..2fdce572baeb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>>>> @@ -554,6 +554,11 @@ static int uvd_v6_0_suspend(void *handle)
>>>>>     	int r;
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>
>>>>> +	/*
>>>>> +	 * If the powergating is in process, wait for its completion.
>>>>> +	 */
>>>>> +	flush_delayed_work(&adev->uvd.idle_work);
>>>>> +
>>>> If running idle is a prerequisite before going to suspend, then
>>>> something else is missing here.
>>>>
>>>> Otherwise, the hang looks more like a pending work launched after
>>>> hardware is suspended and trying to access hardware. As the hardware
>>>> is going to be suspended anyway, doesn't it work with
>>>> cancel_delayed_work_sync - making sure that nothing is going to be
>>>> launched later to access hardware?
>>> [Quan, Evan] The reason we chose flush_delayed_work instead of
>> cancel_delayed_work_sync is we think those operations performed in
>> idle_work(dpm disablement, powergating) seems needed considering the
>> action is 'suspend'. So, instead of "cancel", maybe waiting for them
>> completion is more proper.
>>
>> But it will do so only if the work is scheduled - so it doesn't seem to be a
>> prerequisite for suspend. If it was a prerequisite, then the existing code is
>> missing that (so that it gets done for all cases).
> [Quan, Evan] Just confirmed that cancel_delayed_work_sync() alone cannot work.
> In fact, our current driver already get cancel_delayed_work_sync() called(e.g. in amdgpu_uvd_suspend() on the path of uvd_v6_0_suspend).

Thanks Evan for checking this further.

If cancel_delayed_work_sync() is called in amdgpu_uvd_suspend(), then it 
means that originally executing idle_work was not considered as a 
prerequisite for suspending.

_uvd_suspend() is called "after" uvd_v6_0_hw_fini(adev), that maybe a 
little too late.

> To get the issue fixed, it has to be either:
> 1. flush_delayed_work()
> Or
> 2. cancel_delayed_work_sync + amdgpu_dpm_enable_uvd/vce(adev, false) (the job performed in idle work)

At minimum, it proves that disabling dpm is required for suspend.

> Btw, I do not think flush_delayed_work() is an incomplete fix. Since the UVD/VCE idle work is appended on ring->funcs->end_use.
> So, as long as the UVD/VCE ring used and ended(it will since at least there is ring/ib test), there will be a chance to get the work waited and completed.

I agree that it fixes the issue, only thing is someone should look 
further to provide the right sequence of uvd suspend.

It doesn't give a root cause/right sequence - it only tells that forcing 
to execute idle_work fixes the problem probably due to an extra delay 
added by increased execution time or it disables DPM or something else. 
Someone should confirm that all of idle_work or a part of it (as dpm 
disable) is required for proper suspend sequence.

That said, I don't have any objections to this fix either. If there are 
other things, probably fix it this way and move on.

Thanks,
Lijo

> 
> BR
> Evan
>>
>>>>
>>>> Then this may be a potential issue for other suspend calls also where
>>>> work is pending to be launched when hardware is suspended.
>>> [Quan, Evan] Do you mean we need to check whether there is similar issue
>> for other IPs?
>>>
>>
>> Yes, if there are cases where other IPs may schedule a delayed work and call
>> hw_fini without cancelling the work.
>>
>> Thanks,
>> Lijo
>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     	r = uvd_v6_0_hw_fini(adev);
>>>>>     	if (r)
>>>>>     		return r;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>>> index 6d9108fa22e0..f0adecd5ec0b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>>> @@ -503,6 +503,11 @@ static int vce_v3_0_suspend(void *handle)
>>>>>     	int r;
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>
>>>>> +	/*
>>>>> +	 * If the powergating is in process, wait for its completion.
>>>>> +	 */
>>>>> +	flush_delayed_work(&adev->vce.idle_work);
>>>>> +
>>>>>     	r = vce_v3_0_hw_fini(adev);
>>>>>     	if (r)
>>>>>     		return r;
>>>>>
