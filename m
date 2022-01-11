Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E78C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 11:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B1610F692;
	Tue, 11 Jan 2022 11:07:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA52D10F692
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 11:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn/LvtCPIzC7mMjR+a1Biie5SNoYEco0/Ry4i9wmOUnki0y32/mC8v5BgX5NU3IGbfN7ZD/sLhFcM8HqQw264TXraKERqAUYnAWroElS6mh5HVmPSExPGGbahuOEe8HsrBZu5yBYAu7igbpHIDzBBucTalTW0BQTiXQfBH5yzZ825+pvRVU/P2YQxSFT8qdh0LvD4WVFil4AuJ213ci8CLAEsfMF9UMQpIy75vKwPq8ixP3vF2mJ+cQeublvdCjxivroQt2ksiux6u6nN13LZt5x0dQSblymvY/wOsHj9clCOj/Ns97UNCQ/BaqHcTbJR1CC5RQjlNVckGdC0wIcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRtAMXnzRjFAtKaPthAngjU6FtVbZdvtPC5aAtuil4Y=;
 b=g7xzv9dM0Xq4I1NZrDY300FKcYpteVLsih+FY4/sVb7K9nFpIFl1LdCmpgJKgS9HnOk+T2BGp0im+Dm/+MxAMzltdlO8P5CadEdQ6lgfHit2ZYun+uBI1jHLRx7Jftm7q36bLqHaCm3pF7zTVs2C0eoMAiQaPaMmZq43p3wd5G12kygiRVu9J2chaPNQ+jrJ1ZLvjJ9mb+8pL3+7+hsazMHzMyfGUMjUnKG+nHza8/oznYGnzZh5LVeA8YAgfOCEvX5EkaImD9szSpME7NEpNRFcq5TLmKlKVSEK5LaQ07YWBbsSaJ9Ztlc1ilCHMLqxqX9i+x2SAB+j/9Lan6pidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRtAMXnzRjFAtKaPthAngjU6FtVbZdvtPC5aAtuil4Y=;
 b=Hlaw7CrbLTWdeXA0fimfShfDAg4sYWBXzotoJh9DRKLY6j194BGHqao2PmY5RGpIqd2zhPtsWszdiFdfJshUGtAXngzznsx4F6Z64fVsFUKE4cdMv1Am2Ub2s4r4U9TPZLJ8KDjH9omuQy2eJtUy/VkUm4HALaHKGC7aaykU8rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0077.namprd12.prod.outlook.com
 (2603:10b6:301:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 11:07:06 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 11:07:06 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: add debug fs for AMD GPU reset register
 dumps
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220111071150.5551-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <100ddcd7-6e66-0330-fa27-ba35b9d1305a@amd.com>
Date: Tue, 11 Jan 2022 12:06:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220111071150.5551-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0202.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::32) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5e3d32-bf87-4e69-a75a-08d9d4f28146
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0077:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0077FCAC32426B111FC7444283519@MWHPR1201MB0077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDhMbCqS+Na1CMXqSsklgD9vFOdqNOm43v3MEhOYlrC1b2dqqhDRGovyuZXE9ZhP/fF5a/kmjatrlCQ43T9qY+10sezmMm7DkgpMSWkL9E7Z6iPN6lQtlLs4Nr2DsUNL96dqjrAcaZHOU6xeSfz3DVFLripEiMIBNY67qZklm08Xbr9Q6dCnxpCBqIQ1UTYAH+Yp6VJSnn9k5WftSOnxbKRfS4as6C34ePFLIBAootHoeZhjEAr5UDJzNGiznb8zDycaaAlaeINoZwC2eBDmrDgEAS+Nig5B3DfSYyU0t1z3sgLXqQxvVAKLLRjPQ51WLWqFcmfXoCli2mo0ToRviS0F9pO1j5krIFaj6WYSO4qRlnbZuvW+7pljxTvKBCygaGFlzBOss2WGOK1Hqqx0FjJt+o7D08IJcqYDbLFCE9OYDyDc8FaYifNPx34C7+D34wlcV4jEyeHrM4GG7aQS8TFiJQlhy9na57YRVs/i3NrxOeZptxvB0AwDdWGZg1P0OMNr9nNa0uLQCHyN0RxNjsvWn1KB/zd3pG41FNsMkNni/p9zrz+lh1oZg+B2gEGXu29i++cBwKXFsko45vsoJWHdVs1RUsKb3Kyge+K6L5xFU4f/ChbyzfwhJNjsfoiow04iedPPneVW9LZrM+Z+OwgQZUuViPqKFZaMSnvpDDGtZWcfWhVh5DaKsE/GW2AoHh7GKLNc/14QxfeLvJ++6kIvTjwJl1PoFdxiWILeBbymQ/fKbttkNUMmHEie9ErW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(26005)(5660300002)(86362001)(66556008)(66946007)(66476007)(316002)(6666004)(4326008)(6512007)(31696002)(6486002)(508600001)(38100700002)(186003)(8936002)(8676002)(6506007)(31686004)(2616005)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFpTWGEzQnpZSXhJdE9hT21GTjUxSi9aTTdCWFMwNGdzTElqWkZISkE0R1FM?=
 =?utf-8?B?MVF0MkpaNVJtWlBvclBmOGNuWW9BSkdPd3FmTVdKeGthQ1prV1pUcU80WDZq?=
 =?utf-8?B?dlhLT056YzRRK3dIRWtXZHpZQmxQNTBJalRnVDZudSsvMi9qbFpaMTRZSFJK?=
 =?utf-8?B?YjR6V3R3K1I1UnVHUHpVYlI2bHVqcmM0aGNaZ3Rla21UakVJWVE1TjJ5OFpY?=
 =?utf-8?B?NkYyd1JhOVd3dUx0NTNaQytCRGtqSm9hOGcwem1FODZTSlFRODhCWC9VNW1P?=
 =?utf-8?B?Z3dJeERmRXZzb2VlVnUzS2RyUmZEbkVyWkxPT0U4cmlJbldZaXJHMVVlUXhx?=
 =?utf-8?B?dzFWdkQ5V1JlYndjU1FxZi9oekRvUHZ5ODY0a0xGWm1VZFFSOWlHSWx4bGRZ?=
 =?utf-8?B?SDVRTGszazJHOU90OUl1UnFSQjRub1ZqUnZjV0xWN2VVQXZsUjJOYUFLN3pP?=
 =?utf-8?B?eFkxQUIyQ2puR1NhaXQ2WnBqSzVDUVRHM2hDWDBhcW8rTWtsZWt4RmRsNW5R?=
 =?utf-8?B?Umk3ZEp2Mm85V1JiSTFRaXE0K0FZSmhIOW44aHA4NlJRSVJZOGoveFphaE9l?=
 =?utf-8?B?djg5cURkdmZ4TEt6U0xrekhGWDVNbW5DbTFYdU5kLzJKTUFjditwVzRyYkw5?=
 =?utf-8?B?QmgyTHRwTnhlMXRBekpDTWxwMlpxUDZxV0VEd0dBaUtTa1V0Z3g4NDFONnA5?=
 =?utf-8?B?T3NUbno4NHVyV0FzZVlNdi9ZWFdLZ1JiOFU4VE5ueFFITG9oR3NuOTJwS3JN?=
 =?utf-8?B?Q2x0dFZXakJLZzdWZktPdjJCQTNOMkk4TFZWVWpsQ0xtRGlVMG15SFlxTklG?=
 =?utf-8?B?Vk5WN1pYZW1ZR1VqZnZyRlVhNlRGd2JBRnI0YlBpNWZsNHFGeXdWSE1DdnJo?=
 =?utf-8?B?WnpGTXo3Zk1YTGdhbUxqdGVDVWdIRHVOT0dwTDloRXZnTC8xYkhndXpCT3hh?=
 =?utf-8?B?ZkF0TGpUZGQ3azZnNVJCMm4rTldqMnRxUjA4ZVQyQUxYSmVEVy9tZFpDalFh?=
 =?utf-8?B?dUxrbXBZdm1iUTA5QmdsRXJmWFBVMG5xTnd1MGhOandLZy9TUzN6NEg4NzRa?=
 =?utf-8?B?b1dsYmtZTzA3NWpvaVZhcVVkU2pXNlF1TVZLTmFuTTNENUNMb2t2dEF3SVRV?=
 =?utf-8?B?cHJjZW1BbFFLV3g2UWx0SUZxbWNNTXVhaWM4aVhWd2ZraEJ2TGpEYmFjN2xs?=
 =?utf-8?B?L1BRMFJDcGNzamF4M2w0aFRTRFN4M0xXM0V6Y2UrdnFFSjB6SGRUU21nekhu?=
 =?utf-8?B?NWFWUUFmeUxCSVd3TnNIUzZWS1lWZDVkL3dJZStZYzExVW1TUzZGOHl2QVgw?=
 =?utf-8?B?RGt4c0tla3locGRPdVFZK05KWUo5VGdQVVp3dUpodkNJRER0Yk1ucEdVT0sx?=
 =?utf-8?B?cTJ5emNtYmc3Y3lvZlVPS1Z5QlpkTTNOTDFxQVBlZTQrTzMxa2tPWENNc0Fx?=
 =?utf-8?B?Z3BzalJQRjFBZlR5NXk1OUM0Mm5HNFIyMVlBTVN6SXVYK1ZGU3IySTR5U0tx?=
 =?utf-8?B?WWk4Z0t4REUwVE9GeFJRQmIyZmE2Z1BKOEdUVmlaVjJncHRTYzNYQkZrZXhQ?=
 =?utf-8?B?NFloVXlIN2pudDczSmF4QnRqKzQwTW9MVDhCalVlRVBvejJPeVhKeDBkV0dF?=
 =?utf-8?B?aWZBWFg3RmZJc2dnSWN4STB2Z1ExRUxVY0lvTU9YdmdMdW45VksxSCtGT0VR?=
 =?utf-8?B?RG5hWlM4RTVTMFFVWk05czEvNlkvMDZVcE1mcFNsZ2FwUlpsMzJYU2llRE54?=
 =?utf-8?B?MWkyN0Y5bkJtWDVFQUkwdVhTeHFFQnZLSytZWUJxcG43Qng4TnFPV2lCS2E2?=
 =?utf-8?B?RWVTOHgybTlNZVBucmdRTlJkaFJ1Q3QwUkQ4OVFVNFR4NVRFRXg2b0c3V3lr?=
 =?utf-8?B?dmJhNWdUQ3gwVW52bE5ObkY0U0JnSTlrSTZxN24rcGhYOGxYanppQjBscldD?=
 =?utf-8?B?V2QvTlB6dmdEeDJCWk1Na3VJY1JXb1RvTHNlOG80ci8xNHZsZG5lYzN1RkVy?=
 =?utf-8?B?V3R3RG9ieG1mOTFSRVBnR0Z1UkNwWVovS2g5dkZKTXQvb0NPSUFxc25ZZ3Jo?=
 =?utf-8?B?bkVGZ1VocnRTMWJYN1NRN3IvVW1hamlJM1RPZGJzMXo5S1VUbmlYcHl4U29u?=
 =?utf-8?Q?EHDA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5e3d32-bf87-4e69-a75a-08d9d4f28146
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 11:07:06.7263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/oHftkDJHKSvxCkY2jkZrprxW3lJkyR7TwRKh6BZF4kTJL71iZuYEtMHgwe5U2c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0077
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.01.22 um 08:11 schrieb Somalapuram Amaranath:
> Implementation of debug fs “amdgpu_reset_reg_dumps”
> to capture reset register status
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 64 +++++++++++++++++++++
>   1 file changed, 64 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..c56d7b451aea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,68 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static DECLARE_RWSEM(reset_reg_dumps);

Please never use a static lock like this. That would belong into the 
adev structure, but on the other hand I don't see any need for it.

Regards,
Christian.

> +
> +static void seq_reg_dump(struct seq_file *m,
> +			 uint32_t (*dump)[2], uint32_t n_regs, char **names)
> +{
> +	uint32_t i, count;
> +
> +	for (i = 0, count = 0; i < n_regs; i++) {
> +		if (count == 0 ||
> +		    dump[i-1][0] + sizeof(uint32_t) != dump[i][0]) {
> +			seq_printf(m, "%s%s:	%08x: %08x",
> +				   i ? "\n" : "", names[i],
> +				   dump[i][0], dump[i][1]);
> +			count = 7;
> +		} else {
> +			seq_printf(m, " %08x", dump[i][1]);
> +			count--;
> +		}
> +	}
> +
> +	seq_puts(m, "\n");
> +}
> +
> +int amdgpu_debugfs_reset_reg_dumps_show(struct seq_file *m, void *unused)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	uint32_t (*dump)[2], n_regs = 0;
> +	int r = 0, i;
> +	char **reg_names;
> +
> +	down_read(&reset_reg_dumps);
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
> +			continue;
> +		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(
> +				adev, &dump, &n_regs, &reg_names);
> +
> +		if (r)
> +			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
> +				  adev->ip_blocks[i].version->funcs->name, r);
> +
> +		if (!r) {
> +			seq_reg_dump(m, dump, n_regs, reg_names);
> +			kfree(dump);
> +		}
> +	}
> +
> +	up_read(&reset_reg_dumps);
> +
> +	for (i = 0; i < n_regs; i++)
> +		kfree(reg_names[i]);
> +
> +	kfree(reg_names);
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_reset_reg_dumps);
> +
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -1672,6 +1734,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_reg_dumps", S_IFREG | 0444, root,
> +			    adev, &amdgpu_debugfs_reset_reg_dumps_fops);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

