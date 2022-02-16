Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07BDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 10:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDD310E61A;
	Wed, 16 Feb 2022 10:34:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A188410E5F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 10:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igCJY+wvXRiDr/gXavMUxeBDC+2sdj9txuw+GdtW0MV4i5E3nd7QphynngUw1rbxZwMrmIn/fWu3FWJ8yNJAZ4Eu66fvofpnyDD/mDJfkpDraCdS/y+qzeWbds0zuUFYzl8ndypzX01IcbnevkhmPEl/zGH7XWL6AOe9N2qjEMow0D2X7BNx97edxDgAziGFOyh4EdgewJwSePpz0zfg3RPd1+/V01yWzk/OUwXy30RS1f0SS6ZFnUfmrP8rSoML02mbRzBNRgGvsXte37ATIycnWx9fWrZMivPYXhWnKQVX3Th7VHLWBpkCHow/JrfLOf2dAQD5SlOU2VQ3jLi4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt2xW6jOANoVPkvMr2iVvILgK/KyvmnOe1GT7mNcPJU=;
 b=oJzRWecGZ61WMqEJbw8YPWL+i6i7l4GW/9KvEnd9y+/nolHCPqgPjIyGF+TGNrGPdCmdt8abIDhCdLNFh9CTxJzr21e35tyUxQrLA6UlswX5SWIoudj6AODABjb4wRpt6RdaJnbSmJMt+eFRGFjMpuWw1AxBmJAwsCU37n+MmdN4rIwAew/F+SmYaj+yi52FyUjDOq9w/zFh9j9ibjpgHda54J5kRQCAwjoHPieiDqp2SkihNUzmNJFFz4/1JCQvvnpzEgph761AKs4+V4c/ovzJDQOm3R5nssDQZv6bBhml1+EoV6ZrgDRIbshGB+aHF2WoAVaJN8oQQKCNEEXePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt2xW6jOANoVPkvMr2iVvILgK/KyvmnOe1GT7mNcPJU=;
 b=zzfDZvdU+sFTF9QBZ9PFkTuDPagsu0Pr7/kGlZJzEwDnAeCr0k3zSMBFujc3T3TiMm5rieiVABNMJj/EE+pBwqiEyhEIig++cnh90CqcjDIBdVZPdpSlQsbaaqv5RID6AEXGFEtyma530rPI96GRx5hvnrBDlT5/yvOM/SMO4cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 10:34:40 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 10:34:40 +0000
Message-ID: <392e1b15-8bbc-91cf-ab86-9d28aa0b716e@amd.com>
Date: Wed, 16 Feb 2022 16:04:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::13) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1753c726-0bd5-4aaa-4095-08d9f137efc0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB521359223F731A39EC759C44F8359@DM4PR12MB5213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOWCjfjTqAgxMgai80TWvVb5LPYfsaFxCTchJLp5pjPRMB04eCnvGZL7ev/9svEf5I4HLyASHisFO2C4UFME39fEIbZoSJBWQzdiA/msQkkaKmwzd+DFNBAtdX5RTI5uiA34fZA+MNpjKftM/Bltd5AJEDEKMUFmNacS/NEZc+RaOy0xi9sBhoJ0gva8H44WouwTd0JaH6uZNx8dSyX4ije1Pu8kTRxgM6+2C/PQpWCo+YFH7LJB6tJio2yqN1yPvGkj31mWJfvWZBeUiyT6S0mNER37X4a07UdWp3DDf/dQ3Zzs8SKGpxNSMxAVdDDUu2dfwkctlBdBoVvOVHeIGjWWUAjcdo+risq/5siVWAT0OHrHmczhJ+A2Big7GmVI0BqbiD61/Y2pc4IaEUGmMOKMS9/Dv37FksdpV1npdF71RkyE/9M5oah1hl/WkH1fmbow7e8SNn2k6oGoBY/jmbljLIRDrFDMxWC8fvzuYjTRfw0oaSqyB4URbeKR8tJXeEYKnpY7QgCjZ53m9DYdV3Jo3zmIF2QbirRwRgiy5K9w4jQ1lIAbQ63Ofgl/D4aFgOu+pWW58xJbgDg5IcYqGivKvxNblvwgHORFxcrR07auDlf8XzmlNuVp5UiMuXZaDYzxhfikapuSTuZVxCqbq+wXsXIoVoWCLIy/qGiYHmwRJSJi9fauTRCvenXo+TgrxwQqsJ/Iu0O59fVaSLXjTsRbt06oX36ukyNUiJkMhak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(31686004)(2906002)(38100700002)(8936002)(5660300002)(4326008)(83380400001)(53546011)(6506007)(31696002)(186003)(66556008)(8676002)(66476007)(66946007)(6512007)(110136005)(2616005)(26005)(316002)(508600001)(6486002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUcxM05xZzRuUFQ0QnRWSU1LZU1vUkxmYXNmNU80Rmt5MDFlckpqOUE3NVFB?=
 =?utf-8?B?THVMWmdpaWxNbjdLeXpsNk9vMXQrUWkxWThhTHU5MEZhWlprUEMvWlBGWjZG?=
 =?utf-8?B?M3hpaEtaWWlFMU1BYTZhckVEcmt1REpKR3ZkYnUrQ0FuSVE4Q1pYUnlyZThL?=
 =?utf-8?B?RFByeWl5K0Fvd0lsZmZuUUhNazlIYngvL0pyYWFyUE11VllYRGZJcGhoeHA1?=
 =?utf-8?B?NnExak5nbkQ2b3hzbkFBWndITzJWUjM5dWJCRHIxUGlSQm1ta3VpSS9MYTBa?=
 =?utf-8?B?L2tlQlpuOGMwQjVCdklRQ0FOSERUODZCOVN2bnhHcmxjWUkvbEZVeUZtNE5t?=
 =?utf-8?B?NytHRFFvZms4cEZ1alAyeHF3b05MU21WOXN3UnVrRCtIVFFTeXF2SU9qeUl3?=
 =?utf-8?B?SE5zVlA3bkY3aWJENEJWT2dHVERZZzdYY1VmZGF1dTVzNmY4ZWxKa2VRaEh1?=
 =?utf-8?B?NFNpZ3RxL1Z4Mm1CZmNhaTdNQitKbTlIeUMyMWlsOEs5U1psalRpSEw2S0Ri?=
 =?utf-8?B?UnJxMFd1V285V0ZjeGRBM2FsWlFyME1rQ2JaeHAzRGtaMUxMVWJjMWlBbmFs?=
 =?utf-8?B?QzVkR1Irb2N0MXpnbC90eENHWFN6YlZmempmekNvb0lXaFZQRmdrU0c0TW94?=
 =?utf-8?B?NFhWSVdFMW9ndDFKRjBLSG1NV0RsMEZvcWtubmVENTJ4SmtUU1ZSNEdTaEY5?=
 =?utf-8?B?YzdGYzVzZXBkbEdBVjM3c3F2bkV6OFpsL3hpWllDTmVpVVZXL0ZMOEk4KzdZ?=
 =?utf-8?B?VnhCVEc1TVpOWklMQlczeUM0SHgvU2VlU2VWUndsRVVqV0VjdnRVZDQ2ajVp?=
 =?utf-8?B?NlNiK001Q3dEbWwzWFNWYm1ndjlkUkt4dG10bzdjdmZDY0RJZ1BYeUlYK3pm?=
 =?utf-8?B?RjVvMnFKbmd6amh4Qms3TGF5L2dWTnAybUJxRk9LZGdIL3hJY0U1T1o0OUNm?=
 =?utf-8?B?U0VkNnNvb0JkVTZJQzEyUWhnMWwrZExJYmZYbGMxdC9weU5xcGN3QWpXVExB?=
 =?utf-8?B?TFRDRnJScVNxT2JvRUpnZkxJZGpxNVNUcGZtVFlDU2ZwOHprT0FSMEVqZlBn?=
 =?utf-8?B?eVZnRzNRVndsY2cyY3owRC8wWFJoK2lwSktaV3pBL3lWOUs4TlFiQWRzaGR1?=
 =?utf-8?B?R0E2bHFhQ0tIYWZlVXhYSTdQOWl4RVFOVWJRNzE3VlZpLzk0b2RyRWJRWUc2?=
 =?utf-8?B?NEoxSWlpY3VTcG9OcWZNS2FqbXVLbUNXQzk1QjVhZysrZmNXU1B6VmpKMTl3?=
 =?utf-8?B?WGMwUjZtZEo2VWx1RUR5M1V2eGZGL0VRdVQxS3lEUGhTeCt2RUJhN0RQRlYy?=
 =?utf-8?B?d2VvNUFmYjRSN0tHQ3kyYlV6bUJvMDlmT2J6K2JwK1htTVV1SCsyUVQyTUFP?=
 =?utf-8?B?WlpRUWUyODRONjIrN3dFSmFRdkZCU2pzUFZ0UzNVODVxajdoelA1SldETkRE?=
 =?utf-8?B?c3ptZDd2V0JmZlhuL0oraHh0WTBCZURuRW1jY01ITVFIVGVuc1g5WEtrUFNp?=
 =?utf-8?B?Z1NISUoycTl6VW1sblZQbjdVNER3THpkL0g3N1JIdURCK3NMYnJ6cW54R3JH?=
 =?utf-8?B?TUZLSnNXcXR6Y1Q0aDlZM1hPMjMzLzhUYVMzTzIyZ3JDTUhIbnh6QWY5SHJn?=
 =?utf-8?B?MmtkbGw2Z0hveEhtZXpCMldFeUJhUXBGdmtSU0JDZ1NQb3h0TGQ2b0dwd2Ns?=
 =?utf-8?B?ZXVZYndTMUdQYXJWLzAxczY4S1JsTXNBVzNHOVBxQ2g4a25sZG5qY3ZJbXhu?=
 =?utf-8?B?cjQ2Y1FPNk82c1YvcFJFdUw5QU9vN3diaDlmc0NYZXBxbDVOeEllUUhSbW1j?=
 =?utf-8?B?NGNzanU0ZTE4WUJZYnFyL2dOMk5Bbmp1bmFoTDNaT2QxT2Fody9KNjlxSmVJ?=
 =?utf-8?B?YjhBODRTUUhCWTV5QTFtN1pzOHlxalJCN2VEcXBxcXBXQnV1V0kyL2hxS2NN?=
 =?utf-8?B?QzQ4bE05dUhrNWc4bHViZXJXVXRNSWt4cWRUMkRpMkdncUJ4dGFIWHNxcGtS?=
 =?utf-8?B?L2liRjgrSGR3VGxRd2VrNjc3UkJxT0ZQUHpCU1VPM0JOTGpWc1JBazNLdnNL?=
 =?utf-8?B?YXFDZzBPTE5vei9GWmcyb015WGVEMUFRZURGa3R0Tm8rQ0VGMVF5TlZKbGNT?=
 =?utf-8?B?N0pZY1crZjFRclBWR1VmREpnbENEUFhkYkpuVm9kbFQrbFRsVFlRVVpXTGNh?=
 =?utf-8?Q?oILOSaLjjolhCjVVRCqPhcw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1753c726-0bd5-4aaa-4095-08d9f137efc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:34:40.1234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JI3RoGzqICE0Y0yQcUjANJ4ZzWjYBYFOompRzZNuIjew1BNOi8LQ0bT9+TTzNherBDJBN3DEh+jGx4e884Y6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/16/2022 3:45 PM, Lazar, Lijo wrote:
>
>
> On 2/16/2022 3:19 PM, Somalapuram Amaranath wrote:
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
>
> This being static what happens when it is called on a second device?
>
> Thanks,
> Lijo
>
I tried to avoid adding to adev. It wont work for multiple devices.
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
>> +            adev->reset_dump_reg_list =  krealloc_array(
>> +                            adev->reset_dump_reg_list, 1,
>> +                            sizeof(uint32_t), GFP_KERNEL);
>> +            alloc_count++;
>> +        }
>> +
>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
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
>>
