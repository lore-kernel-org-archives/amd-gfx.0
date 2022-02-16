Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04506C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 13:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F42A10EB96;
	Wed, 16 Feb 2022 13:11:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C26F10EAAE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 13:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8vygmA5ao+sMVKrYVWpyLIPIsZR+SmzCh4rhx5IC6PuWuq+HAMTThVWj1jDjC4Rpjuoe+LFc4CPx2Rcs51T3Dgf3BJPSNcfEDrG9srS72qUHZXLRDM2PXZv5M6cpx4KIJrHjEUJs/X/ek5rfgFhooDOH/0+3b7NdGs2N4zHjQgVOlFGb2aDOdnbJZZli1TLT1OuC+MLqVcj+E6KgxOAC3pyFyiM1k92m+lSRTAKv89Z6OX3rWqsl/mbpfuyHes1P7FzzfC6DAJy3if3RTLxYDLRHuVkwDjDpTn3qJ+00NiNIUeSqDSaCR12pbWx5NqR3jVjqceHrm/TzFuePS8qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD10L0qwu7rEy5In8I0HUWazVhuioaiSE+weGH2ilpw=;
 b=TrgogTwnSkyR/PPRw/VAspsa9d4BzrsTvtKG4kz2/f1THiAwHv/FTsHSvocGSQ/itQO7Yvr0xEGGlTB8+0dAVg3LXvCHzJVoaVDVm17ubmjbx+tW11XR8T+TIsPpq953PB49/4NM1T3gwT94lJ6NT/BUnJ43rGxHlu5CV2vv4FHHPldnAwWzoAfAtSphFOa3v7lK7DOnbdodSupD0M+LC+4q8ehu1dKn/s9jKd5EybyIhNYx6NNuMn+Y2W6yI6tDJnkg4vbbCKquxmAk/X7SHF1vSz6FUWv4Hei74Uf6fw7B39G6rCv/dBJmUvWVG071upthHwQtLkKCS9Im4dcUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD10L0qwu7rEy5In8I0HUWazVhuioaiSE+weGH2ilpw=;
 b=ZPwB5HMcsAPkZRHg0at9U/XYJVwAp+7Q4TdLrAi5GyMHQsCFkFBz6Y1Y8iMykSiJMykKgvjCuGy1F+VKZIHJcdPostgDBsYljO6zeExc0AbR5e/7DtlbFHmVooK2gK//wg68YH5u9ji0pJhBqtoeeku+6+rnrrKoaB38YhEqz0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 13:11:33 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 13:11:33 +0000
Content-Type: multipart/alternative;
 boundary="------------9I8ncRBLy7o9X0sVGC3SNA7q"
Message-ID: <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
Date: Wed, 16 Feb 2022 18:41:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
X-ClientProxiedBy: BMXPR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::28) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5edc679-6423-480b-1b7d-08d9f14dda2c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3897:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB389784B7344253EEFEB98D4EF8359@DM6PR12MB3897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqjc8WSYi8GDCMkhRUfuZpVoeB1QflmHW8W5GO3ewfwEhQiQFhEBn4aYdfk4qS2JmgfsOT/LCN38kafG0L22VMlSuEysdsT0b5fYb8jsPXZ/STKCUkEog3AO7EbuUnuji6MC0mtZdM9vtkCXlJiKkbVxZumtjcjjRh7CbQqPYmf2iHtlSX/JOJANpxdSnqYkbzpRwubTIux9NOh8MUovHq+SHaONMfr3ZOhNOX7KwwhdO+r7mmA+B10HuY5cfi/B37M8fAoPIoUYn1jZ5MtTRA05A95NegZMY/LsJxnMaG1+QUU95qsZm1fbfy8SDQYMoMWwOMV94OR1LDIvjZCRrTMOOKnoOtk3lDRiFFgmsz8WeWC9vQz8CMbdCi+U3BywcFYIio5kXBOxibojzd9fJdhooyhWSAawAteWNajguPKgyVcTA9NMmyHiZWpvbKBs5XwQaSWkMzsVqSiWFm7kaUvgxeL1R3r+cX6AUuRJ6DkCeOMBdp6mmBBAY3MEvhmQZvpPVBLxHHv3NHv81ZNQ7LQJXSpfJd6PaxSVvAS28lcYI5C5QkqPiCdZglaOsP8CIuJP7mQkeihJUywydvCsjGxzvuqMNM7Fa0/Z31yV/v0fB+gJGH1GzXVCT7XOqW4wJ56FdiUnbDaAoJYFMuIMqluD1MD+LxUQrgaB5VYwWAeK8Odg5Le3dt07U714k9wNrD3gY1cMK5pPOYTRs5WJ8Nal8oOsAnCvKAzXokPQCfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(6666004)(33964004)(53546011)(6506007)(2906002)(6486002)(31686004)(31696002)(36756003)(508600001)(6512007)(2616005)(316002)(110136005)(38100700002)(186003)(66574015)(26005)(83380400001)(5660300002)(8676002)(66476007)(66556008)(4326008)(8936002)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NuSGxxdVBJMEM3anpqTHE5MWUzMjM1UG81R3ZHdUFQdmlSQURxS2NBNXRi?=
 =?utf-8?B?NHpmdHRoVWJLZVFNZkFuZ3ZqaUpFOWNubGlpODZPSXpXNnRGWVdRZ1NHR2Jw?=
 =?utf-8?B?MmZYVmRPWnQvcEE0VmFDNUJBODJraHZiajQzMVB4UVFqdHJPelZBb2p3QXYw?=
 =?utf-8?B?ZFVBcUYwYkMvOHNVT2RXbGJFWnZvTWowMkJuYUJLQk1Pc09ITzdzb1EvSlY0?=
 =?utf-8?B?cDhrOG1OSWl3b1hJMVdWT0Q2NnlhamY5alZGb0M2aEVUS0haSEY4ZUNOZGV0?=
 =?utf-8?B?RXZLaG9wbTNmQjVxak54bmFRNnNVSm0vTk9FalRzOGQzbkFFa0dwRDJBVEpZ?=
 =?utf-8?B?TldQUWo5eno2R0VTeG9CQkJFeTE1SWxCbTU2Ymt4V3lYeG9TS1FndTdZdXN6?=
 =?utf-8?B?aGFoTEJiUGNQdWRnck5VdGpEdTZvZmFFS0ljd1lIUUdOZ2hha2twbk9RR0x3?=
 =?utf-8?B?MU11MEk1OEQya05pd3U2aDNnb21hd1NaUFFja0JjamZxSE5iMDZPczFadEFz?=
 =?utf-8?B?MnRjWGNaTllzbjgrSEpYUGJTTlR2blN2c2RhMnpkcDJoayt3bU5YNXhZcURR?=
 =?utf-8?B?UC9PeGVnM0RpMWg0MWVEUmZBQy90UldNSkJ6ZnhYOGR2c0FxTzhEQkxuUlVh?=
 =?utf-8?B?aXp0RDZvTmpIdXUzbXpWVTNnVVhoWU5rVmFVMjhhZTQ2cHc3OFVJYTlGd2VP?=
 =?utf-8?B?aHp3TGZNNHIvbXd2M2dlRmY0amVoOUR0eDBlVUNSOUZaY3Y3Tzc5MUJzL0Rq?=
 =?utf-8?B?cGNtT2NTUjdCTG9ObXlqQ2t1SGw1S3NsN2czdmhucnhCbEZrSkN6V2FHdDAr?=
 =?utf-8?B?TXQwRWErVDYxekhsZE5aUUVOMWNHWGZZaXRTUHcxcXlvMC93NjNmR0JQVVRG?=
 =?utf-8?B?bjR5aCtVOEZ2RGdaNWNwdUJwYW9RNUFOQ0I5OHU5NDJSMnQ1MmRlR2FiNDZT?=
 =?utf-8?B?Zkh6Zmg2dEg5UkhmZ0NuTjFQQk94d05yTW81ejFjdFhRQjFaK3IzWVJ2Q2FE?=
 =?utf-8?B?eDhrUHoyenYxM0dyL2ZQTE0zMHNGKzh6U0swY3dLV0tTZXhjaktFTWJEdjFK?=
 =?utf-8?B?TVc5WWdhUEMxVTlCY3duMEo5c3VtTDNyQnpTb3NucHQ1VkJIcjhBY2JsMzVO?=
 =?utf-8?B?eHhvdDMzaTlaa2Vzc1pVbm9QcEdGb1UxejlxU2s0SE1BTU9BV0cwN1ZzRkpY?=
 =?utf-8?B?OGhmWms5azZWcWpZVitnRVlXYWZFdERNS3dCZVdJbTJXVHhLOXdaazdqRiti?=
 =?utf-8?B?QkFFV2MyY1hJU2ZsQ2YxRFV5VmFveHdjd3I2bmd1eUpIczVpdk1kbzFEOGxn?=
 =?utf-8?B?dnRDVEIyZkhtUnFaNkVyUHQydkNkOTI2R1R3L2pPVENXbEVtVDcveGlqQ0xo?=
 =?utf-8?B?eE1HRytNV3ZLMFhpSVN3T0gxaWFFQkpmUUNEZlI1RkZqbjZkTDcwekZoUEla?=
 =?utf-8?B?MmRRUDNGcWZoTWVzZkpvSFBWcUdRbHdMRmFvbzVGcWpxVHZGbTJLQk9SS0hr?=
 =?utf-8?B?Y21zT3FCRkxlS3dtc0FPTVcyWnExaW90OTdTSjdib25vSzY4RCs4NCtGSU4v?=
 =?utf-8?B?WmIzeVY0ZjBOWVhFdHh6ZmlFMXRhcnhnQ29ZS1dLMnNWOUtyRlVQMFgwMFkw?=
 =?utf-8?B?MUVuTjJBZnFKSVZBNjBsL0FIbjVCUnBGemx2NHFERHY2OHZkN2hkVWppd1c2?=
 =?utf-8?B?dllRTzBvY1kxdlk4a0JJZG1TRVlFZ0wzb2VUT01LRHNZcEx6RmE1bVh5UFNF?=
 =?utf-8?B?VHdqVEx0MDVnalMzSkx5ZTJQSHVKRGtaVjBNamJRNFdESHZFZmNNVHNldDcx?=
 =?utf-8?B?SkZTRE41OHRmRWJ6cnBab2JFcXdIMmw1ZVJENnZJYTFBeDQydjVIcnBSZGNW?=
 =?utf-8?B?ZWpaWHplaXNMWkxpMDhtUzdweHoyZ00yRzlBOWZ5aHRzM3JZTC9rU3NsN3B2?=
 =?utf-8?B?YUw0bzR0WUR6Y1VPdDFVZUtuZ3h0RnRFbGoyYTlFM3RuRHdjTHNvblNueG1Q?=
 =?utf-8?B?SVZGOFdhc1drT0Q4L3Q3RUxHaWpSalJzcjJEYmdMVFpPUWtRM1QxMWhOVGxD?=
 =?utf-8?B?VTlyT2tPL0dDN004cmRRT2JkOUNtVDJDRzl4NHNWMUcrOXIvLzdoUk43ei9O?=
 =?utf-8?B?VTFBWHZmMnAycE5taGxWTSsxcHRRSHFqQkp6TXpHWnZjT1Fmd0xDazJWbmJI?=
 =?utf-8?Q?AIIgvOuZJXOGMSk5c+DSzWc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5edc679-6423-480b-1b7d-08d9f14dda2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 13:11:33.2547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zewsFsM9fNW6Te5f/l1AWNdGVSd2Tm4Zn+9cgK05s92kYSSwSs7jwGMW/Oz8RgvmcfGSZYkcEMcUDKjKh63PUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3897
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

--------------9I8ncRBLy7o9X0sVGC3SNA7q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/16/2022 3:41 PM, Christian König wrote:
> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>> List of register populated for dump collection during the GPU reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++++++++
>>   2 files changed, 100 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index b85b67a88a3d..57965316873b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>         struct amdgpu_reset_control     *reset_cntl;
>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>> +
>> +    /* reset dump register */
>> +    uint32_t            *reset_dump_reg_list;
>> +    int                             n_regs;
>> +    struct mutex            reset_dump_mutex;
>
> I think we should rather use the reset lock for this instead of 
> introducing just another mutex.
>
>>   };
>>     static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 164d6a9e9fbb..faf985c7cb93 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>> +                char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char reg_offset[11];
>> +    int i, r, len = 0;
>> +
>> +    if (*pos)
>> +        return 0;
>> +
>> +    if (adev->n_regs == 0)
>> +        return 0;
>> +
>> +    for (i = 0; i < adev->n_regs; i++) {
>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>> +
>> +        if (r)
>> +            return -EFAULT;
>> +
>> +        len += strlen(reg_offset);
>> +    }
>
> You need to hold the lock protecting adev->reset_dump_reg_list and 
> adev->n_regs while accessing those.
>
> (BTW: num_regs instead of n_regs would match more what we use 
> elsewhere, but is not a must have).
>
This is read function for user and returns only list of reg offsets, I 
did not understand correctly !
>> +
>> +    r = copy_to_user(buf + len, "\n", 1);
>> +
>> +    if (r)
>> +        return -EFAULT;
>> +
>> +    len++;
>> +    *pos += len;
>> +
>> +    return len;
>> +}
>> +
>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>> +            const char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char *reg_offset, *reg, reg_temp[11];
>> +    static int alloc_count;
>> +    int ret, i = 0, len = 0;
>> +
>> +    do {
>> +        reg_offset = reg_temp;
>> +        memset(reg_offset,  0, 11);
>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>> ((int)size-len)));
>> +
>> +        if (ret)
>> +            goto failed;
>> +
>> +        reg = strsep(&reg_offset, " ");
>> +
>> +        if (alloc_count <= i) {
>
>> +            adev->reset_dump_reg_list =  krealloc_array(
>> +                            adev->reset_dump_reg_list, 1,
>> +                            sizeof(uint32_t), GFP_KERNEL);
>> +            alloc_count++;
>> +        }
>> +
>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>
> This here is modifying adev->reset_dump_reg_list as well and so must 
> be protected by a lock as well.
>
> The tricky part is that we can't allocate memory while holding this 
> lock (because we need it during reset as well).
>
> One solution for this is to read the register list into a local array 
> first and when that's done swap the local array with the one in 
> adev->reset_dump_reg_list while holding the lock.
>
> Regards,
> Christian.
>
There are 2 situations:
1st time creating list n_regs will be 0 and trace event will not be 
triggered
2nd time while updating list n_regs is already set and 
adev->reset_dump_reg_list will have some offsets address (hypothetically 
speaking *during reset + update* read values from RREG32 will mix up of 
old list and new list)
its only critical when its freed and n_regs is not 0

Regards,
S.Amarnath
>> +
>> +        if (ret)
>> +            goto failed;
>> +
>> +        len += strlen(reg) + 1;
>> +        i++;
>> +
>> +    } while (len < size);
>> +
>> +    adev->n_regs = i;
>> +
>> +    return size;
>> +
>> +failed:
>> +    mutex_lock(&adev->reset_dump_mutex);
>> +    kfree(adev->reset_dump_reg_list);
>> +    adev->reset_dump_reg_list = NULL;
>> +    alloc_count = 0;
>> +    adev->n_regs = 0;
>> +    mutex_unlock(&adev->reset_dump_mutex);
>> +    return -EFAULT;
>> +}
>> +
>> +
>> +
>> +static const struct file_operations amdgpu_reset_dump_register_list = {
>> +    .owner = THIS_MODULE,
>> +    .read = amdgpu_reset_dump_register_list_read,
>> +    .write = amdgpu_reset_dump_register_list_write,
>> +    .llseek = default_llseek
>> +};
>> +
>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   {
>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       if (!debugfs_initialized())
>>           return 0;
>>   +    mutex_init(&adev->reset_dump_mutex);
>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>                     &fops_ib_preempt);
>>       if (IS_ERR(ent)) {
>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>                   &amdgpu_debugfs_test_ib_fops);
>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>                   &amdgpu_debugfs_vm_info_fops);
>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>> root, adev,
>> +                &amdgpu_reset_dump_register_list);
>>         adev->debugfs_vbios_blob.data = adev->bios;
>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>
--------------9I8ncRBLy7o9X0sVGC3SNA7q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/16/2022 3:41 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">Am
      16.02.22 um 10:49 schrieb Somalapuram Amaranath:
      <br>
      <blockquote type="cite">List of register populated for dump
        collection during the GPU reset.
        <br>
        <br>
        Signed-off-by: Somalapuram Amaranath
        <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95
        +++++++++++++++++++++
        <br>
        &nbsp; 2 files changed, 100 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        index b85b67a88a3d..57965316873b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
        <br>
        @@ -1097,6 +1097,11 @@ struct amdgpu_device {
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control&nbsp;&nbsp;&nbsp;&nbsp; *reset_cntl;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* reset dump register */
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_list;
        <br>
        +&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n_regs;
        <br>
        +&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_dump_mutex;
        <br>
      </blockquote>
      <br>
      I think we should rather use the reset lock for this instead of
      introducing just another mutex.
      <br>
      <br>
      <blockquote type="cite">&nbsp; };
        <br>
        &nbsp; &nbsp; static inline struct amdgpu_device *drm_to_adev(struct
        drm_device *ddev)
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        index 164d6a9e9fbb..faf985c7cb93 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
        <br>
        @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt,
        NULL,
        <br>
        &nbsp; DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;);
        <br>
        &nbsp; +static ssize_t amdgpu_reset_dump_register_list_read(struct
        file *f,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *buf, size_t size, loff_t *pos)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
        *)file_inode(f)-&gt;i_private;
        <br>
        +&nbsp;&nbsp;&nbsp; char reg_offset[11];
        <br>
        +&nbsp;&nbsp;&nbsp; int i, r, len = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (*pos)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (adev-&gt;n_regs == 0)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;n_regs; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(reg_offset, &quot;0x%x &quot;,
        adev-&gt;reset_dump_reg_list[i]);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = copy_to_user(buf + len, reg_offset,
        strlen(reg_offset));
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len += strlen(reg_offset);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
      </blockquote>
      <br>
      You need to hold the lock protecting adev-&gt;reset_dump_reg_list
      and adev-&gt;n_regs while accessing those.
      <br>
      <br>
      (BTW: num_regs instead of n_regs would match more what we use
      elsewhere, but is not a must have).
      <br>
      <br>
    </blockquote>
    This is read function for user and returns only list of reg offsets,
    I did not understand correctly ! <br>
    <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; r = copy_to_user(buf + len, &quot;\n&quot;, 1);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; len++;
        <br>
        +&nbsp;&nbsp;&nbsp; *pos += len;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return len;
        <br>
        +}
        <br>
        +
        <br>
        +static ssize_t amdgpu_reset_dump_register_list_write(struct
        file *f,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *buf, size_t size, loff_t *pos)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
        *)file_inode(f)-&gt;i_private;
        <br>
        +&nbsp;&nbsp;&nbsp; char *reg_offset, *reg, reg_temp[11];
        <br>
        +&nbsp;&nbsp;&nbsp; static int alloc_count;
        <br>
        +&nbsp;&nbsp;&nbsp; int ret, i = 0, len = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; do {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_offset = reg_temp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(reg_offset,&nbsp; 0, 11);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = copy_from_user(reg_offset, buf + len, min(11,
        ((int)size-len)));
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = strsep(&amp;reg_offset, &quot; &quot;);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (alloc_count &lt;= i) {
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_list
        =&nbsp; krealloc_array(
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_list, 1,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(uint32_t), GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_count++;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kstrtouint(reg, 16,
        &amp;adev-&gt;reset_dump_reg_list[i]);
        <br>
      </blockquote>
      <br>
      This here is modifying adev-&gt;reset_dump_reg_list as well and so
      must be protected by a lock as well.
      <br>
      <br>
      The tricky part is that we can't allocate memory while holding
      this lock (because we need it during reset as well).
      <br>
      <br>
      One solution for this is to read the register list into a local
      array first and when that's done swap the local array with the one
      in adev-&gt;reset_dump_reg_list while holding the lock.
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
    </blockquote>
    There are 2 situations:<br>
    1st time creating list n_regs will be 0 and trace event will not be
    triggered<br>
    2nd time while updating list n_regs is already set and
    adev-&gt;reset_dump_reg_list will have some offsets address
    (hypothetically speaking&nbsp; <b>during reset + update</b> read values
    from RREG32 will mix up of old list and new list) <br>
    its only critical when its freed and n_regs is not 0<br>
    <br>
    Regards,<br>
    S.Amarnath<br>
    <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len += strlen(reg) + 1;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; } while (len &lt; size);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;n_regs = i;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return size;
        <br>
        +
        <br>
        +failed:
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;reset_dump_mutex);
        <br>
        +&nbsp;&nbsp;&nbsp; kfree(adev-&gt;reset_dump_reg_list);
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_list = NULL;
        <br>
        +&nbsp;&nbsp;&nbsp; alloc_count = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; adev-&gt;n_regs = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;reset_dump_mutex);
        <br>
        +&nbsp;&nbsp;&nbsp; return -EFAULT;
        <br>
        +}
        <br>
        +
        <br>
        +
        <br>
        +
        <br>
        +static const struct file_operations
        amdgpu_reset_dump_register_list = {
        <br>
        +&nbsp;&nbsp;&nbsp; .owner = THIS_MODULE,
        <br>
        +&nbsp;&nbsp;&nbsp; .read = amdgpu_reset_dump_register_list_read,
        <br>
        +&nbsp;&nbsp;&nbsp; .write = amdgpu_reset_dump_register_list_write,
        <br>
        +&nbsp;&nbsp;&nbsp; .llseek = default_llseek
        <br>
        +};
        <br>
        +
        <br>
        &nbsp; int amdgpu_debugfs_init(struct amdgpu_device *adev)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *root =
        adev_to_drm(adev)-&gt;primary-&gt;debugfs_root;
        <br>
        @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct
        amdgpu_device *adev)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!debugfs_initialized())
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;reset_dump_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent = debugfs_create_file(&quot;amdgpu_preempt_ib&quot;, 0600, root,
        adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;fops_ib_preempt);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(ent)) {
        <br>
        @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct
        amdgpu_device *adev)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_test_ib_fops);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_vm_info&quot;, 0444, root, adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_vm_info_fops);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_reset_dump_register_list&quot;,
        0644, root, adev,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_reset_dump_register_list);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.size = adev-&gt;bios_size;
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------9I8ncRBLy7o9X0sVGC3SNA7q--
