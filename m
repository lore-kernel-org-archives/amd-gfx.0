Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F34C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 05:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0452710E6AF;
	Thu, 30 Nov 2023 05:12:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CC910E6AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 05:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nqa6mi71+t0QNUca8J7ldaCuuWwjvej+Pp+oKFZEXpQtERPDQQeg6p/+7SPkkRNMYvyzhvMDdjIceLhM/p3+mjla26heE7oXzRSlbtj6AMea3G2ubBpNNpc3QgWZ8DZbR1PbcaLtj/HfkOalJP4UiBIophWVms7cv7fOB+yI8ATiE+MSHHdSejN0JZbtMORBE3ZqnWeHhkdHwy63Yew89rqdrT/jhVdaUfXUPxJkG0Szm7lBa1qZm7T/ZW0XSv59lnRJFti7QX79bFCMMv2tnxGzgo6R4NZEYRO81NyzfPmDl3xpR4aUtfQGyPjoBhXYEz9nA4lV6JWwiNftH0/F7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo4m8RGiF98oZNskVbEt7IynjFdENOU036675UCrAek=;
 b=KkfJ+stlAo452Ms6O1LK0feRKqoUapkVyeGRaU4buZhbeaTt11g2Qd3VNA0+5PAEv9Y6MelMorFY5utRhm0zPZv29TkdGPJmq8dLgZyJqestrpC/uS7Ii5CsUifOp5lq1eBlLocCsRuPH12sB8eqj8BYPWkWKrg8fBbIF1DzXenHdvmk6u/zOOL/ZNsxCGolVWhrL1HVNodCZkfMsV42zXSTG4Cv5IoZryKjpe2fInOuDWx5vEjuhVua7yU2IxQ/u2T3kJHzUSXWplZSrOqaM4GmBXIltUmldMBvpep/g0qoE3YsQrICVTs3eVtkT8GTax+ZbSApilG/vHGxYphLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo4m8RGiF98oZNskVbEt7IynjFdENOU036675UCrAek=;
 b=cMeL1vvYufbRnmqWpu74+d6MPoa+z+yYwoBEVE/RjAarAMSlrTucFILhnSUh4kl5to16xfhjaXwjMluWk5XXRzwC+7cd84JiMKVHRJfywbvflX9MMsJMRO9w969q266ZE9iid80icPE7zBBriX+ZGhvlbDFEEaW2tPXqJSaNZnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 05:12:47 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 05:12:47 +0000
Message-ID: <48f4d0e7-a15d-4062-a363-43c54fcd9551@amd.com>
Date: Thu, 30 Nov 2023 10:42:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix miss to create mca debugfs node issue
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231130050919.1283614-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231130050919.1283614-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::28) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 33261dd2-8345-4bfe-8d14-08dbf162fd9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DP24ItfQH3bWotGOHSAsr5OpX2vKYobxInNgI+4tcggRmtTsJPoX6EXb8VVSRG4PQBNn8hF0/0ttAoBJFPxU5B2+0ebaKmvBVklH/Y8KFA13vWFWo99Ou1V18IgBugPhGz34ccmW566fJ6vw5xyNLJxc/8jG61QMdjMNCYgYEs3IKfZOWfNHeH9iqLF0jIJ9kKl936SDMGmQAk9VxwxDk800IfKVUJ2bVvXkaULqXQSpnpw+9+Y7Sppe1TWsva1/dUe8IneZ1cyhZ93sv0n7iG6wEEyxNobcHekR6NfAx74Pgm6qTFJ90CxkOLCRuHRIBpMLrK02zwvJiM4eHIwyzYpFqWAMRVkf3ueGdgeDxpdzUpmR8pc4v2kfuACKTIVWxI7uE+wm0RVNnMDABh0mGY0GRVCT7sR7vIhpncguHQmRSk8pqRPh6u2hdE3CcpffriTz4Ukk7x8dvz/oDLK+uq5CE8ZUQd5RcrFHjRvmQzwRqRYVTkZplNiXxW5dHfLHBfkAr81fMrd9RPfeNAl1ZPjMOzBYMP+rkis1gJ7pJ3y51xfVjEaTQGHlMuCRJcnk+5hM+Lxkhgd5SZqkVBU91q60x+Qb/wGeySI6o8Tn7ybnLVMNbTwgRON3t+EAbBUUJNVqN43wcT4FwdfLdUNsNuM3shxoXw2RbX9T5C7OiMk7q241OHoAPat/4MsBK4FZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(83380400001)(6506007)(53546011)(6666004)(2616005)(6512007)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(202311291699003)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdRVjlkbWZtNlQrZGYxbmV4eEErS3AzclVJbEV1UFFQbzdRUm4vWlIxVWdF?=
 =?utf-8?B?QjlrTjlyekh3dkI1N2lPQTlPTHpwVVl3S2lvYlFKL2NCVXBHNjJKc1l0SHEv?=
 =?utf-8?B?cG1UQ0w4azV1NVhPcGpmK3lENVRlVTI5dkdVT1FRa01UNzVkczUzd092RzVJ?=
 =?utf-8?B?dHlMVytqcE5UUlhMQjZjVlg4QzVOc3FDMVJuYXRUdVNXL0N1WjRpSjJRYmdR?=
 =?utf-8?B?Tjl0VElhMms5WTA4T000WHMvQXZYV250dlNDWGZ4Q20xellBL1BsdHE1Tldz?=
 =?utf-8?B?anFvY3R1N0d0Y1JjL1R6UDd5cjRVK3htTEFxc2lNcjhiQjNLYnpsWmIwN2la?=
 =?utf-8?B?RFV1SW1EUmlCUkVpNDl6MGpUa3VCWDNTaVpzY3ZmQjBnbTdzM29wTFREZXlx?=
 =?utf-8?B?VmhoSUJnTUZONFNCcFZKazBVTkdJNFkvZVhucHhwa2F3VnBYRHdscU5mZFdZ?=
 =?utf-8?B?MStnL0ZyMmFvVXdaUDBsYzQvdXg3TjRKcEhNQ05zWWhsUFR2UXR1dlZVS1RE?=
 =?utf-8?B?Q3VKRitnWGNzMTBYZitBSDNFcjFONDBjRjUxd0U4eDVrZlVTaC91ZWtiQlZm?=
 =?utf-8?B?NGVyWkZ0ZDhJVzgxelBxUFVpRGdSTWl2KzdsSXZWalpxTS9WK1AvUG1FamVh?=
 =?utf-8?B?NHFhemFsdlc5SW1RbUFwbngrd2UwMkxlZ2FTNlZWQ2llMTE1U2d5NGIyUEhI?=
 =?utf-8?B?eXJ0TERXZVJDRExIcGpZdk5hOWZMM0xpWGcvcVRia29Ib1l0cVNCOTBsM0hP?=
 =?utf-8?B?STlzblg3bityLzZHd1d6RjBpaVpLeDRJUDVMOGN1WVZ4NzU2c0JnbXV4K2Rt?=
 =?utf-8?B?TnYyVkxQRy94OFltZDlzbjFLT0EvNzRyZHNSKzIzck9IZXJRZnQ0TDNFQm1G?=
 =?utf-8?B?MElwUm9YUzJad2Z0RjRDc05VMk9CSVEzL0tIY0dDQjNQRFJDUmRFTkVHZlND?=
 =?utf-8?B?YmdqT2RyM242NXduS3FRTm9zUHlNdmZwSkYzK1hTNTEyUmZCYzlSZEduL1VP?=
 =?utf-8?B?L3VLcFp4MDYxRXlRMGtSMWI5ZnF3dGRON3NrNm5sQW1HSXI5UDZ1UnQvSVcx?=
 =?utf-8?B?dm9JWFRUc1FPTFBrYUxkWERDMUtuV1pleWUzV1hTQjMxMzRLbU4xN0p2YUhD?=
 =?utf-8?B?bURCMHJlUmVDOE53QVJSQkZHM2tVNzJzQ2dkVzcxVXB0dG1UdjBGbEliTDhj?=
 =?utf-8?B?NEFLYnZmMHJQYkp4b3NyRUVIL3dTV2ZIR3dqRWpKeFl3cHdGejFuYlE4YjY2?=
 =?utf-8?B?N1JIQlNiRHVRQ2VldUM1aUUrckdGY0plaGJKQmN6Tzd0OUhmTFAzc01yNWYv?=
 =?utf-8?B?TmFJWGlGVDRzamNPRktuL0x6RnZrWUwvYnFlU3d4ZmIyZDdYcFFtenJiajRp?=
 =?utf-8?B?NThJRmFpdk9PTHRiak1OajZsWVNyY3BFcXdBTUhERlplR1BwT1A4RGFrTFJY?=
 =?utf-8?B?bGFRN1BHSS9aU2Ird1YyTnJGdUptcGJPRStONHNUUzhtZHlDaHV3RnpwTnVD?=
 =?utf-8?B?OVFSRy9rYjVqbGNoZFloZ0lxWi8yaklRRzMvQkdLdklFK25vTlFNV212ejFC?=
 =?utf-8?B?c2RPdmdFbGVhUWdzeUJRQmdYOWlKNHNiSXpMMzlZaUQzaGVZSjJ4cnFhTEhl?=
 =?utf-8?B?eDdQN2VLWTdmWVFsUUpsNTR6dnRjMXRKWmgwanlJQmhpdHpCSDAzTlZabFBH?=
 =?utf-8?B?Yk9EL1BQTkdtM011NDVXUEl2amVEZHNjZVo5LzBmUmlJZStIdWJjTW83aUJI?=
 =?utf-8?B?MXRQM05UWEN5VmFpa1N5V29qdXdlQ1ZoeDVDQ0NhNGNvdE5WU2lMSms2Qldl?=
 =?utf-8?B?SUV3bHBHTlFkRmRPT3pEcmdPRUkzdHJHWFVPMzhWSURzY0d0eFdtMUQ2T1FB?=
 =?utf-8?B?dmFaRGlnek9NcENUWjV6dVl4aHpmc2pBdEVtNTZIamU2YU1IN056MGEzczNw?=
 =?utf-8?B?WHhXd3RFRHV5MzBETzQyNHlJYW9HQ2Fid2s5a08xL1JjSjRZYVlpYkxHVDB0?=
 =?utf-8?B?U0N1d0pOZmFhb1ZNbHRIaUJ1SHlrK0ttUGhLcEQ5dThaM01VeW1mT1ZkYVl4?=
 =?utf-8?B?Ukc1TWIyY0xJMGY4WmRDSENUc2d5QitQcmFYQ3JUUEsyRjY0c0FCR2pLcnhY?=
 =?utf-8?Q?OatFMx54Rkkqaxn050aHcM6zd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33261dd2-8345-4bfe-8d14-08dbf162fd9d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:12:47.0708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9n7ajweLGIcEJ7MMir6Uix168wkSq7+icMLMcuYtG91OdlDw44asHoNgf2J/KCO3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/30/2023 10:39 AM, Yang Wang wrote:
> Use amdgpu_ip_version() helper function to check ip version.
> 
> The ip verison contains other information,
> use the helper function to avoid reading wrong value.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

May refine the subject to "Fix missing mca debugfs node"

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index 54f2f346579e..210aea590a52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -485,7 +485,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(mca_debug_mode_fops, NULL, amdgpu_mca_smu_debug_mode_se
>   void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -	if (!root || adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 6))
> +	if (!root || amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6))
>   		return;
>   
>   	debugfs_create_file("mca_debug_mode", 0200, root, adev, &mca_debug_mode_fops);
