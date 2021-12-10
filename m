Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A73C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 12:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9455310E6B5;
	Fri, 10 Dec 2021 12:25:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFA110E6B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 12:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmZyEU3Mm+5Tozu/d/wVXuiUhZO9MVUr9EvZGNmO2pF+/jLAffZ9XK3hR6cFEhG7H60yyKGFSwZSXjPTggBBTv4Xjsh+Yc6m1VUVk+d1lcVjuLYOsub7aSN6vHizl2u+QqYkGFbahztC/5N+M28UxFO1u/X6VkF3PyXFXK24SxJs8ImaUm///AvtAD0n6FFPkdi2f31RvAG3mxzXxj/4c1DXa0ad09nlcsLe4JVRbZvlMC3qaZNOcYFHgf6pMYhr2DXd0KGM6bR8Yzd8K2wSQ6QtX2wPHttMShlVREVV82U+KLkfZQyxRyJjDsGLUCB6Q2qriTq1DjXAkDRehsILAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CZkGh/EfWW+qlxdDSDzosdrlEv8AmJ6O8xCXYqXV60=;
 b=Z0luTsu9PBOj7lZjFs4ZU9heavOYAbERxB+SVky6lS+PpDPJI7iVxeDmNe+ZjOVYTbpseWduqmhOIo9WyDbmNFrYtKpjzvFOdaJzaCZkzqLSo2ean6k7e/Zf1xhCm2z6KHc/tKMvJmPmkOYuyT9BlwvXVUwFZaWg1x5a/I0GSpiSCy7irG8aNXeFm5mbrfSYoLbrZEtMVyVZZKTw0jn/ojWq6xD9+/Zj8KXr37sgv960zyF8xkXWhYrgRcCzbHzrB8/PAlRJrMX1HGVVxw9PRd8O92TJrIMyONzmp3SAtd9OBxj2L568YuOMxjQdC0rp9J+cfS1V1HXwXVB0j+gbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CZkGh/EfWW+qlxdDSDzosdrlEv8AmJ6O8xCXYqXV60=;
 b=Ld8a4lAYpWzZuDdSow54fLOskiTtpOmR86LnFJIiHncGB5k6Yuf96N4TkJRTSx3SpgtdOeLyrPNwUI6F2RwJ6mTVWhAE9so6oTrjt05llvIiK/qz7rl/7TUllmgAV4+kz9So/rMoyc4E/WtkJLm6i31NR7XPltjf2qWx0gaGLFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 12:25:34 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 12:25:34 +0000
Message-ID: <eb4b71d5-9e08-eac2-43a6-55c82467faca@amd.com>
Date: Fri, 10 Dec 2021 17:55:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Content-Language: en-US
To: chen gong <curry.gong@amd.com>, amd-gfx@lists.freedesktop.org
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cabe3a1-d813-4b3f-ab07-08d9bbd829cb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14340F8F1D4EEE4AADAC0B9D97719@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1tjMPooF6sNZ0r6F8CxnitLkTPD+XFAvvks7T+wJI97t89pyqdOXafqegtLdhrYARe5X1+mgESy/BCgOk3+LSCnN9qzCTqsFa8PEFzgycs76REqM7Sosn7qmv0L4zgPwNzMsawaXLow17AITWCT0rL1NaPTb5mTHRCQuIsjvoyYy2nguIkj0kP+VFhZEpaFZsZP0/Q9UFKH8tpdixCFO7v08Q3X4E5j8GJtpfUWR3cpdvByFghPVnBjqxeMUkS8QIMGXJyc8zVvUbQ2MpEhWddVHUXijAIaGkVY4TfzifXC4EY64VStUAqiBeKHgpDYoHTpYWSuaLGn7Of6TO3Bd+zh7bY7M/DYvR0wH/l+UrwsKeTVhuoVB63C1s/oQLk6b+qdXzQUplm/G/MRbMLYyMBIc9YLx6URdlVgxVNdvX3M3BFV5EsPzoaomeX6Da5+T/t9FlLPIQRpBZVLNdChVQjLwmu23ZrR4yfB+SlWOCnrnv+p4GaqbUKEX39D55Er9zDRezxB0IpmBNA9E9SkxNx1nwPopkbasRek8zGpJ2vvs8soaPoiy9VPNw+vX78gxDIcJrMgq+z1/BOg4HA+jLT0p9fAv58gv47gZHdJDoofM5MSSHWHfdgz1K7euS+XBXbkvDoSSQlpI8ApumV9v1w6e9VhXwPgnwIGZzy9Pt8LFSBA3+Cx6e+d4Yf2LD5piD6fD5SqSw6eSdWCsh1ug6kLDiuNU2cBSF9UGv0pdfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(186003)(6506007)(53546011)(26005)(508600001)(6512007)(8936002)(36756003)(5660300002)(86362001)(2616005)(31696002)(38100700002)(6666004)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(83380400001)(6486002)(15650500001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFQxdmRsUDVMNHNCc3h6V1NsTjA5enJJZExkdWRlR1c1Ylc3SWhsWTZtT0V0?=
 =?utf-8?B?U1U0RzNkazgrUjBDLy8vMlAyV0ZjYnpBQUxFOE9sR0dDcnBUWk5XVWFUNklR?=
 =?utf-8?B?c0IxVEoxU1ZDcDFVblVkaS9iU1hQTHo1aVcxMzFyYUZINDZ6Syt2alpDclJD?=
 =?utf-8?B?WnkrRURYZkZwTllxQ0doRHV3YmxveUpJdkJPQkZRcTNKbDJpVmlFNUVwVXQ2?=
 =?utf-8?B?WE9tWFdIWmZwcWVQSFh1YVJESlUxSjRJbWYyZTE3YkFsYTNwOUsreW5uRGNo?=
 =?utf-8?B?VjZwMkdLUFAzL1MrWnlvUWpaOFliQi9LYUdrYU5JTHprc3daem1vSUpLTDlF?=
 =?utf-8?B?OWRyczh2U21FcjlFUVBleks0OGR0T2xSdUc0WDVVVndJWjBBdEFTUFRVUHN1?=
 =?utf-8?B?RytWbmY4SnROM1A2dlVXQmd6ZFRXOXN2N1NmUG1CWUJTNVpaZ2liMlFCMXc5?=
 =?utf-8?B?SGJBSFNraVdONUhsVUZROU1BS3dkM05VUGN5YXdXMXFoTEZRNU55TjlDdUUz?=
 =?utf-8?B?TGc3eVNrcVJLTkErSkE0ZmUvQ04wRnkybkZYWGlEc0w0eDljT0FqN0daaG5J?=
 =?utf-8?B?L085aWxzT3hJekVSZTVNTGc4dnMvclg4UlhrbjNCVDJOWXIzcE9wRGF0OHlU?=
 =?utf-8?B?TnlialNWWk9JMUNMZFFtMDdzQ0lDMGlLK0JXZDF3V3BCRENnWFRXck84MUNV?=
 =?utf-8?B?Njd3L1BwWitVTkNxTjhpeFZZblM3QkpiSXFzS2tzb1BJa2FhT3lPdGJHbWRr?=
 =?utf-8?B?aU9mRnUzL3I4a0RFa1hCd3FZU2hNUUpGQXRhcnI1OU1XVlpranR1TkJ2aW9j?=
 =?utf-8?B?SmxydU5hdjdESHJ5K0E2bmJqZW5uOHFOSlp6ZnYyQUJLNEhmZ2Q1VTRvV3Zs?=
 =?utf-8?B?VlVLOUEvWE90U0lyU2RHUHRDc1dPVGRkWFB3bFZFSWZMQ2EwNXE4OVp1RHRT?=
 =?utf-8?B?SXNoaCtaY2JJbCt2NzM4NWpHL252dzU2U3o0TlY0Nm1qcnFZWjVrQTJTNWtM?=
 =?utf-8?B?Mlo4VXBnbFMwdGV1QkNpclhSRTJJOUtrKzdMNXhOT2tIcThFbUM0eTdYbDYx?=
 =?utf-8?B?NE5vbGRaUU90UEF5TTRpS1BSTkJlMW5QNWp1T1VsaVNjMlpoNGxxa1FCeW1n?=
 =?utf-8?B?R3hNc1kzVk9mSGEwY1RjaFh3RDQ4YkRlSVVtblBkR3JFV2Z1WjV1dUVGbFFk?=
 =?utf-8?B?MmQ3V0dtL1NQekJMeWJlaEhQV0kyZXZhTVNtaEdvamkrZmdiYW03TzJJcjRZ?=
 =?utf-8?B?NlVyN0pIRUFWR2l0c2lUL2gydE5pRWE1Ryt2bmY1UXVPNkxhK1hueHFnVFl5?=
 =?utf-8?B?S2U1OVFweXVNL05rMjgzOE93dVB6QlJWbkE0N2ZwTUFMdFJ0YmJuQ3REZ290?=
 =?utf-8?B?Rml2UjlzRDI5T2Q0TG9pTHQrSG5WUFp3eGhPYjJWSHRjbVlRQ290M1FaMHpm?=
 =?utf-8?B?YzI2emU2cFpoVGVlS0Z1L1MxcTVXdzlZNC9CV2l3YUtWbkxpVSs0QldIY1Jp?=
 =?utf-8?B?Zlptb3RzMXdMN3RMTGhrN1pDbEJBZUJnSFFOUkNhTUxwSEtpQTM3MmR3Ylgw?=
 =?utf-8?B?eFY4Rm5hVmZUSTRJOVJ1WWs0aXJTK25QVlgwM1NQVjNWOTRpRFBid29wb3hy?=
 =?utf-8?B?MFFmQXZXTVBFM1BSNW9RMmhJTjU3Z2NvbVAwbnQxbHpWbmNEV0p4dDk5aFNy?=
 =?utf-8?B?NGtyZXBCOVlqclhoMG1HMWJMR0RWbkJiWUM5bGIvWll1dWZsUzNKUEYxM1l0?=
 =?utf-8?B?N3ZRWE1rUkQ2M3JERFUyRVNPRUIyZ1hMN0tiK0hwQ0QzVXpuMTBKRk5JTHFu?=
 =?utf-8?B?T1pBT3YrNnBzM0w1blNSUkUvakNBN1ZMb1JzdmR0TVZYdXlWYVA2WDJOUUhJ?=
 =?utf-8?B?RmgyYTRaYk1qdEozZFVURlF0RUhCNHJCOWhIdnJRTmc3NkRYdHdxZXhSQ0JU?=
 =?utf-8?B?ZytTenlGTUZIbHg0ZjZQK1pHVEgzTzc5UjErcC9ER2FvaE5pZ0lnMEFDQzhL?=
 =?utf-8?B?TUt0c2pJV3l2c0ZJT1FCT25yTmltaXY0UzF2NGhMUmxhQk4zQ1pvNm1RM1BL?=
 =?utf-8?B?Y09YT25xNTk5eENrcWZHYUtHTDZycTkvZGJzR0dMeXdsWUFRcnlVTjNtVjFj?=
 =?utf-8?Q?kpnw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cabe3a1-d813-4b3f-ab07-08d9bbd829cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:25:34.3286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZw9Rf7SzZKgSRrLr0D+3LyTPtgfovbJShOKdVQ3Ts01fpTRb3sJ4rkWQx/CazaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
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
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, leo.liu@amd.com,
 evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/10/2021 5:11 PM, chen gong wrote:
> Play a video on the raven (or PCO, raven2) platform, and then do the S3
> test. When resume, the following error will be reported:
> 
> amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
> vcn_dec test failed (-110)
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
> <vcn_v1_0> failed -110
> amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
> PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110
> 
> [why]
> When playing the video: The power state flag of the vcn block is set to
> POWER_STATE_ON.
> 
> When doing suspend: There is no change to the power state flag of the
> vcn block, it is still POWER_STATE_ON.
> 
> When doing resume: Need to open the power gate of the vcn block and set
> the power state flag of the VCN block to POWER_STATE_ON.
> But at this time, the power state flag of the vcn block is already
> POWER_STATE_ON. The power status flag check in the "8f2cdef drm/amd/pm:
> avoid duplicate powergate/ungate setting" patch will return the
> amdgpu_dpm_set_powergating_by_smu function directly.
> As a result, the gate of the power was not opened, causing the
> subsequent ring test to fail.
> 
> [how]
> In the suspend function of the vcn block, explicitly change the power
> state flag of the vcn block to POWER_STATE_OFF.
> 
> Signed-off-by: chen gong <curry.gong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index d54d720..d73676b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
>   {
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	bool cancel_success;
> +
> +	cancel_success = cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	if (cancel_success) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_uvd(adev, false);
> +	}
>   

Probably this is a common issue. Can you try moving this to 
amdgpu_vcn_suspend?

if (adev->pm.dpm_enabled)
    amdgpu_device_ip_set_powergating_state(adev, 
AMD_IP_BLOCK_TYPE_VCN,AMD_PG_STATE_GATE);

Call this after cancel_delayed_work_sync. Shouldn't have any effect if 
idle work already put it in PG state. Evan, what do you think?

Thanks,
Lijo

>   	r = vcn_v1_0_hw_fini(adev);
>   	if (r)
> 
