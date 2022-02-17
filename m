Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3970C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 15:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B4C10E470;
	Thu, 17 Feb 2022 15:06:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FA910E558
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 15:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0fRrQCeQJkL7u3GdRt+/0BLS7MgYzo/MBiRZMQeUQtouydm/Bey2BUstkaD/hLyi6xRomJ42QuH061P1BJH9WSM4OACK1tohgCBn4618ohFTNm5mMDCHNOne/+BRBrajp1275Z/Dn8Lcw4yBAAGVBh3hpdC4FncpuKUvExxD/Hiy5yHRLWsrxSgGQXzqzzzyp6AdRpsiYY83gms16IJNtgZy/IR8/FvHOhStCfwBjmJL7b2KFgmtTFnZexkk+TLkORXprtRpfzQ0gZXGA1tLSu4y6xOhyRbiUJDXyC9QeAFubGDhzRJSZzg45DdtulLDUAMa11SdfvqHT6a9FyZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7J2AJM4Uh2iq8S1BybyD8nLsRh5sMr1PkYzeIeNVdg=;
 b=THxwg3X/+7o64Ig70MntH3OiZoBt9Rc4jbLvnLFsZxGtB7mNfm0Eu6YPqruc/3rgDQRekTrFJ6JGlxERn6CTeWQOLvscrK8P2M5wWMraCq91nrIImdH4/6jAFRtswhTj13HOGVx8QAbLr+3o8qzJJTq3O7mI5ZuKRpQ9NYUnGHjBvX+NC/PVOu+dQGvSceYZ4lOy5q1CxBq872pJQpJp0AHczAO4ZXuJoatN32SKkUIkkePax+kyQ149n74rZeje1uEiJOeoEzdYnaKU2R2Ksnu36fZxORQJMIkYwl62rLxqK4bbuBQ2wMqW6bv/1/K7XaCKPjxrCFGp5LLudlEnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7J2AJM4Uh2iq8S1BybyD8nLsRh5sMr1PkYzeIeNVdg=;
 b=arhSf9ahtBVx7DtgUOl/QhPlvpjlVPcYGJ/TlBxb+6cQz3ZPG3FeYrGS2EbJ1Vrn51QkSfMkclK1WCsGxJi3/F1EwdDue3AH9bjeQcZGBe2YZOtDLwWhhRko/iCo1PfaHgv6SDar6T2Pb4oS0sJNYRVIpzvB7wFEqciOYK+zx20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW2PR12MB2346.namprd12.prod.outlook.com (2603:10b6:907:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 15:06:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.018; Thu, 17 Feb 2022
 15:06:29 +0000
Message-ID: <28251570-bd04-23ae-b199-e5e0f41db728@amd.com>
Date: Thu, 17 Feb 2022 16:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220217142918.3624-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220217142918.3624-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ac9c99-7729-4623-3ab3-08d9f227138e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2346:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2346B325A91C355BF244382483369@MW2PR12MB2346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MjwWi1Jp1JP9DGrGzktrbOSI0+5Z3BotZh5hIcS3Sh/xhAoVN1HevuCF2WkmTQn9VB3X/QbopT4Pxy7ASZBQ3zvlggJ7fiJOclG7vz3+09aeCslEyFdVoGc4ZMMDJ7z+UAE0g59dVnigR5ftyxAXOcgPRIYJm48/5SIRlyyT99bYiiHC2mnT1prQgmzae3YsQy0TDJsgc9U77bsQTi1Bf5GGBzojRZG7AzteqkTU0zenwcwEiBzjsAtQXZLwxnuvmaRW/IZk0VTKkr1HF6M++xE1ErRmhC3TF0byYEvJK3Gj+9bFVogLbWWzadYQNA3X9cKxNV0INTztalsPvp1uTO6qVD+ZRGvWzOSDyH4/hprQ3szb2gn2jWyK28DpNDLPM2Kfq3s8Pp66G+2W0gzwE165YjYt6Sv+zY5YbeO6xs5U3j63br9K6wfGx1DiI8mREH9gLt0/nA71Mf5dFu0z6BbhzesnA5c5BPrzg4Kx49b39mnsoJl9J0U8WyN7ZZovecsYJdc8xCzWDZBISRHneVqypGIgqyKKXXfkuBEgdHwrrJ8/wx2G7mtumVCYI5BkyfFUokCzRcMrO7jzjxLQU1YS3tQS7gPWW5cs68zz4/HZHqn1b5+GeQHV8WdJmy5bDrxjDJTcMoN2djM3iCW/87mfBKgtT9qiCpy8bsdF/OPBg5wlQO8un10WzMVZFw/ZX3IiEXU5Eb1jrEV4lQxtlcoOgFnXmcvh5mXdYaM5clc9nfUxGzl20NQ/5NfYSHV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(2906002)(186003)(2616005)(6666004)(83380400001)(66946007)(66556008)(66476007)(8676002)(4326008)(36756003)(86362001)(31686004)(31696002)(8936002)(316002)(38100700002)(6486002)(6512007)(508600001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmE1cWdOUG5MdlY4Q29aKy9XR3VqTk9VNXNiOHBNMHR3K1ZQS0RIREdOdTk5?=
 =?utf-8?B?bGNZT09zNy9tMldQKzFXNWZmME9RWGZoVXFLRDdESEhhWHVOVVVsT2NaaG01?=
 =?utf-8?B?SE1rMUtERCtrakYrVWpUN2ZVV3RLeG0wcXRlZUd2TkVPTWo0OUZnYXpnd0Ir?=
 =?utf-8?B?MTJXRHU3RzQwQ0Nod1o3VkFNSDZxS2FyZGx0YTBRVm5ocmFISDVucm5wdzRn?=
 =?utf-8?B?Z0pjVmhsQnJpNk9kS0NWc0xYaldoSWhOZk94TSs2RE1Sc3dOdDJOR3d4RHVT?=
 =?utf-8?B?TXNLL2RvQjhRczEzVkNNNzVGT2JwK1pWQWdHSFV5SFZvSE9FY200UzVoQ1pZ?=
 =?utf-8?B?RWtqUUhsbW42WVBpZkhZQUwrMHZhWXZ4ajl6eE1ZU2R0UTBQNVlMMXc1blQ0?=
 =?utf-8?B?U1hsbVl4V3JCOFBOVzA4alRWWEFCaFdTSnJ4NTVqV0dzc0V1c1JPcG1Gd1FM?=
 =?utf-8?B?eVh0SFVnb2tYNlQ2cmNxaExtK2RQRDBUS0ZqSVljclVaVm5mUzg1Z3liOHho?=
 =?utf-8?B?Nk5RQ21xRzlmUXZ1M1dLWHZnQWxoU2E0VUNUaUNXMUZZdHorTnYvVEJQVjBH?=
 =?utf-8?B?VGt4UzgwampvNHlYU2xZOGVnV3NaYkQ0dmFXWHA2V2lPeXVDVS80Y1o5OUZC?=
 =?utf-8?B?VGZaT2ZCMndsUDFSYXE1ejZXbTB2MHJ3UW9jQmVNTDRXWDRPZ1Z0TmM5U0Fu?=
 =?utf-8?B?S00zR1Q5bFBJU2RvSVFnRjlGZlBFbGh1RVNoT281amNKeERZT21SbFhqTWIv?=
 =?utf-8?B?SS9YRnJRUWhDamozZDNsQTBWcVRtNUgxZUk0UVlrNVJZTUp1Q2UveGRiN1pN?=
 =?utf-8?B?ZEU1TGlLNlBGOVZtTW56cXFjbWNZblhyWkFmQkE2aXNhMU5WUUhNSEczSXBY?=
 =?utf-8?B?Tys1MWwxbFYwZDByck42VEFyaHFWWVBaa1Q0TTlQZWFPeDB4M3JEQW01VW41?=
 =?utf-8?B?aTdDTS9CTUlyOTBMbjVrdVI4RlRYbXN0SURDRUZ6RTVVcjVkRzhOMnJwQU0r?=
 =?utf-8?B?OWdFUGpjTUlpUXVqdEl6cGVZVUdaUWRzS0hUOUs0eFBTUS9DT1lKaUNzZ1Vr?=
 =?utf-8?B?WTFPVjA2Z20rRFlsZXp2L3l4bXlPS2FqZnl5bkRwblNrMXpwQWhFVUp4WDY5?=
 =?utf-8?B?cHI3OW1ncm9ib3VvRDA0ZndmOGs5M1BhNVlxdVRQaU5EWUZSVE9zVFYxWnVQ?=
 =?utf-8?B?TFhpZkN4SWd3ZEdIckhqR2thOXN6VkQrTU1UNjB5Z21FRlUreHVBTkw5RWVQ?=
 =?utf-8?B?ZXAxaHNTMmI4dTAzeDNrSXNsM1VKTVMzQzYwV1lEK01YUEpnWTdCUFhjeW1P?=
 =?utf-8?B?a2RvdHphdzR2YjRwcEdEcW1qeEVRNGhpbGRycDlaSGJaVTNxVUhmcW5kVDBJ?=
 =?utf-8?B?Q3REek9jS3RXV2lEejg1b1h6NngwUE5PWkRmQWQ3MW9TNWEyRGFKVzFSUmM3?=
 =?utf-8?B?UHRUbm81UEg1ZEtVQU9nYVFFNVkrMXlOTmhYdG1xZ2k4bGdMQmhsV3lnWStU?=
 =?utf-8?B?RC9OcDFWZ050UytXL200OTNkRkR3aE5iaVoyaWlya1VZcVZsMWhFUmlKN2dk?=
 =?utf-8?B?cWo3RU1FQUkzd25hT1ZYNnBoc050cDAwODh6UnFBenZ4V1JqcVF2ZTVjY3B1?=
 =?utf-8?B?UUtuaE9sS0JscE8zemVXVHkvSVZJSFpHTzg0VDdORWFaMk81TGxleWVjZWtu?=
 =?utf-8?B?Z0lrcGljWDlaQmwyMXJLOWd4dnBacjJ0THYyeHdVZ25KeW9tbVRoeWNqeTVn?=
 =?utf-8?B?ZzBTUFZhbTFWV21IZ2R5NGIxRmZmNmFNQ241RDVlbWlEQmViWXdacUtHSUZy?=
 =?utf-8?B?V0lzMXFhZVp6ZlFUU1lzcDBEc0JtbjJUdHVuNDNKalBvVXNsWnlGa25JWlJU?=
 =?utf-8?B?VUhZNkF6QjIwbHczYTF4ZlV2SDNVWisrbk9Bck1QYWRnV0thRmprQW80UlFw?=
 =?utf-8?B?TDFCdHFGRDk4OTNxNzRDSlpvV3VHZFVnakZ6UW1zUDBKYS9udmxvVm1GeVBs?=
 =?utf-8?B?UGRydXRoUnJYamorekZ2eHlRcHQwS1MwOGFScmhEdkJiLzFZd2R6M0hoVHQ1?=
 =?utf-8?B?dlRYV0RlcDgwb0p5UzZFZ3czOWJGVHN2dnFpUVZVUDgrSzEwMjBzVEF5bE95?=
 =?utf-8?B?bEFHMm1FTDdFYkNSSHFNSXRMa3JQblpzWGFiTythNUVabm0xZXB6Q2FiVm92?=
 =?utf-8?Q?/jAiOIIVYkgAOuFKmUrDKVc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac9c99-7729-4623-3ab3-08d9f227138e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 15:06:29.7714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ixlDaekVnAFvxZgSkIo8wstpFb+O3YZwBaN4QaMte84Oh+/SYll+njSNUdVbx5C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2346
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.02.22 um 15:29 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 112 ++++++++++++++++++++
>   2 files changed, 116 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..6e35f2c4c869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	uint32_t			*reset_dump_reg_list;
> +	int                             num_regs;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..ad807350d13e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,116 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[11];
> +	int i, ret, len = 0;
> +
> +	if (*pos)
> +		return 0;
> +
> +	ret = down_read_killable(&adev->reset_sem);

Using the _killable() variant is a really good idea here.

> +
> +	if (ret)
> +		return ret;
> +
> +	if (adev->num_regs == 0)
> +		return 0;
> +
> +	for (i = 0; i < adev->num_regs; i++) {
> +		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
> +		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));

Uff, I'm not 100% sure if we can do copy_to_user without dropping the lock.

> +
> +		if (ret)
> +			return -EFAULT;

But returning here without dropping the lock is certainly incorrect.

> +
> +		len += strlen(reg_offset);
> +	}
> +
> +	up_read(&adev->reset_sem);
> +
> +	ret = copy_to_user(buf + len, "\n", 1);
> +
> +	if (ret)
> +		return -EFAULT;
> +
> +	len++;
> +	*pos += len;
> +
> +	return len;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset, *reg, reg_temp[11];
> +	uint32_t reg_list[128];
> +	int ret, i = 0, len = 0;
> +
> +	do {
> +		reg_offset = reg_temp;
> +		memset(reg_offset,  0, 11);
> +		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
> +
> +		if (ret)
> +			return -EFAULT;
> +
> +		if (strncmp(reg_offset, "clear", 5) == 0) {

Please completely drop the idea with the clear here, that should be 
unnecessary.

> +
> +			ret = down_read_killable(&adev->reset_sem);
> +
> +			if (ret)
> +				return ret;
> +
> +			kfree(adev->reset_dump_reg_list);
> +			adev->reset_dump_reg_list = NULL;
> +			adev->num_regs = 0;
> +
> +			up_read(&adev->reset_sem);
> +
> +			return size;
> +		}
> +
> +		reg = strsep(&reg_offset, " ");
> +		ret = kstrtouint(reg, 16, &reg_list[i]);
> +
> +		if (ret)
> +			return -EFAULT;
> +
> +		len += strlen(reg) + 1;
> +		i++;
> +
> +	} while (len < size);
> +
> +	adev->reset_dump_reg_list =  krealloc_array(adev->reset_dump_reg_list,
> +						i, sizeof(uint32_t), GFP_KERNEL);

Well that still doesn't looks like what we need.

Here is once more the roughly what the code should do:

unsigned int i;
uint32_t *tmp;

i = 0;
do {
     tmp = krealloc_array(tmp, i, sizeof(uint32_t), GFP_KERNEL);
     copy_from_user().....
     i++;
} while (len < size);

down_write_killable();
...

swap(adev->reset_dump_reg_list, tmp);
adev->num_regs = i;
up_write();

Regards,
Christian.

> +
> +	ret = down_read_killable(&adev->reset_sem);
> +
> +	if (ret)
> +		return ret;
> +
> +	adev->num_regs = i;
> +	memcpy(adev->reset_dump_reg_list, reg_list,
> +			sizeof(uint32_t) * adev->num_regs);
> +
> +	up_read(&adev->reset_sem);
> +
> +	return size;
> +}
> +
> +
> +
> +static const struct file_operations amdgpu_reset_dump_register_list = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_reset_dump_register_list_read,
> +	.write = amdgpu_reset_dump_register_list_write,
> +	.llseek = default_llseek
> +};
> +
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -1672,6 +1782,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

