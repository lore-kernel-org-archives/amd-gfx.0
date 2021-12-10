Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F97C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 21:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A542D10E2B6;
	Fri, 10 Dec 2021 21:17:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF9210E2B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 21:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGCTK2b1c9hedr0yaowWR2d7BaswS/Le+eXe2Eir/WrGn/f6xYqLEckhAydr9xHYaqt48s0547Fd+h1MOTkjxtxTWT+EKKlWxyTfTLa+b1C1bDJyrEEQRXV7xgpWG6q6rZiVoXjJ4sntRqek+PtVUejahEE/sGampn+iiiTe8oum6wgk6oD2q4gXfm9X4n/+WHpu+a+QBuY7ifjNHq2sd+NMA6CtKax98sGP/sE25J56NHFCgcRwIWPwCxUYscFxP9MUbaUC/CQLFCheiLym++oCopoZ1dqIlUW02e5EZj7Jkjcyh6e3ngkxNqsmj5RexbqcJXIN7KFafar8qPwIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKZ4vpeksS7sDrAOlV/qBOUl8sfun4qFgtIfxhf+HKM=;
 b=H5St96A7OhIZjrEgiPE4n6ILJrfwjYo8bSYLTjlfJnY86fVlxOIZIOnXQnS6arI5HyxlVfz6zpHjdYbcinTmfXmCrRfEIKJ0CQ2ONFELzXUU6Sq5YeTr7dIWgxYhC5WGTfmjoiT2QRNu/qBlNVOGWcrHfwIItGjECUV30t+bCdWbMdot36pQ6D/FEteoQ0m3CcMm65wwDmsCguohv5NdUoLNs0Z+wxcaP5G+Sr11RoN18Nw8Vy1tUcthLjRmp5wpOqk3UYVQFSGWzbuJZiqNTUFQYyp7HCX9P3kJB3KucgUMqmUrl1+C3tSnjZCrE7nUb0nx2MmRM9m+OteRmh7bpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKZ4vpeksS7sDrAOlV/qBOUl8sfun4qFgtIfxhf+HKM=;
 b=5m8StL6LmxU9meHLtJdsmL9Kp+JkaGqLGSkdNZTlfi6ss6ejWSFiFxDskXezdQLNzYoJEF+J5hfYbVW7pSa1UJLsJh7yAkO3vVnAuWJdS8Yb5fCGMw3HwT68Ck3aqq5H9/+td4lTWojlczybCrj8AcT0HcbfsoODSN8hDtC0NSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 21:17:54 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::9d61:180f:e2e0:2db5]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::9d61:180f:e2e0:2db5%8]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 21:17:54 +0000
Content-Type: multipart/alternative;
 boundary="------------aWJm5bgVYRQXDa0jay0OGyWz"
Message-ID: <1b3f8287-2b30-2f23-ea05-6c3796fa8620@amd.com>
Date: Fri, 10 Dec 2021 16:17:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Content-Language: en-CA
To: "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Gong, Curry" <Curry.Gong@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
 <eb4b71d5-9e08-eac2-43a6-55c82467faca@amd.com>
 <DM6PR12MB2619D1CD28F5D22322CDC40EE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <DM6PR12MB2619D1CD28F5D22322CDC40EE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::21) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb9324e6-37a1-4eda-d795-08d9bc228782
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3019FDD29478B97745165CEEE4719@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGbjOhiipouVyKc1b3jS2v3onqN+kieKy4KiFlGQikvo25KEnxWJnU0Newp7Biou2KFhusoWaxU1fB77N0NbEGd1oieMrRXL6gfK50SLm3vabVo+MYl04xbj8+zAXIqbY8fWylJxlN2a3T7/FGmI3vBO9JL+i3deFjfX92psEZe39uHaD+lghRwHJiRUdreNPvM2YjQ3F2jFoanZHD4VJW6YlVWldENVZq1CTYe1KL72SNtgmi1fS3wID22nTsErVI80yIBbI8hqe+QBWqkPFUtml3jtYHsUDIQvmxE4UYfjiADH0IvueYxJ0M9YcAAQ8u7/eCOdrlcpRvFdVyqiM0Rl9DR1W8ch3lxPN9ReEjr4zqoLiOz3SCkWFP+FXIBtkbAdNk9WzmQg3zDIAjseTreQn4dPUoLwZ2EDF7hd1Biizg/5mlM2kE1nNEGoZqNUs1Y741GhFpqwL6Q3t5dVst8v9E9Atb3wVXhB5DM0PislJdOAmfPFTUsD+sxhtqtqbgldNXpeoIX8L7IELG++DD6Y8uaa204Wv54ODYBJ+DRgfmuTd1vPD/t71mySz9ZDsLELlV0njWGdaA18GeBr+l14HACbkYf0ZNbQsPwUSaAbXhgn6iQ67W9RArclSZYhCUlYgI5oJ18cSMeWn5OTVDEyx94wQhNePuMbG1c4T4SoxtXbiEuyf5GDB0g5Ph8l93nKhzIOrsNP6yyy816tFJOZ6+BE12gJMngFCEjo4zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(2616005)(8936002)(6486002)(26005)(186003)(31696002)(6666004)(31686004)(66946007)(53546011)(6506007)(508600001)(38100700002)(83380400001)(66556008)(8676002)(66476007)(5660300002)(15650500001)(4326008)(36756003)(54906003)(2906002)(110136005)(316002)(4001150100001)(33964004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0RFa2pXSDExL2JZU0dleldRYkZOSkt2QTZ4SlJrMTJjakxtbnRxT21kQVF1?=
 =?utf-8?B?b2hFcjFDT3VmemlWV3FYbkV0dnIrOWduOVJWVDF1YzhHMlBDYTJZTG15UWZX?=
 =?utf-8?B?bnRrSnh2WkMzUTROV0JVVlI5Q3FOMmpMYmxIc3J1T3NjREFoRkh3bjVVaU9X?=
 =?utf-8?B?YWRNY3htUGVOQy9pVWVvcENpaEczU3U0M0VEU0ZCbTRHNmtmTldZUWdha0Vh?=
 =?utf-8?B?MUsxVGptcjk2OVE1UUVPVjlhMGxBYzlPaCthRnJLVU5zbkdSNStrUzdCUEl1?=
 =?utf-8?B?NXpNQmhxQWJKalZ3dGRxVCt5TkxVSzRoSm9lK25IaVBuTVhIRHc3QXpTdHdL?=
 =?utf-8?B?c29kTnY2UG52cTlrc2xtZWgzbDZBWlZNemZmUWx4NDFGUW1xaG9Ud0YrT1cy?=
 =?utf-8?B?ZzdGeUVRNnljbDA0cEhXNVRHZHFXQk5RMmtKL1JDL243bXZ1dEp6MEhGT09O?=
 =?utf-8?B?dGY4d0hQdzhNQWhJeG5BRmUwM1krTktRWG5kSzUxQWg0WjZRVnNteVhUbUVR?=
 =?utf-8?B?cFZ0NTlxTU1rVzJIcHcrZlNFb3IwSEJOajd5T212MFVZUThxc1JXR2Vsa3Y3?=
 =?utf-8?B?b1dsb2x2Ry9WR2NpY3QwdmhraFZ5SEFoWFRVcXZFeUJpd1gwbVpFUEZJYlBy?=
 =?utf-8?B?ODNDM3d1Z2MrWDJKRE52bGR6OHpqZW9RR1ZXeHJGMlR3U3krblJjVGZKVHZ0?=
 =?utf-8?B?WFppNGYwRXJkajlmcE1TSzFzaGRBWEUySEdQcmQxRTdHU091RVdXSjd1ajNm?=
 =?utf-8?B?QXZHTFVneGFrSkpYaDZIclhJMDNUMXMvbFJuWFRJM0hVc05SSnpWQ1ZVTEox?=
 =?utf-8?B?VVRkZ1d3YkVhN24ybjJoOWMvREFpMmQ4d3h4MHBvUUprTSs0ODFzMEFVKzhH?=
 =?utf-8?B?K1BrMzZIMW1zRG5BUWFFTk1iWnZDU1JjMUIzYkdhR3JaUnc5dXNMRmprbU81?=
 =?utf-8?B?dzhlckZQaGtuNEhoN0hmWGpJZEcxUUpJU3VzT1hhL1ZURHEvYlpQZjBqMDNU?=
 =?utf-8?B?Z3BkYUxlZ2lCdHJkWXk5RGtnMzVLOFMyeXp1cDNVWTRlY25tZGUxUkdKN3Jk?=
 =?utf-8?B?T2NzL210T3RRR3RGTjF5TWRzQnZTc0Y1Y2FLUGlha3J4VU5ubmxmVlhhTm1j?=
 =?utf-8?B?RTZPVmwwS3RsejdqM1dXQ2dJdWZ2WE11ODNnV3hFQ1NtWVl6M2ZET0pqYnVo?=
 =?utf-8?B?RFV0TjYxcWdFWkY5YkVMa0JhTmNObjZjOTM5SzFvdnlCeEJrdjNZNXZzMDRx?=
 =?utf-8?B?dzRiWS9xdjM1bzhjRzdoOS8wRzFBcmwzTWgwTjdPTncrUkk4Ums0T2xqdGp0?=
 =?utf-8?B?dU9oT3o2SGJ5aFFEcGMzS0V2TGV6aWVLL0NMNzE0bmxvU2E5eldjd2VIbzJt?=
 =?utf-8?B?VWhCQnRyWlUxdk5vUTQ5YlFNOHpxOVJwVi9ldmxCcHprcExtYlQ5cEZyQmlq?=
 =?utf-8?B?emxpSmg4VXRKS1MzRXJlbFduYUdxYjdIeXBxaUI4dHlaejV6a3JYV1FrYlRt?=
 =?utf-8?B?azg0ZVQrL0ljZnNJQUtpcmRlNUptWm9KcWRjaldQam1DZ3Q3bDJwWGd1T3BP?=
 =?utf-8?B?bGJYbHlMaHl0ckV0cEhIczQ3djY0ekdWeTdqTHlFallGNkl3YVF6TGJQMFd3?=
 =?utf-8?B?OW9sU3ptTEtkOUVaTGZMSmovT2dFNmt1UnorQzdqakQ1amo5Q1J3T3VPYmVx?=
 =?utf-8?B?ZGU2US9IUm9GOTQwdjlYdWp4UUpNNkd3R2tsQjFYUXc1NnFxN2tXVFZaLzFS?=
 =?utf-8?B?RytjU0ZzVERVRGhMYm1Eeng5SjFXY2R4MmUyZjJKSmxhUUJUcXdUMGlWdlkz?=
 =?utf-8?B?MytSbzlHbDM1L2tOemZPaFZIelQ4L0ptRk13RVB4OTVGeExuTDQ4UUcvaTdi?=
 =?utf-8?B?VXA5NitxZ2xpV1JyT2hvd0Q3a1Q0a3dia3ZNL1BESCtLQzZqWWpuRUQrOGRi?=
 =?utf-8?B?Tmt6WUdpWHMzZTNodFJTUmlqYXhTVHRVbEJsZitWeExidm5NaUdmZTdQTytH?=
 =?utf-8?B?YStRT3kyQmtWblNTL082d1BjcU5XZkgxNng3TkNTUmM2WFNkZWdlLzRMaTRz?=
 =?utf-8?B?Nmd3TG8xZVcxL0RucG1CMjZMa1FoTTMzOGhoZ1l5YTZ6cFdzWmw5eXhRVnI0?=
 =?utf-8?Q?IKxE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9324e6-37a1-4eda-d795-08d9bc228782
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 21:17:53.9644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHMlSguKwILLe3j5o3epTPKI/dEx04ZHpFLM+MvZ5dLv8ryh8nPFZhYW+6zygFMA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu,
 James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------aWJm5bgVYRQXDa0jay0OGyWz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2021-12-10 11:19 a.m., Quan, Evan wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Lazar, Lijo<Lijo.Lazar@amd.com>
>> Sent: Friday, December 10, 2021 8:25 PM
>> To: Gong, Curry<Curry.Gong@amd.com>;amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander<Alexander.Deucher@amd.com>; Zhu, James
>> <James.Zhu@amd.com>; Liu, Leo<Leo.Liu@amd.com>; Quan, Evan
>> <Evan.Quan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
>> powergating is explicitly enabled
>>
>>
>>
>> On 12/10/2021 5:11 PM, chen gong wrote:
>>> Play a video on the raven (or PCO, raven2) platform, and then do the
>>> S3 test. When resume, the following error will be reported:
>>>
>>> amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR*
>>> ring vcn_dec test failed (-110)
>>> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of
>> IP
>>> block <vcn_v1_0> failed -110 amdgpu 0000:02:00.0: amdgpu:
>>> amdgpu_device_ip_resume failed (-110).
>>> PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110
>>>
>>> [why]
>>> When playing the video: The power state flag of the vcn block is set
>>> to POWER_STATE_ON.
>>>
>>> When doing suspend: There is no change to the power state flag of the
>>> vcn block, it is still POWER_STATE_ON.
>>>
>>> When doing resume: Need to open the power gate of the vcn block and
>>> set the power state flag of the VCN block to POWER_STATE_ON.
>>> But at this time, the power state flag of the vcn block is already
>>> POWER_STATE_ON. The power status flag check in the "8f2cdef
>> drm/amd/pm:
>>> avoid duplicate powergate/ungate setting" patch will return the
>>> amdgpu_dpm_set_powergating_by_smu function directly.
>>> As a result, the gate of the power was not opened, causing the
>>> subsequent ring test to fail.
>>>
>>> [how]
>>> In the suspend function of the vcn block, explicitly change the power
>>> state flag of the vcn block to POWER_STATE_OFF.
>>>
>>> Signed-off-by: chen gong<curry.gong@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> index d54d720..d73676b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> @@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
>>>    {
>>>    	int r;
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +	bool cancel_success;
>>> +
>>> +	cancel_success = cancel_delayed_work_sync(&adev-
>>> vcn.idle_work);
>>> +	if (cancel_success) {
>>> +		if (adev->pm.dpm_enabled)
>>> +			amdgpu_dpm_enable_uvd(adev, false);
>>> +	}
>>>
>> Probably this is a common issue. Can you try moving this to
>> amdgpu_vcn_suspend?
> [Quan, Evan] Yes, amdgpu_vcn_suspend seems a more proper place. However, the vcn code is not consistent.
> For vcn v2 and later, they already do the manual gate operation in their suspend routine(like vcn_v2_0_stop).
> So, it is actually only vcn_v1_0.c suffers this issue.
[JZ] Then what is concern for vcn1 not doing the same thing as 
vcn_v2_0_stop?
>> if (adev->pm.dpm_enabled)
>>      amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCN,AMD_PG_STATE_GATE);
>>
>> Call this after cancel_delayed_work_sync. Shouldn't have any effect if idle
>> work already put it in PG state. Evan, what do you think?
> [Quan, Evan] Should not for now. But I'm considering to raise the dev_dbg prompt in amdgpu_dpm_set_powergating_by_smu for double gate/ungate to dev_info or dev_warn.
> Hopefully that can help to capture some potential issues like this. So, better to keep the check for the return value of cancel_delayed_work_sync here.
>
> BR
> Evan
>> Thanks,
>> Lijo
>>
>>>    	r = vcn_v1_0_hw_fini(adev);
>>>    	if (r)
>>>
--------------aWJm5bgVYRQXDa0jay0OGyWz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-12-10 11:19 a.m., Quan, Evan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB2619D1CD28F5D22322CDC40EE4719@DM6PR12MB2619.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only]



</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>
Sent: Friday, December 10, 2021 8:25 PM
To: Gong, Curry <a class="moz-txt-link-rfc2396E" href="mailto:Curry.Gong@amd.com">&lt;Curry.Gong@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Zhu, James
<a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>; Liu, Leo <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu@amd.com">&lt;Leo.Liu@amd.com&gt;</a>; Quan, Evan
<a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com">&lt;Evan.Quan@amd.com&gt;</a>
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
powergating is explicitly enabled



On 12/10/2021 5:11 PM, chen gong wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Play a video on the raven (or PCO, raven2) platform, and then do the
S3 test. When resume, the following error will be reported:

amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR*
ring vcn_dec test failed (-110)
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">IP
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">block &lt;vcn_v1_0&gt; failed -110 amdgpu 0000:02:00.0: amdgpu:
amdgpu_device_ip_resume failed (-110).
PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110

[why]
When playing the video: The power state flag of the vcn block is set
to POWER_STATE_ON.

When doing suspend: There is no change to the power state flag of the
vcn block, it is still POWER_STATE_ON.

When doing resume: Need to open the power gate of the vcn block and
set the power state flag of the VCN block to POWER_STATE_ON.
But at this time, the power state flag of the vcn block is already
POWER_STATE_ON. The power status flag check in the &quot;8f2cdef
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">drm/amd/pm:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">avoid duplicate powergate/ungate setting&quot; patch will return the
amdgpu_dpm_set_powergating_by_smu function directly.
As a result, the gate of the power was not opened, causing the
subsequent ring test to fail.

[how]
In the suspend function of the vcn block, explicitly change the power
state flag of the vcn block to POWER_STATE_OFF.

Signed-off-by: chen gong <a class="moz-txt-link-rfc2396E" href="mailto:curry.gong@amd.com">&lt;curry.gong@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index d54d720..d73676b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
  {
  	int r;
  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool cancel_success;
+
+	cancel_success = cancel_delayed_work_sync(&amp;adev-
vcn.idle_work);
+	if (cancel_success) {
+		if (adev-&gt;pm.dpm_enabled)
+			amdgpu_dpm_enable_uvd(adev, false);
+	}

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Probably this is a common issue. Can you try moving this to
amdgpu_vcn_suspend?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">[Quan, Evan] Yes, amdgpu_vcn_suspend seems a more proper place. However, the vcn code is not consistent.
For vcn v2 and later, they already do the manual gate operation in their suspend routine(like vcn_v2_0_stop).
So, it is actually only vcn_v1_0.c suffers this issue.</pre>
    </blockquote>
    <font color="#288aeb">[JZ] Then what is concern for vcn1 not doing
      the same thing as vcn_v2_0_stop?</font><br>
    <blockquote type="cite" cite="mid:DM6PR12MB2619D1CD28F5D22322CDC40EE4719@DM6PR12MB2619.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
if (adev-&gt;pm.dpm_enabled)
    amdgpu_device_ip_set_powergating_state(adev,
AMD_IP_BLOCK_TYPE_VCN,AMD_PG_STATE_GATE);

Call this after cancel_delayed_work_sync. Shouldn't have any effect if idle
work already put it in PG state. Evan, what do you think?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">[Quan, Evan] Should not for now. But I'm considering to raise the dev_dbg prompt in amdgpu_dpm_set_powergating_by_smu for double gate/ungate to dev_info or dev_warn.
Hopefully that can help to capture some potential issues like this. So, better to keep the check for the return value of cancel_delayed_work_sync here.

BR
Evan
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Thanks,
Lijo

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">  	r = vcn_v1_0_hw_fini(adev);
  	if (r)

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
--------------aWJm5bgVYRQXDa0jay0OGyWz--
