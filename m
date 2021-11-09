Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF34C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 07:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B84E61056
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 07:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B84E61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC86A6E02D;
	Tue,  9 Nov 2021 07:29:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C355C6E02D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 07:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHvxnh/mUE6cXc3SPmYg7Okf+ax7rSkJMK66jcpneTbHeaHCFSJnG5dwo8vctzAx1asow29uKR55D6XDwa5ZZ7HV0rbtjr1UYlESoMRxU8HKnaFBQ/0QlhUHqZHYFY09/2HiNSoyFjlJ0Gua1Q1nL/28cvL9OBl3ewHmMr2cf/aiFcohq63dNedN40MtVafs3mwQhxjNoIrWHvw0/ahy2COmXVasDQh99VR7soP0UziRr42+utYTWf4AegCq1bqbM4xCFdZYcSjmcvL4MWUhRX5dc40JLHfaHN+xr/YQhK3ayakJd1Whimizv2ZIpjxMfGO0luV3FpD90RGQWMJYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASPKLdiXZlh4ezpMgZU5nfaqKlsQIziKfSpyEkmsx8g=;
 b=R8JF2LgBaU6H3R6QKSVk+g6qhTWRLQAsUsIL3HVBxUsVvG9jPUixFqOwZU75Bi6gj040w6J6cK1T4aYbCmdZxx1zabNKGtDhRJce6WpybuhtRjlEs9CnkY83AfrUIBDs4wk0bj1QM/vAgTOHwvr4HlO2E84NqbmX7dna3lt+9fon0GBRD2meG7DmZaTKbQVpxviITJ8PhSBNuV+VltS6ku9zGa7dPIjSXHs0XUFmsmO8YmfNxhZ5gjDCR5FoHZinyZTXZAr0ox6xVKRp0HnxsVHQOiStQRJIsnqwwFcU41XLyWUt0u+1DKheMmzPe6DmMXCm2bjYFPhwLNNfsh036g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASPKLdiXZlh4ezpMgZU5nfaqKlsQIziKfSpyEkmsx8g=;
 b=Smqul7ghh/5zQv8KZv+uotxcwT1YaNv0ixuU/R9o3o5wHvCEa72wluC2UJ/SeTydER/Z4NkJv5VL5HwJ2hN1Ngj3hq9rto0VKWoS1Y1DzhaSBiWA+x6dNFF5AKxZNchG4c8qljMhRtrtBKx6WAhUf/1cNJIrG5Dk+vEbKW2F3v0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 07:29:01 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:29:01 +0000
Message-ID: <00fc5d97-5228-1935-a544-91f2a9b1b803@amd.com>
Date: Tue, 9 Nov 2021 12:58:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Borislav Petkov <bp@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>,
 "Liu, Leo" <Leo.Liu@amd.com>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
 <YYkGteomN5Cbh1+C@zn.tnic> <3800b659-f0cb-2565-c525-91b5b34d1a30@amd.com>
 <d35eca15-df36-5885-ca31-a1bd50f09fdf@amd.com>
 <a1bfc35c-c987-38b4-e7b7-16c9b9295635@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <a1bfc35c-c987-38b4-e7b7-16c9b9295635@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::30) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 PN1PR0101CA0020.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Tue, 9 Nov 2021 07:28:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df3f5a43-8c28-4c76-5ee6-08d9a35299c0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659F3D65A63E145DED1929497929@DM5PR12MB1659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJ0BbekAzsNlFw82fYGQ8l6gdHVnajMGj9kk+Q6/DGmoXgfNT3qDEEtzVKjVP8JR/QGd2pdcx4nMI9IjXLCcuDiYYv0bzt7RkgZts2Qto/djsJMH9K2Ii00hGNCz7/4Kqy4E6i70LCFy0Dro76oKTb+UlBuYmzBaA7ybkf5+wiTVRjldl3+QKDz+LZyGVk7GoeyrDY1mr54H7r1NSIlRhMK0r6HSVNxaVW9QRGx6qupfddqARH3hsGEZtd2ehu/1hoqxQXj6afXeuzBQjPUc7brvcLzbgVtnEqe/GEtPHkwe446wGRd2UNYU4QsXvbsQFyuHVFlxDyWQdPO5Kf1KL2HI89/stEEQ6H0fTGWdPpRAzOg6WxeHVHIRPy22uL30eaHGloFokuS/E0HfeXsOK4xSQBiQ3PJJ5EtOSjauzff1evWZl1cagjJWUreLFqfA2WdwlO1DxhODkP95oHBYGl89EA+zuVuxbfy7nxW+4mVNM/1xQBhFNyp2mnm3RtVfuAwB9ontoWM9bPkD87ZmDbmh6tj5/z9zUS46ztGOMoE3V5DOApfOUNfqrQ2RfiqWfyX32JDZ25uDXnsB9o+z5dL4GFVM996d2WswUaPBlJUHLJYVk/bvMURu8maXyNgwVh2uTa0dTTTrzJDMLUyEHJiBST94CVjZNX3eEClro9QDSdjHlnrqhvYEYQDfhJmgwK/o694HrLOAVJb9XfPuVl0TiFDxjaCOMcHiFeHzVkgIERJhbOVBkZ59v0FDmwls6hbl249SQ1pwksxd1sKVP87WTs/hDofcArXGLkfmv7YAWdQznm+uTPVlgDrq591h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(66574015)(2906002)(53546011)(966005)(31686004)(86362001)(186003)(6636002)(8676002)(316002)(31696002)(26005)(16576012)(8936002)(110136005)(5660300002)(6486002)(508600001)(956004)(38100700002)(66946007)(66476007)(4326008)(2616005)(83380400001)(66556008)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTdDanhyVnNtUUVIeTZGb20vZzFlVTZHUXZldzduWEV1VUkrK0l1dlNzcDEr?=
 =?utf-8?B?dUVYVzMxWDlodTVNc0VLL3ZDMklDOGZDZXlQZ3dkZzhlQUJlWWMxVys4QmZp?=
 =?utf-8?B?V3ZySU95bmJtbEY4N3kvdmUzU2V4R29Td0dKOUdIQUF2K3FIdE1LYlNiMFc5?=
 =?utf-8?B?alZ6YVpMcjgrTWx6UnlNRXd3TjMvdVVnVk4vOE5abDlHdmlxcVFsNS9Fb2xj?=
 =?utf-8?B?YmxKa2ZlNUwzTXY0aVE5SG1ZSkdxQU8xY1Z1U1lJZXlISTZpOTlod2J6R2Vo?=
 =?utf-8?B?aUFiOFlPMVVOcmQ3Yms4clZXYTRpQ1BBM3FZVVVwWktFb2VaNE4yd2g2ZzB5?=
 =?utf-8?B?ZzBkWjd4RzRHRWlNSy9CbVA4b1NoNytNQ2RqRWl0ZWJja3lpaHZkMTZJbnFu?=
 =?utf-8?B?bVpGeWJ3czJxRlRzUUhzS0lhOGl2TG1wTGJrbjFSaDB6RGljNGxvVkorbHRo?=
 =?utf-8?B?YVFHdEoyMnE2Nnp3VjhSaTlKWHFTZU5tenlmMnQ3a0tSYkdtY201WTFKTTYr?=
 =?utf-8?B?M0NPQWVpQWQwSTdoUW4yeFl4MXEvSHAya1V2TnM0Wm9KVk1zU1Azd3VMWWVk?=
 =?utf-8?B?cXYyWVVmVno5ZXM4cHBtY2l4YnFNR0xUVHZlOUMzZE4rZnVpRXNiTDFIL1ZW?=
 =?utf-8?B?bldSYXRhRmN5U0ppdTh1c2pqMERTTDhHcU1KMkZzeGNjTWNIWGFXd2hEeHg5?=
 =?utf-8?B?WXBzQ3U5TW1yTUtUcGMyTVpPVVhkTU1lWEhWV2VDR1hYOHZ4dlI4OVhqYVhn?=
 =?utf-8?B?Y082TGpvd2xRWDY1UFdCbEM1UEhpNlZ4Vld1VWw3ai8rb3FyTzNjSi9mTWk4?=
 =?utf-8?B?Z0RGSmNnZ3QwNUJubkJvSEl3cUErQ3dWUEw1N1BmdHRFcEtlL0tSRWgyQmJr?=
 =?utf-8?B?WjlKYWlLai8wd0pGYW9Ia29PL0xMWTAzeEg5YmVMekx3d3hsWVNDNmpOQzU1?=
 =?utf-8?B?TjhvRENuS0h0SUxzZ205U1FqY2lSY1loRSt4bHYwSk00cUJIVklVT2ZTQTMv?=
 =?utf-8?B?bldoTG53MVI3MWE3K1pnT3dLKzNmSWRYNEdhTXVRM04ycWI1elB4eExZdzBr?=
 =?utf-8?B?NlRtcGtFdFZ0TXlMUXdXbStSMko0UXphR3pQWEEzNnNsYTNsTHNERXJ0M0dX?=
 =?utf-8?B?aVlsdXVpVTZLenlwVnhXUnV5b0dLNjNMODBndDB0NjRkWjAvMjZsVDBmTGQ5?=
 =?utf-8?B?dy85VHUrN3UrRkxMc0JITmZlbW9hSWJ1NFltNW5yUVFZR1owS1VTWFVpQkN2?=
 =?utf-8?B?NUk3VHAwZzZNN3BaemMxU3dYYm9ndyt5OEpmR2VJTGRiby9RMjhidlFHRVFs?=
 =?utf-8?B?cm5LU3FZd0pZRHJENWtReDNGSnBiM1lIcUhiVzRMbnRjOWVQUFVNOWtXdFlB?=
 =?utf-8?B?V01OMFpHTWdyNGZSbFMxNmJEQk5WWmVlWndIV2hDNTBtb2hheWRCeGs1OGZv?=
 =?utf-8?B?VmFIcEg4a3RVOHl0MkNxbTZTUUEwdmZRbnVHM2laTGgzUWd4ajZoWFdhZ0cr?=
 =?utf-8?B?alk0WjM4VEUrUDMyUER0b0liRjJ3dFl6YlpNWnpNVHVwaUE2ZGlUL2VUc0lG?=
 =?utf-8?B?bXRvcmxqUEFOQTNkVDR4dkorOEtOUGlKUTduRlh6UjJNK2pCNHRjc0FqT2pP?=
 =?utf-8?B?SThZZlhCQTFMZ1VZekYrdDBwK2gvV0hqeTNzWnF2ci9GbEREQVNLOVNVV1Bz?=
 =?utf-8?B?eTZNQ0NldnA5aThzZExpQWdnZzNPaEgvVEE5dVhzTDB5NnlNdm1xOXEvenhD?=
 =?utf-8?B?MWpIVllUNENyUHJldXhPTWlIWHhPdnk4Uml0bHB4RUFOeFFJdmU3UVphUDFO?=
 =?utf-8?B?alYxQlRCRnhEZlNtT0ZDUS9FdUdTNHRlTmdCZHhna3RkZU5IZnZEbWl4UVhB?=
 =?utf-8?B?TEtqaVdINmc4eDRheWozYzJ0UVBhODRkOXd5cVJoZ094Q2pmNVRySGpGUlE0?=
 =?utf-8?B?d0hieXk4Ti9wNXVsUFFjdUxES3NiOTZsVmJpeEFMaUNnTnVoUFJlMkppb0tt?=
 =?utf-8?B?T1R0c0tma0hxMExTMDJRbjdZYlcwNnlIMGdHV1o3dDVzMUVKc0RyRTFSZ2hq?=
 =?utf-8?B?M01TbVJmRGF1dTlseVNzNmR4cSs0VkxuM3o0bE1NWWZ6NFlja1BkcGZXS0pC?=
 =?utf-8?Q?/A5Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3f5a43-8c28-4c76-5ee6-08d9a35299c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:29:01.5870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW9J3txiju+XiRkQtF1btKxG3NydIMMPjv7ghvnRqNE7rDpLzm8E6GhI8pDAKPOL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/9/2021 12:46 PM, Christian König wrote:
> Am 08.11.21 um 15:41 schrieb Lazar, Lijo:
>>
>>
>> On 11/8/2021 7:44 PM, Christian König wrote:
>>> Am 08.11.21 um 12:15 schrieb Borislav Petkov:
>>>> On Mon, Nov 08, 2021 at 09:51:03AM +0100, Paul Menzel wrote:
>>>>> Please elaborate the kind of issues.
>>>> It fails to reboot on Carrizo-based laptops.
>>>
>>> That doesn't necessary sounds like a good idea to me then.
>>>
>>> What exactly is going wrong here? And what is the rational that we 
>>> must fix this by avoiding updating the current state?
>>>
>>
>> Reboot will trigger a suspend of IPs. As part of UVD/VCE suspend, now 
>> there is an added logic to power gate the IP as part of suspend 
>> sequence. In case of UVD/VCE, power gating would have already happened 
>> as part of idle work execution.
>>
>> In any case, power gating is done by SMU FW. The assumption here is - 
>> the logic to power gate IP could involve register programming. AFAIK, 
>> accessing some UVD/VCE regs during powergate state could cause a hang 
>> unless the anti-hang mechanism is not programmed. That means either FW 
>> or driver needs to track the state of IP before accessing those regs 
>> and in this case probably FW is assuming driver to be responsible. 
>> i.e., not to call power off again if it's already powered down.
>>
>> Though that seems to be a bad assumption on part of FW, it is still a 
>> possibility. Haven't seen the actual FW code, it's a very old program.
> 
> 
> Ok guys I've double checked the git history and found that this here is 
> not as it is intended to be.
> 
> See the code in question was just added in August by the following commit:
> 
> commit 859e4659273f1df3a23e3990826bcb41e85f68a5
> Author: Evan Quan <evan.quan@amd.com>
> Date:   Thu Aug 19 12:07:59 2021 +0800
> 
>      drm/amdgpu: add missing cleanups for more ASICs on UVD/VCE suspend
> 
>      This is a supplement for commit below:
>      "drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend".
> 
>      Signed-off-by: Evan Quan <evan.quan@amd.com>
>      Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Before that we where just not touching the UVD power state at all during 
> suspend and so we won't had a problem in the first place.
> 
> So what we should do instead is to just revert commit 
> 859e4659273f1df3a23e3990826bcb41e85f68a5 with a proper fixes Tag and 
> explanation why that is a bad idea.
> 

Yeah, right. If I remember correctly, this commit was originally added 
to fix hangs with S3 suspend/resume cycles triggered during video 
playback. Reverting could bring back that one. Evan will know more 
background details.

Thanks,
Lijo

> Regards,
> Christian.
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>> See we usually assume that updating to the already set state is 
>>> unproblematic and that here sounds like just trying to mitigated some 
>>> issues instead of fixing the root cause.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Whoever commits this, pls add
>>>>
>>>> Link: https://lore.kernel.org/r/YV81vidWQLWvATMM@zn.tnic
>>>>
>>>> so that it is clear what the whole story way.
>>>>
>>>> Thx.
>>>>
>>>
> 
