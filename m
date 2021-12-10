Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F04BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 11:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E50E10E35D;
	Fri, 10 Dec 2021 11:02:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2808610E35D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 11:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOQBGNHP06duVwId8xAf/LehCeV3Fq1FFjDXOplA08SnSp5e3eMYQNS0A3bDc8/X99BImd4s/W+u0by3EaoYUC/eG5iYcp8FjzaNElzvfnEN+ODtciqdRpPkTWUewsOlG/6Q67Kw2WvwvWwQ0TKLy5KvEbJm4ZDz9zFGOL5MElhR76ulyEJSafbJwPZBmrov+axwJFgbmkTQWYpdTB7bWewDMhkywg73DLa5YL1pvladnvKHOXNDB8q86AzUxfCNrAO0Id6+tEBny1oIsfJeYLXFE1SDUkx8yO64QnD0OW1rxWHkmy56CTGRQp2FMXAfq5egU6ukVN5tWV7M1zH5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsldmMO4aH3q1Ba1QL6yQbU5sAmkXZwDZ9AuCo2Gd4A=;
 b=m8JH3uoW7UyY3aMlPZNsHorEy7JI/oDqckQx0zfvCgzITWgNkpacRxA1aqIBoJr9lLAJZB04SSEFpucpzxyEX6VKHwjJLEDv96FEBFsbOni5Zqzor3LV3MaP+sKObXECW7C2MQWj/flsqwEGjtyI61PQ2F5lHQ3Z/D8ox5mOG6i9fgmbcCQHNdP92KCdaOTOJzrhgxYF+eY/N0lC3xhItiqr+uMqvaVRHmb5+yREqOHVxIYmWojU9oS+nYDOOlcp2RO9tYBpXRCe84Gcp+xDdbf/FA8Uuxhodni6kkl26Z/XayxJqH8LbO+YX1RMgBFEhAS8diFStHD4SZD/OpiKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsldmMO4aH3q1Ba1QL6yQbU5sAmkXZwDZ9AuCo2Gd4A=;
 b=t2WSy9kfawt0WCQPQ/vmUibLhUF3Fgjif2aqCJtH6aMhwuqvDVlnUaidu69YfNZBO65PCaaMuwvE2uGOellwqw0NWrZM1uxaW9C3zWIVCyiWu9qmelKqNimLWAFAmbhssGcFJplcC4EQMbftMaa8LYg7aI1aLB69ydy2ECm30H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Fri, 10 Dec
 2021 11:02:15 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 11:02:15 +0000
Message-ID: <5b6194fe-c449-f268-95bb-fb773789e0c6@amd.com>
Date: Fri, 10 Dec 2021 16:32:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5] drm/amdgpu: add support for SMU debug option
Content-Language: en-US
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211210093817.144285-1-lang.yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211210093817.144285-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0116.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::32)
 To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c58716f7-f426-4df9-ef7e-08d9bbcc8611
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3403E59D79C409A9ECE3946A97719@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vxNIS/GxJDhvYWJGjMPDeY21Rm73ql9mL2tKoDUCF57UBfBZrNnGZFovC0iQC7N1tKCMOa3CXyTiSRYsfSeBU0YEpPYNuU258F7jHOmd6LNmgOFIbCVZtrWk66OoEM8sb/DEyacOrSXxUUE+equE/LT20/HLMBxN28bbvy3cYK1OdKsYU59x2l2xmal9acTeWdBAmjn1UZOcvd7dImDpsOmBK2MqX6lEC6CDAstECr8dTWt0ALwDvKFEDsP2DkpXIJisoSlqtRfZx8+IfaGLh4cHaguzH9v4scTOcqt8bE7w/sMr0WmJfS8UbEPFuJ3Zlw9WfLFXIjvNDcsHuSlVLHPZ7Yd2PdF0h4NamtX8dzDlnbwFWMRisLfJrW45FkihA9vyldScd9wGh1aLzh3sJTqdvrA5MumDt3DuUiiIbsH+BSzZ1cFJJ00LZs8yo9tHN2lTgb+vDob0T2scW26oex3BeZ1qbIINFdA3smwflo4dITUlNkTVRgri4IwXgpq7lsaR/JJuIWL0gexoRRmVucR8anm9CtzgOi5xpCODO1s5jjerrNqSAwB4lkJ1uFX6syem2UxLYN1V7zqwN7gwjSXOSBT+VdmmIvemCXDDiaM05AzGQgQeL8LVhHtrAnI66Z8sXHE5/hbq4lgU65PnzJysJPMXYEqS8i7QbonvbsE37UbQvD6eUUU6+NIYMaIehPIE44x67r91JllOvM90lZtZlVEWge/IxKw0Z1yUMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66476007)(6666004)(66556008)(8676002)(83380400001)(2616005)(4326008)(38100700002)(508600001)(26005)(5660300002)(6486002)(53546011)(6506007)(31696002)(186003)(2906002)(36756003)(316002)(31686004)(54906003)(86362001)(6512007)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnZWZGw2YjhwdHJUT1kwQS9sNXpWRkdFaCtrdTF3NTA4NlZleVRKV3YybStk?=
 =?utf-8?B?UUJ4bGpoMEN4QkNrazlpbTU2Y2ErT3FHRU8vc3VYY29QUG1RTDRnRnorTTZO?=
 =?utf-8?B?eGk4Y2NHZ3FSRStRemFIQTk1TmxQZm9EQlNlM1dCVFozc0hmK21WVGRZZW0x?=
 =?utf-8?B?WHo4S20vOW4raGZJZnQ4N2dOejU4elR3WmdPVE1kdEJGaDNFMVkyVjdZVnBP?=
 =?utf-8?B?b1NibTFJaUpRYkVJOTVpc0tIZDZMUnE1NFJ6aVVLVEJaRHRhVjdXV2Y5U1Y4?=
 =?utf-8?B?cHRzSWpDRGxhMGtSQzN3RWwvZEUyRjgyUWJxK3NNaEpTSVFtOHhsb0FEOC9o?=
 =?utf-8?B?WGxhSzU2MXYyem9lTWhwQ05TK2dxYXcrV09BVGdNVEc4NG9BUlBzbnVKandZ?=
 =?utf-8?B?eWtXV283eVQ1QVFzV1dGL2lIZEdnTGlMaGdxSDBOMkRvQzM0VlhMSmpVWmFa?=
 =?utf-8?B?LyszTEpGZVlQSkFTVDFMdDQ5RFk2MFdYN29TRDRuQ2ZYQU04WjNVanpBTVNy?=
 =?utf-8?B?TnRFenV2bmZCSTJtM1ZrVDVlbXBXSXNGQnJrbUFJZnVwOUdvdWxwMjBQVzRk?=
 =?utf-8?B?cjJFZ09BNnVKV01OTTRUSlIrVWlEVUljbzdSRHZvbGNkc3BWM2tNbzJabGNW?=
 =?utf-8?B?TWU4Q2NUV3pPUnNwRTkvd3ZsWmtXcGMzdXZVaEdLeDQ3VFZBL0ZuVmVobFdx?=
 =?utf-8?B?UGsxUm5mQ2p1MUlza2RlT2VGWUNwVzljZ2Z2SmFRS0JFVXA0Q002QmxrVmc4?=
 =?utf-8?B?SElFNFpiVHkzeXJkTEgzOHFoNE1Vd3VmaERDR0hNa3RmWmVTelhQNWdveUly?=
 =?utf-8?B?NmVSRlJKWk1VcmhkL1pWRm9SQjlPT1hpNVIwYXVSUWFEYWJnV1IxMCtBRTlt?=
 =?utf-8?B?bndRdGFjUUZLNEtpbDRaaDdENE9pbzY4NzQ1OC84TkdsVFVTY2xRS1Z2Ymd5?=
 =?utf-8?B?NVNjMXdMNkNlVmYvY3Ayb2JBcFNUUEJwYUVtUndxRVBvUldaNllIN2UwL1J5?=
 =?utf-8?B?UUdCc2MwclJWNEpHandubGFib0JJalRPeWxtMVM4RjJyQ1FnZzdKQ1ZhVVBB?=
 =?utf-8?B?YkE0OTF5cllpVGRDM1ZLTkh6bW1nZ1EyWld0MTBzWkhaWDBjdFV6amx2M3Bh?=
 =?utf-8?B?NVNMcWtjZWJoWW93MVpQL2NOaTludEtjT2lMMFI3aXAwdWQ3ZHVCa0ZiaDcr?=
 =?utf-8?B?TlpDcVhqQ2RHZTFHS3pmYnpIcGxpdGVzRWlLcWt6aDhlY0NvZGhpcHJTdVhF?=
 =?utf-8?B?cGlYVjA2cFA5VWZVTktjaDJUZlVWd0ZwcGZhRjZPQWljanFLWmF6UWNZTlRj?=
 =?utf-8?B?WHY1QmJJMFFvblI3d3ZiZ1RtdC9TaElBd216b1JZSW9OejdwT01heUpCMm1s?=
 =?utf-8?B?akxzWXVBUEMwaEhnQUd5WlZVcm1WVGcxL29scTFIaHpNRm9mZFBJdzRvQ3Fa?=
 =?utf-8?B?Zjk0RDk4VldvQkZiUFZJNXljN2hiZEs1QzgrSCtHcU93aVJ6NmYzd1Rsemtn?=
 =?utf-8?B?c3lwSXNFWm1kTEJMSEtzdVpLL1pBZk00VFl0RTdLNG5rVHhZdlUzSzRrRG50?=
 =?utf-8?B?MXl5Mnd3aS9pd2kwOHQwaE52MGNTM3R0SW9XclFMb2hIVlEzTjZqMUlxd05J?=
 =?utf-8?B?Tk9WbjFlbDU2MFh6WWFhSWwzR2hXVGEvV0tJUXNHWkRXZE0vOGRoMnF5N1R1?=
 =?utf-8?B?MmYzOWdHS0ZGRjlHbWc0RlorZHBmejJ4aW9KUkdtbEN0ZnNwcTl5SlU4QzU4?=
 =?utf-8?B?aXFJUlNxOEppaHhhd2JiczF5QXE2V3hWUG9pUTVSaDEvRGZZaXFoUjZ4OW0r?=
 =?utf-8?B?RFZtaWpRdUlWeDVFTms5QTdIMDFHMDNGaXpQcUlQT1RRQ0RVU2UrQlMrSXJt?=
 =?utf-8?B?RDlWeXlVVWpJeW5YVnVPbjBlWklwY3hQOHVidkZJUzNjTWtxSlFWTlpBYldY?=
 =?utf-8?B?T004T3JaT3JrR3ZxajJ1MTRRQ2UvakhCNmhTV3ZGTHpTZHRZdGUvemVpK1lS?=
 =?utf-8?B?VHNqbG9uNlI3UGpWaitpaTRZbk8wRUVRQllqM3BHVXlJZmcvUUoxMVlmNUVk?=
 =?utf-8?B?T09XUW0xZ3dVSWRydU1mUEVQbDVxVE9uTyt2UXQ1dVNPYnpCNSswYnRjakNk?=
 =?utf-8?Q?SBZI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58716f7-f426-4df9-ef7e-08d9bbcc8611
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:02:15.1567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VOduRQVjAGUQtUj8n6f5a3I/7mYrRfYrLSkE9d5IRjCWyFRPAFyR/Za9Y+yUl9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/10/2021 3:08 PM, Lang Yu wrote:
> SMU firmware expects the driver maintains error context
> and doesn't interact with SMU any more when SMU errors
> occurred. That will aid in debugging SMU firmware issues.
> 
> Add SMU debug option support for this request, it can be
> enabled or disabled via amdgpu_smu_debug debugfs file.
> Use a 32-bit mask to indicate corresponding debug mode.
> Currently, only one mode-SMU FW debug mode. When enabled,
> it brings hardware to a kind of halt state so that no one
> can touch it any more in the envent of SMU errors.
> 
> The dirver interacts with SMU via sending messages. And
> threre are three ways to sending messages to SMU in current
> implementation. Handle them respectively as following:
> 
> 1, smu_cmn_send_smc_msg_with_param() for normal timeout cases
> 
>    Halt on any error.
> 
> 2, smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
> for longer timeout cases
> 
>    Halt on errors apart from ETIME. Otherwise this way won't work.
>    Let the user handle ETIME error in such a case.
> 
> 3, smu_cmn_send_msg_without_waiting() for no waiting cases
> 
>    Halt on errors apart from ETIME. Otherwise second way won't work.
> 
> == Command Guide ==
> 
> 1, enable SMU FW debug
> 
>   # echo 0x1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> 
> 2, disable SMU FW debug
> 
>   # echo 0x0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> 
> v5:
>   - Use bit mask to allow more debug features.(Evan)
>   - Use WRAN() instead of BUG().(Evan)
> 
> v4:
>   - Set to halt state instead of a simple hang.(Christian)
> 
> v3:
>   - Use debugfs_create_bool().(Christian)
>   - Put variable into smu_context struct.
>   - Don't resend command when timeout.
> 
> v2:
>   - Resend command when timeout.(Lijo)
>   - Use debugfs file instead of module parameter.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 +++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  6 ++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 22 ++++++++++++++++++++-
>   3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..9dfccb20fedd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	if (!debugfs_initialized())
>   		return 0;
>   
> +	debugfs_create_x32("amdgpu_smu_debug", 0600, root,
> +			   &adev->smu.smu_debug_mask);
> +
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
>   	if (IS_ERR(ent)) {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..b24be7c8e2ef 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -569,6 +569,12 @@ struct smu_context
>   	struct smu_user_dpm_profile user_dpm_profile;
>   
>   	struct stb_context stb_context;
> +
> +	#define DEBUG_FW_MASK		0x1
> +	/*
> +	 * 0 = disabled (default), otherwise enable corresponding debug mode
> +	 */

Please define this outside the structure and better rename this option 
as SMU_DEBUG_HALT_ON_ERROR

With that changed
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	uint32_t smu_debug_mask;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 048ca1673863..0f807688ab52 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -272,6 +272,12 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   	__smu_cmn_send_msg(smu, msg_index, param);
>   	res = 0;
>   Out:
> +	if (unlikely(smu->smu_debug_mask & DEBUG_FW_MASK) &&
> +	    res && (res != -ETIME)) {
> +		amdgpu_device_halt(smu->adev);
> +		WARN_ON(1);
> +	}
> +
>   	return res;
>   }
>   
> @@ -288,9 +294,18 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   int smu_cmn_wait_for_response(struct smu_context *smu)
>   {
>   	u32 reg;
> +	int res;
>   
>   	reg = __smu_cmn_poll_stat(smu);
> -	return __smu_cmn_reg2errno(smu, reg);
> +	res = __smu_cmn_reg2errno(smu, reg);
> +
> +	if (unlikely(smu->smu_debug_mask & DEBUG_FW_MASK) &&
> +	    res && (res != -ETIME)) {
> +		amdgpu_device_halt(smu->adev);
> +		WARN_ON(1);
> +	}
> +
> +	return res;
>   }
>   
>   /**
> @@ -357,6 +372,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   	if (read_arg)
>   		smu_cmn_read_arg(smu, read_arg);
>   Out:
> +	if (unlikely(smu->smu_debug_mask & DEBUG_FW_MASK) && res) {
> +		amdgpu_device_halt(smu->adev);
> +		WARN_ON(1);
> +	}
> +
>   	mutex_unlock(&smu->message_lock);
>   	return res;
>   }
> 
