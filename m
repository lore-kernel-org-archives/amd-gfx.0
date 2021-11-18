Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5190C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 07:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2F961155
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 07:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A2F961155
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57D16EAB2;
	Thu, 18 Nov 2021 07:38:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870BE6EAB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 07:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxMDEgvMs08BcdS6ylfyIP7y4perd75WICIggQVQf7TmS90jRpkQaCutpXHTPUMLbEmFxvq/64AqZ0eIgCd0c+9hRWsa25bvUDdgrpI8AYolY/aSf1C99t4gLx93aJEcud3cdZ3Di0iKj9iSuWh5vJUf2CLU5t+ozRvslpfaBO7HqXpRO0K/Z4gVpdOq3kaHtfBBih1nvgMMwO88UDvNlXDKwoqNc55PCKwyqXNabYnvMnLmD0WGpMcHJPqk+iaZkPrmqmGpHgqq6qApa1azSGLBIrlJgR9NEyulW/5CsSXyMC+o08+rZOZMSxHLklDfe6oATsCSMyRaIU/ctj7LKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrQzAI28ZqBeUEcxVAfiC4As4k95thS50cunP8vkpjo=;
 b=OdDZANaXUetxjEMhaR6/I9lZs7AE5yLkzb24g99JMN3tbwKEOAU2Si8Xw3wiO9TWchph6Ggk9bRNvR4+JwbDoR6pdyNhTEy6uPm/Wo4tLk8SvT794AX7mr2u2jvD8MUV7g0eqkC7HIjhEdFNFLlXTQ8vtNkGpCq5VKNf0dba6wHH2U2rC4Q6pFWVm9XEPp+3h9SJKK4pafc8JVlIcx/8xfH1GEZOOMM/kvBKvDPny54zNGgz8Rcck4iEMJDc78ZeYeHFQpOxt9cXDoD0HnmNAX6WYOU8rer+UopKPLE/0EqAR/HucTDXKe2DtcEIDa6XuokKpnrvfSsqvQ1/1FCbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrQzAI28ZqBeUEcxVAfiC4As4k95thS50cunP8vkpjo=;
 b=LXNt2Lg43mDdX7CjXp5R1IIj6lvZbMZLYTqu7YfQwk95iuIIyudZFMYem/rl5NxC5/CQOFqUyL59CNMMMYzlEY57i9eDSOzTAmvYkb/0IzZsmUBUpAjZ3hny7TdKWPPBkAQRSqD/24NExNchghvy21rH1qfXOD9XBLwB9jV8RhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 07:38:34 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 07:38:34 +0000
Message-ID: <eb5f83cf-ef8d-26d5-a0c9-52e06573f2cb@amd.com>
Date: Thu, 18 Nov 2021 13:08:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211110023052.1872623-1-Felix.Kuehling@amd.com>
 <48473282-292c-508a-1a4e-42359c421f01@amd.com>
 <dd7f5e89-338b-c331-829e-5fba0594a0cb@amd.com>
 <DM6PR12MB39307C2E18445AA344F9930F97939@DM6PR12MB3930.namprd12.prod.outlook.com>
 <2d6f7194-bf4a-4bb9-b751-fe80ecc4e55b@amd.com>
 <5d1f3790-00b1-c310-7257-1f24f7ad58a1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5d1f3790-00b1-c310-7257-1f24f7ad58a1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:22::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 07:38:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d542ef9-ffaa-4547-8550-08d9aa666cc5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01078823860BF2B0FC3EB482979B9@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1K1YVyhAsTf5+YLZvJil3JDhKHu2Tf8PZVZJR4+pVflbAPGU2B25Wi/NC75L9wF0oIymEvqa1Li5GHYmHke/wHTJ08za89FFkGPdaFOirlelEdOBodzUEwSLgHpRfRGONOHUD7ViVI2yriccAmUWLz9MXJ0Up1fU4O2bNVFlDcjgU6T9wAkz9MI9SABeRy4TegbdDv4XgdrjTo5wuC23ESJKehpAVjRdbDXrhZozLP7Z9Lkes4cR9WrQTVdeBO+p5hm5s/zHuwL8aDmIHxi7SgFAN78kJISYVvTndOhGO8XJ81zr7UnNMeZxx0r+SILpMWNYmPY3Hgd0cMnt3ZcnRfaxHF14beHQF11ziWVQpLG3yCQfr7rKhiqJDAVvCeQEBEpd0oDd8FqQTBWcDxHr6BWiom1hEfUtR/Z//AwyadIQlEXHetxS1YNjXJGqOCPHOueYCa1jRka0XtrKdwkwBmW/UmMQ+jS8A6mIhZ2oUgnMn+h+JrR2id04cVO41iarVR4eGDlp9B+cveUlB/cdIRnYavsYRIEw4VGnPxl9msOT2L8fxn+0gNjLtiP9Jp4AXNyqVA2PEpWA+rvex4CQ5+MflpdxvIsp80M2cQudOwXfl9kVmOeoCwhfKbtCgFeMhGJ6jDixVXQwiemimyeDYnTK89TUFtfBZOJixkXWd02gXJSIPorJPXNYAFZNkkRBsF3rfYoRmH/szyHCvT+m8xo3oOlu+z8tj7GklwBTKiW9jElCLR++Jz4TN4hTGhW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(4326008)(110136005)(956004)(2616005)(38100700002)(66556008)(66946007)(2906002)(66476007)(8936002)(31696002)(16576012)(83380400001)(86362001)(186003)(26005)(8676002)(36756003)(6666004)(53546011)(4001150100001)(5660300002)(6486002)(31686004)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzk1NjlUUUdsL3h1ejZuMWFFU0w2VVRDbVhPU0NnemVEUFI1cDkvL24veFZB?=
 =?utf-8?B?SVl4Q2dyZ2FVUllWVVkyYTBtanFvZE0yeCt0Ym9mRGdvYlhiQmtUODVDWEtn?=
 =?utf-8?B?NVdJRU5XdTZ6NFFVQjQwWVJWdXRKTkhZTTM2V01jTGdlUWRzTTFxaStRS0pP?=
 =?utf-8?B?R3cyelgwdi8zYVJ6cHYrY1ZGMkZ3dEhQUzZFT3RHZyt2WFhEMUFWZjN4ZTZ5?=
 =?utf-8?B?eXR0VXVCQzhMNU1JblI4K2w0VTVBckFOaENYU2daRmg4NTFjOFYvdGJNNXho?=
 =?utf-8?B?WFY2UXdYQVVLekkzRzl5L2M5NTdLbkM4VE1mRjJZZUVOUHZTSzY2MlRhdVBu?=
 =?utf-8?B?YnhSQUQzSHNEQ0Z3VE51cUczQ1JFd3FIT0VSWE1KUXlZb2hPMEVKeHNOZzhj?=
 =?utf-8?B?ZlJTdXVLZXpoRDFFMXpUOXlPNk9IblZXWk1UeGE0eE5Xd3RlWnRLY0JJeTc0?=
 =?utf-8?B?eGh6bXdnTEc1R0s3WEtMNkc2U2d5eE5lb0E4SVVqd0x6Q0FkWUR0K3R0MSt2?=
 =?utf-8?B?OW9oSlRrMkdrY1FGdXpmLzZ5VGhwNDFrajAvTlNkMWFzZnorSlplb2F6anFF?=
 =?utf-8?B?RStDSVc1Y3hDS2l2WFhid0VKOFZia0NYVnF2clROUTNoOVZ3T201d0tlQi9E?=
 =?utf-8?B?Z3R3WERndGttL1c0QXowWmF5U0FaWGwyZSs3SE1XSWNkRjNFTlg1bUpETE1q?=
 =?utf-8?B?VHNCZkJpNHBrVkhkVWRaaFdjMExibG5VUm1QWXBqZSs0VDBBM3JzVzZ4VUVl?=
 =?utf-8?B?OWxuZzdvOXNLS05Kd3Fuc092ZFVXUzJKL1J5M2VNYjhWblhLZU53YnNqdmFy?=
 =?utf-8?B?VHBpczJkNlVVZy9SRjZXTjFOaTVyTFlpNlo4ZUtkb3pVR1ZlVmZJTFNTK1lP?=
 =?utf-8?B?dTNIUUoyU0tva2xxdWM1TDF0YUhTZit0TVptSEpGZHMyOVhmRDdVQUNoOWky?=
 =?utf-8?B?MEZxaXJtUGpHYkZnTE81T0lIamRydmFsemtlNjdYdmpYMzVndkRCaGxQcDFw?=
 =?utf-8?B?ODRjT3A0ZWxDRmcvTGpNcXFpdWh4R09JTVBkNHRNUTJqUS82a0RjWHlNWXpW?=
 =?utf-8?B?YWF6N2hlUEcyT1BWci81cVhDNEExbk1md3FYcHA5MUpwWEJMcXlSQ3dFK0hm?=
 =?utf-8?B?ZVM4dXZGemdKNFZCOWtVUnR6aFduSFJpMkZETFlhUVF0bFBsZ1hOMTcvN2hz?=
 =?utf-8?B?dmxwa3YvWkROSHpQSGRPcGlKOUJpMXBDRGhnYzBiZEt5dnBINWUwRThHZzFs?=
 =?utf-8?B?VTUvU0tDR1ZTNUh5Q3I3aUxOeGVYYVN5NzBpSUxFSjE5NE9JQVltZnVUVVJw?=
 =?utf-8?B?MTQrVEdnbk5ZY2ZKMjVURVFuWlB5cUxZcHdqM3pxVzlRRGVEaHRZWnYwSTBp?=
 =?utf-8?B?Ukxxb1gvOWs0WHU5TkVIM2hLem9QVnZ6cUEwSUNOVE9WMUo1ZmJKMXo3Sll4?=
 =?utf-8?B?L21qQk1La1cycjhIZHdrN08zeUwrZkxWV2ZxZjY5YmhxWVRzOS9lR0h1VEd4?=
 =?utf-8?B?cUxTODVmeVY5QnQwU241cnhxRVM1eHVaWENLdnNPK3ZDYWpvMlFrenh5RzlR?=
 =?utf-8?B?cXpLeGMxNUpFVUhWRUV6d3VzYUw4a3pML1BnUW9KYmFOVWdnWURWeDFYRGw4?=
 =?utf-8?B?cGlQRzlpT1A4NWRoRitFTEh1UzdyZUlKMUZOVEFaSEhQN2ZrWEZVWjg1Q2wy?=
 =?utf-8?B?WmJwdmZUcHgvaHRNcGZwdFVUL2JiaWhyalkwcGp4NXBUczN2L3IxeDZoSVFE?=
 =?utf-8?B?d3E2Tk8ycFVPdUROVGhRUnZPKytNR3diVTJCUFVTbHdnS0I0NHNQRHdPWmlH?=
 =?utf-8?B?a0plbEk4YXZpQ2tQcWR2aE9HM0NQVmRCME8reGQ5Mkx1ZG9wV0xUaDc1TjVF?=
 =?utf-8?B?SFJuNFB1YkNzbGFGekZ1aVBycjhXM2F3Rm5rd3piYlRIaWlyanhiQ3ZjZTk5?=
 =?utf-8?B?RnM2YVN2aW9kZDNtcEdtNkp1aDhLUEhwVEZOZVNCWkxaRFpGMXB2Z1ZuWTJD?=
 =?utf-8?B?bk9wemVRanBNK1pwQ1BrNzVaOTBpUnZDdmpPN2MxaWJZY3pCNS9XU2xUK0hT?=
 =?utf-8?B?RS9XM2ZzNHhhaFhIL1ZsZjE5eGZzeDNqcWZOaDFwNWVlSENCR1FGSHVjOW1Y?=
 =?utf-8?Q?Yk4s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d542ef9-ffaa-4547-8550-08d9aa666cc5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 07:38:34.2533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kPnsvTnpZ0bbRAyigNo21HlXhC/m1TT6B/c/A72w+W8vpNVs6A8tq6k4HhriLY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/18/2021 5:52 AM, Felix Kuehling wrote:
> On 2021-11-10 11:34 a.m., Felix Kuehling wrote:
>> Am 2021-11-10 um 11:11 a.m. schrieb Lazar, Lijo:
>>> [Public]
>>>
>>>
>>>> (... && !amdgpu_sriov_vf(adev))
>>> This kind of closes the door for all versions. My thought was - having
>>> it in the same function provides a logical grouping for how it's
>>> handled for different cases - VF vs non-VF - for a particular IP 
>>> version.
>> Except that's not really true. There is still common code (setting
>> adev->rmmio_remap.bus_addr) for handling MMIO remapping on VFs in
>> soc15.c and nv.c. I'm not comfortable with duplicating all of that
>> across all the IP version-specific files.
>>
>> I also think it's very unlikely that a small IP version bump is going to
>> change this logic. So I'd rather prefer to keep the code more general
>> and conservatively correct.
> 
> Hi Lijo,
> 
> The virtualization team has finished testing this patch and wants me to 
> submit it. Do you insist I rework the patch to move all the 
> adev->rmmio_remap fixups for virtualization into the nbio 
> version-specific remap_hdp_registers functions?
> 

Not required, it's fine -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Regards,
>    Felix
> 
> 
>>
>> Regards,
>>    Felix
>>
>>
>>> Thanks,
>>> Lijo
>>> ------------------------------------------------------------------------
>>> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
>>> *Sent:* Wednesday, November 10, 2021 9:27:22 PM
>>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>> <amd-gfx@lists.freedesktop.org>
>>> *Cc:* Zhang, Bokun <Bokun.Zhang@amd.com>
>>> *Subject:* Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
>>> Am 2021-11-10 um 4:14 a.m. schrieb Lazar, Lijo:
>>>> On 11/10/2021 8:00 AM, Felix Kuehling wrote:
>>>>> Disable HDP register remapping on SRIOV and set rmmio_remap.reg_offset
>>>>> to the fixed address of the VF register for hdp_v*_flush_hdp.
>>>>>
>>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ++++
>>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++++
>>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 +++-
>>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ++++
>>>>>    drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 4 +++-
>>>>>    drivers/gpu/drm/amd/amdgpu/nv.c        | 8 +++++---
>>>>>    drivers/gpu/drm/amd/amdgpu/soc15.c     | 8 +++++---
>>>>>    7 files changed, 28 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>>>>> index 4ecd2b5808ce..ee7cab37dfd5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>>>>> @@ -359,6 +359,10 @@ static void nbio_v2_3_init_registers(struct
>>>>> amdgpu_device *adev)
>>>>>          if (def != data)
>>>>>            WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
>>>>> +
>>>>> +    if (amdgpu_sriov_vf(adev))
>>>>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>>>>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) 
>>>>> << 2;
>>>> Wouldn't it be better to do this assignment inside
>>>> remap_hdp_registers()? Return with a comment saying no remap is done
>>>> for VFs. That looks easier to manage per IP version.
>>> I was considering that. I felt it was clearer not to have that hidden
>>> side effect in remap_hdp_registers and to have the explicit condition
>>> (... &&  !amdgpu_sriov_vf(adev)) around the remap_hdp_registers call in
>>> soc15/nv_common_hw_init.
>>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>    }
>>>>>      #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT        0x00000000
>>>>> // off by default, no gains over L1
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>>>>> index 0d2d629e2d6a..4bbacf1be25a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>>>>> @@ -276,6 +276,10 @@ static void nbio_v6_1_init_registers(struct
>>>>> amdgpu_device *adev)
>>>>>          if (def != data)
>>>>>            WREG32_PCIE(smnPCIE_CI_CNTL, data);
>>>>> +
>>>>> +    if (amdgpu_sriov_vf(adev))
>>>>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>>>>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) 
>>>>> << 2;
>>>>>    }
>>>>>      static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>>>>> index 3c00666a13e1..37a4039fdfc5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>>>>> @@ -273,7 +273,9 @@ const struct nbio_hdp_flush_reg
>>>>> nbio_v7_0_hdp_flush_reg = {
>>>>>      static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
>>>>>    {
>>>>> -
>>>>> +    if (amdgpu_sriov_vf(adev))
>>>>> +        adev->rmmio_remap.reg_offset =
>>>>> +            SOC15_REG_OFFSET(NBIO, 0,
>>>>> mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>>>>    }
>>>>>      const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>>>>> index 8f2a315e7c73..3444332ea110 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>>>>> @@ -371,6 +371,10 @@ static void nbio_v7_2_init_registers(struct
>>>>> amdgpu_device *adev)
>>>>>            if (def != data)
>>>>>                WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0,
>>>>> regPCIE_CONFIG_CNTL), data);
>>>>>        }
>>>>> +
>>>>> +    if (amdgpu_sriov_vf(adev))
>>>>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>>>>> +            regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>>>>    }
>>>>>      const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>>>>> index b8bd03d16dba..e96516d3fd45 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>>>>> @@ -362,7 +362,9 @@ const struct nbio_hdp_flush_reg
>>>>> nbio_v7_4_hdp_flush_reg_ald = {
>>>>>      static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
>>>>>    {
>>>>> -
>>>>> +    if (amdgpu_sriov_vf(adev))
>>>>> +        adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>>>>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) 
>>>>> << 2;
>>>>>    }
>>>>>      static void
>>>>> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>>>>> *adev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>> index febc903adf58..7088528079c6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>>> @@ -730,8 +730,10 @@ static int nv_common_early_init(void *handle)
>>>>>    #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>    -    adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>>>>> -    adev->rmmio_remap.bus_addr = adev->rmmio_base +
>>>>> MMIO_REG_HOLE_OFFSET;
>>>>> +    if (!amdgpu_sriov_vf(adev)) {
>>>>> +        adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>>>>> +        adev->rmmio_remap.bus_addr = adev->rmmio_base +
>>>>> MMIO_REG_HOLE_OFFSET;
>>>>> +    }
>>>>>        adev->smc_rreg = NULL;
>>>>>        adev->smc_wreg = NULL;
>>>>>        adev->pcie_rreg = &nv_pcie_rreg;
>>>>> @@ -1031,7 +1033,7 @@ static int nv_common_hw_init(void *handle)
>>>>>         * for the purpose of expose those registers
>>>>>         * to process space
>>>>>         */
>>>>> -    if (adev->nbio.funcs->remap_hdp_registers)
>>>>> +    if (adev->nbio.funcs->remap_hdp_registers &&
>>>>> !amdgpu_sriov_vf(adev))
>>>>>            adev->nbio.funcs->remap_hdp_registers(adev);
>>>>>        /* enable the doorbell aperture */
>>>>>        nv_enable_doorbell_aperture(adev, true);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> index 0c316a2d42ed..de9b55383e9f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> @@ -971,8 +971,10 @@ static int soc15_common_early_init(void *handle)
>>>>>    #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>    -    adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>>>>> -    adev->rmmio_remap.bus_addr = adev->rmmio_base +
>>>>> MMIO_REG_HOLE_OFFSET;
>>>>> +    if (!amdgpu_sriov_vf(adev)) {
>>>>> +        adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
>>>>> +        adev->rmmio_remap.bus_addr = adev->rmmio_base +
>>>>> MMIO_REG_HOLE_OFFSET;
>>>>> +    }
>>>>>        adev->smc_rreg = NULL;
>>>>>        adev->smc_wreg = NULL;
>>>>>        adev->pcie_rreg = &soc15_pcie_rreg;
>>>>> @@ -1285,7 +1287,7 @@ static int soc15_common_hw_init(void *handle)
>>>>>         * for the purpose of expose those registers
>>>>>         * to process space
>>>>>         */
>>>>> -    if (adev->nbio.funcs->remap_hdp_registers)
>>>>> +    if (adev->nbio.funcs->remap_hdp_registers &&
>>>>> !amdgpu_sriov_vf(adev))
>>>>>            adev->nbio.funcs->remap_hdp_registers(adev);
>>>>>          /* enable the doorbell aperture */
>>>>>
