Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0641AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 08:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC1510E99E;
	Thu, 17 Feb 2022 08:00:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA32D10E98B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 08:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjPGb0ijmlVxEuQfCqk/f/Yit9AYNBrZI/76tVHEJRxw6So+5huRAIZDyHZJt+9066r1PO6ceGLgWSDLOH2RggBMuZwCfgVkh4nEh4BcdC4zh9MeEP0snzxwFzfWcbzZKJxJosmFzFIz16GZ0rWgb6QiDbGb6dOVMmev7fPPkOG8Nfq2OTC46pzhahREI9i7c6d0F5ZBBXWTOFdMeHdWqMos/+8AoC9+l3Kry2eGCfJsO/PqxAj8I1FmeJkd/gNNP23x2h3W3f1rT4bJwVJeZ+QP03bsn5Z82RVjXXlgNT1CU6JpVWheqorVv7FLCv0tXwdA0wpIKXAk3s9WANnYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffNGlH7/onVMczDCIdn09q5RalPKVdIhZF0TvRGSNro=;
 b=hLdR4SDIk8HZc85w13gYJsyRTZ3z9DGs7XgoY70PhRYgD5jO5TvUwn4yFHUY5IL05B37FXQn6WZqrkMMEzNt5K5gApZh9PBrmX+n01SiiJk8yDjSeAjl7zy9/Q5yb77Rdt6lj1YIyRXuYhBQMcUQhx9RS/SOnVlJ1xs/EO6T7G52bEc6rzAL5s7hkGdc0i8Wla3O6Mk122SRLUOFXpmGFSSrBU1RDV0DXf9EW4EzggQ42COIjSixnC2i8C621DlnvbOlQWJqmVo3y1sD1z/q8wT8sr8R99iBxmjvE0/Tdq3cYKWuKxEjgvikoojYZCqtkb46JmFYnKGmfQ/QQtTgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffNGlH7/onVMczDCIdn09q5RalPKVdIhZF0TvRGSNro=;
 b=TIFF0A9Rkw/SaeMCJeWvCye85YWGH6RnLBPVB93Lwfdu390K9rXdrQwBYyBRZUZcPbzF345dxOwHr/lONgmJcbR/hzMElnCwAoZRl5Rhnk/+DeOpUKkwkA7e7gA/Q92hi5Oe0nGnsVTjG4cQswBrK3Robkol4rgitQhASyf49Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR1201MB0098.namprd12.prod.outlook.com (2603:10b6:405:55::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 08:00:09 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 08:00:09 +0000
Content-Type: multipart/alternative;
 boundary="------------Cedu1Iu6pAA1s0vMS2yPV7qI"
Message-ID: <09a4d26f-04be-2a84-343a-32166d21afd1@amd.com>
Date: Thu, 17 Feb 2022 09:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
 <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
 <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
X-ClientProxiedBy: AM6PR08CA0036.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::24) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f5a1a6-bf8c-4ae9-4517-08d9f1eb8464
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0098:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00985372715C4C2EBEC30F6283369@BN6PR1201MB0098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLxdPHcHnDJ8razfLqK6M8PE3ytYwWe66XZhOrTgD366/RBb78GZWC9f34rcqnEjtlugfVe8FbJi/SYM63toNvw33xrdpMtWBrvbiVSLFBBcYvMcFXmuWQ02Sl+zmj/JoYgMz3QkzqA3Ub9sJYAWBJwf62Dmu3LpOH6ukJ6pBT1duvBVB8qPZ/37pSqB++eIRb8HO3Z3QT1y0yXZLZbcoVxR9AiuD5DUdNkA38/DyleXcKi9FG86BQEK+GzkxXk1CTPgFvbitpeM9jw1hty54LQo1RgtG+QMhSrOUF+xtuF+qHHfuSVgShK7emEOUB+RVvQhv6197VaGgGZJc83bclKW90XOIXje9XGUh/lv0CTAQ/Mw2N8k77r+d2NoWncHdfhaz+lLTNm4A652zMZIk76qqXrQFLxHTx67O13lJYeItBMrnuiq/2N1NdJN36xmaxtLPMOCPyLnKestsDnMLPNHl6GVApfZVZ4ozAXThmfXZnaj+zqT+gYR/AeLE2nBlNARNeflFoqjxh3ykabRA+LQxSpE+VSex/pNkQvUXVdmHqsI5k85no6VN73KHTgScDRuha9Uvw3fZNTBPERYkPPHszmkOVoDe3XOKIhyHbei/cdy4L0imLjILNfAK/jr2tFmnBl3CTcSh7PU2kaetmOG3IxXXf8ZV4DoZM7EL1v+gZNzFlKOI/SaJAQg7WN1beY+fRYgIlP/P8vUUYd+BuSU+rEHZ7vZJJSJ+tKwDyc0S7C4Pk06hppygWme/+3jrymv5gpqNq61yK1V0NmVmS/wZZldGV74TBeOyXjfejg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66476007)(33964004)(38100700002)(53546011)(8936002)(186003)(36756003)(6512007)(2616005)(66574015)(6666004)(30864003)(6506007)(86362001)(6486002)(31686004)(83380400001)(110136005)(2906002)(316002)(66556008)(5660300002)(66946007)(31696002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhra0hMTHA0K0hsWk9CWU1oWVNiNW5CV2c5YjJ4WUl0eFEvV2xEWGJkaGlh?=
 =?utf-8?B?Ui8wQWpQZGhxb3BpUGtodEp3UUxsY1FQWDVlT1dsYXQ1K21reU9vZmhSVEc2?=
 =?utf-8?B?K1RDdDBQQzhMRXl1MHhibW82ekhxL1pjbEJ6TzdJNjdDWVRZVk0wYXkxV2N1?=
 =?utf-8?B?dFVMS0hkN043c0QzT1R5cEQ5RUxOSlIzUFNqOUdkTDJkbVp4WXRVcTBWYXkz?=
 =?utf-8?B?eWRPS3VKZHdRdzFqZ2pSZEw1L3FZTDJQTXRpL0VoUGdaVW9FMFdEMWd3VlJk?=
 =?utf-8?B?T0FEdVFtQTIrQnBjc3Q0NFNTeU1aVXptTUxVaTlXY09OaGx3L0NCdzZramtQ?=
 =?utf-8?B?eHNhd0FJUWZFS1RiOEh4SUJqUlFWcWVLRUFBUmE3QXZLZjJJTE5MY0dhUFNL?=
 =?utf-8?B?ZGEvSUpwYm9zeHB1aDhLendaRHhKTjkyeWdHOTVKQUNFUkVFdDkzd1lRY0RJ?=
 =?utf-8?B?aXY4UW9POCtmc0FwYVM2L2t1QjNvV25iQk8xdlpMTlE4TEpJdTYwbHdVODNm?=
 =?utf-8?B?VlFPNXFSQjg1elVBT1JIWmJSNldkckthLzRKbzU4cWRLZHcxY3pTM2JEYmxN?=
 =?utf-8?B?YTJuRGVySk5WQ0ppZWxlT1lSZXhwcHB4NS8xbEI5MlpIZW9INDF3L1Exb05o?=
 =?utf-8?B?aGRQM3RQQjhhWG5uMWkxeVFQSEdOUDdEYlhveVh6RlhnblQ5LzY1ZTRKM0ps?=
 =?utf-8?B?d3RLUTJ0bm5vVHYzTEgxRFo2SUNCcitmRVNJdXVzdEp1MHRJMWNhME80c2NH?=
 =?utf-8?B?RTZSc1lnZ3VzYU4wcjB2RnpvZnE0V0Q3Qml0c1JvTFQ3T1dVeW1zVkJCNW9O?=
 =?utf-8?B?Z0lrNXFvV1psVEYwQzNTUmdiYzJaTzJIOXF4UU1wclA4NXFmSHA0aHIvVzFH?=
 =?utf-8?B?Y3dXbGRVazRkMkg2cC9MY3hPaWt2QzF3Q0haaFBFZnIwaFpob25KNUJrcEFJ?=
 =?utf-8?B?V3VYNDFFTE91dlFwcG8zcTJLWFl3bks1QmxKejVMek9mcDRlWUdZUXhOMkdl?=
 =?utf-8?B?S1VrdE1Ecmk0R1JTUW5xNXlBYnJHL3pOUWpJRmNyRXFmYWgwL1grdWFMbEVl?=
 =?utf-8?B?NmcwV2YrTXJGNDNXdjNoRmxhNThUQ0dTOXV5bzJ1OVcyZVhMdnBkVHdjNzJs?=
 =?utf-8?B?Y3N2cHVKUE9OeFdYSWQrMno1c3EzN1R6MWowVkJUZWdXTnhNTmptSEI4eFNV?=
 =?utf-8?B?TWRrVEtmQk5WbzdSVnE4a01wTDBNT3BTeTFOZnVXTEhQVUV6WkdNZzgzanUy?=
 =?utf-8?B?VUV5S1NKWEFidXVoV09xTGhJcEZpaldkVTBRZTdpVHNOVzJRYkloUFNMTjhT?=
 =?utf-8?B?REl0WmFtN2NrK3pxL0pCd3lleEpjWGt3VG53Y1Vhb1ZOZlg0ZG9oQ0NDZ0ZN?=
 =?utf-8?B?TEI3Mm1RTkZ1NzRncllxZlNjMDBkRGp1bGdPNDU5Smc0bExoYW8vS3BkeC8v?=
 =?utf-8?B?L1dSRHZtNWJIY04yb0ppU0NIUW42RVJrVWoxNTVNWUdrbW0vcXZTaXEwcHJx?=
 =?utf-8?B?TFJkd25jQ0dLZy9POCtUYlVFM21TUVdMVHhHa1MvdkxxcENQSTJudjNGTFFz?=
 =?utf-8?B?K3R6R1BZdTB0eVhXSVlYR1hiSE9mWWpEK3hZSGNkeDFEOFArdTNtY1ZjMW5j?=
 =?utf-8?B?ZGNFMVZlazZCR2hwMkEyRmYrSWVGajJsVkZOMWlsRzZGcW1sMFRpbjJPVXhy?=
 =?utf-8?B?VW5rMWNqSTUvZFViVnpjeXZVYmgweldzMW0vNi9NNWJQK2ZrL2k5b05uSmYx?=
 =?utf-8?B?eDhISEtBV20xOGRROEhEV3FubG9TVlhML3drS05pOCt4ZTFiZS9sVmtVQ1No?=
 =?utf-8?B?TmtsWEp3bUxEQlNYc1RPbU9QL3pWc2NmNWtEUVJjL0YzNFR6VFhuVFBXTVNs?=
 =?utf-8?B?c3RLUWdMTnBCK1FDTmQ2SjdRTXp3ak92emFXbkp3UVpZZHVheGxPQjdXYllq?=
 =?utf-8?B?UmpLdC8wb0J6bDc3Nk9mMHA1ampWZkZNY2JWVU1KUzFNbklVRm9NVXdva1A2?=
 =?utf-8?B?WUFQelFVb2xidTNWSzlsV2l0VUJjOTJwMDVzT3JBbjhSS1ZXYjdseGI5S1RH?=
 =?utf-8?B?QzNOTkcvbWFDcFVEbFZicXhLY0hUR1krWGd0aHZjSTVueVpVNVZHbWg5aTMy?=
 =?utf-8?B?bUdpTHNLdzYrT1Uwekd5Y3ZEUEhvTWtVRVFRRm5jZDB4clUrWmMzRDFBTWNZ?=
 =?utf-8?Q?UoNJBPRs8/LxxNahzkjEFQY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f5a1a6-bf8c-4ae9-4517-08d9f1eb8464
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 08:00:09.2751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDQdT/NnlAuofnXjCiHf7RjGBvcn4HhHtLl6QHzjGpRzmcXeJgbdRt8ivf52vnXl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0098
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

--------------Cedu1Iu6pAA1s0vMS2yPV7qI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 17.02.22 um 08:54 schrieb Somalapuram, Amaranath:
>
>
> On 2/16/2022 8:26 PM, Christian König wrote:
>> Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:
>>>
>>> On 2/16/2022 3:41 PM, Christian König wrote:
>>>
>>>> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>>>>> List of register populated for dump collection during the GPU reset.
>>>>>
>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>>>> +++++++++++++++++++++
>>>>>   2 files changed, 100 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index b85b67a88a3d..57965316873b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>>>         struct amdgpu_reset_control     *reset_cntl;
>>>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>>>> +
>>>>> +    /* reset dump register */
>>>>> +    uint32_t            *reset_dump_reg_list;
>>>>> +    int                             n_regs;
>>>>> +    struct mutex            reset_dump_mutex;
>>>>
>>>> I think we should rather use the reset lock for this instead of 
>>>> introducing just another mutex.
>>>>
>>>>>   };
>>>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>>>> drm_device *ddev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, 
>>>>> NULL,
>>>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file 
>>>>> *f,
>>>>> +                char __user *buf, size_t size, loff_t *pos)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>> *)file_inode(f)->i_private;
>>>>> +    char reg_offset[11];
>>>>> +    int i, r, len = 0;
>>>>> +
>>>>> +    if (*pos)
>>>>> +        return 0;
>>>>> +
>>>>> +    if (adev->n_regs == 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    for (i = 0; i < adev->n_regs; i++) {
>>>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>>>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>>>> +
>>>>> +        if (r)
>>>>> +            return -EFAULT;
>>>>> +
>>>>> +        len += strlen(reg_offset);
>>>>> +    }
>>>>
>>>> You need to hold the lock protecting adev->reset_dump_reg_list and 
>>>> adev->n_regs while accessing those.
>>>>
>>>> (BTW: num_regs instead of n_regs would match more what we use 
>>>> elsewhere, but is not a must have).
>>>>
>>> This is read function for user and returns only list of reg offsets, 
>>> I did not understand correctly !
>>>>> +
>>>>> +    r = copy_to_user(buf + len, "\n", 1);
>>>>> +
>>>>> +    if (r)
>>>>> +        return -EFAULT;
>>>>> +
>>>>> +    len++;
>>>>> +    *pos += len;
>>>>> +
>>>>> +    return len;
>>>>> +}
>>>>> +
>>>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>>>> +            const char __user *buf, size_t size, loff_t *pos)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>>>> *)file_inode(f)->i_private;
>>>>> +    char *reg_offset, *reg, reg_temp[11];
>>>>> +    static int alloc_count;
>>>>> +    int ret, i = 0, len = 0;
>>>>> +
>>>>> +    do {
>>>>> +        reg_offset = reg_temp;
>>>>> +        memset(reg_offset,  0, 11);
>>>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>>>> ((int)size-len)));
>>>>> +
>>>>> +        if (ret)
>>>>> +            goto failed;
>>>>> +
>>>>> +        reg = strsep(&reg_offset, " ");
>>>>> +
>>>>> +        if (alloc_count <= i) {
>>>>
>>>>> + adev->reset_dump_reg_list =  krealloc_array(
>>>>> +                            adev->reset_dump_reg_list, 1,
>>>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>>>> +            alloc_count++;
>>>>> +        }
>>>>> +
>>>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>>>
>>>> This here is modifying adev->reset_dump_reg_list as well and so 
>>>> must be protected by a lock as well.
>>>>
>>>> The tricky part is that we can't allocate memory while holding this 
>>>> lock (because we need it during reset as well).
>>>>
>>>> One solution for this is to read the register list into a local 
>>>> array first and when that's done swap the local array with the one 
>>>> in adev->reset_dump_reg_list while holding the lock.
>>>>
> krealloc_array should be inside lock or outside lock? this may be problem.
>

This *must* be outside the lock because we need to take the lock during 
GPU reset which has a dependency to not allocate memory or wait for 
locks under which memory is allocated.

That's why I said you need an approach which first parses the string 
from userspace, build up the register list and then swap that with the 
existing one while holding the lock.

Regards,
Christian.

> Regards,
>
> S.Amarnath
>
>>>> Regards,
>>>> Christian.
>>>>
>>> There are 2 situations:
>>> 1st time creating list n_regs will be 0 and trace event will not be 
>>> triggered
>>> 2nd time while updating list n_regs is already set and 
>>> adev->reset_dump_reg_list will have some offsets address 
>>> (hypothetically speaking *during reset + update* read values from 
>>> RREG32 will mix up of old list and new list)
>>> its only critical when its freed and n_regs is not 0
>>
>> No, that won't work like this. See you *must* always hold a lock when 
>> reading or writing the array.
>>
>> Otherwise it is perfectly possible that one thread sees only halve of 
>> the updates of another thread.
>>
>> The only alternative would be RCU, atomic replace and manual barrier 
>> handling, but that would be complete overkill for that feature.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> S.Amarnath
>>>>> +
>>>>> +        if (ret)
>>>>> +            goto failed;
>>>>> +
>>>>> +        len += strlen(reg) + 1;
>>>>> +        i++;
>>>>> +
>>>>> +    } while (len < size);
>>>>> +
>>>>> +    adev->n_regs = i;
>>>>> +
>>>>> +    return size;
>>>>> +
>>>>> +failed:
>>>>> +    mutex_lock(&adev->reset_dump_mutex);
>>>>> +    kfree(adev->reset_dump_reg_list);
>>>>> +    adev->reset_dump_reg_list = NULL;
>>>>> +    alloc_count = 0;
>>>>> +    adev->n_regs = 0;
>>>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>>>> +    return -EFAULT;
>>>>> +}
>>>>> +
>>>>> +
>>>>> +
>>>>> +static const struct file_operations 
>>>>> amdgpu_reset_dump_register_list = {
>>>>> +    .owner = THIS_MODULE,
>>>>> +    .read = amdgpu_reset_dump_register_list_read,
>>>>> +    .write = amdgpu_reset_dump_register_list_write,
>>>>> +    .llseek = default_llseek
>>>>> +};
>>>>> +
>>>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>   {
>>>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>> *adev)
>>>>>       if (!debugfs_initialized())
>>>>>           return 0;
>>>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, 
>>>>> adev,
>>>>>                     &fops_ib_preempt);
>>>>>       if (IS_ERR(ent)) {
>>>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>>>> *adev)
>>>>>                   &amdgpu_debugfs_test_ib_fops);
>>>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>>>                   &amdgpu_debugfs_vm_info_fops);
>>>>> + debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>>>> root, adev,
>>>>> +                &amdgpu_reset_dump_register_list);
>>>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>>>
>>

--------------Cedu1Iu6pAA1s0vMS2yPV7qI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">Am 17.02.22 um 08:54 schrieb
      Somalapuram, Amaranath:<br>
    </div>
    <blockquote type="cite" cite="mid:94eeed88-69ad-5823-0505-dc86b36c4007@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2/16/2022 8:26 PM, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com"> Am
        16.02.22 um 14:11 schrieb Somalapuram, Amaranath:<br>
        <blockquote type="cite" cite="mid:ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com">
          <p>On 2/16/2022 3:41 PM, Christian König wrote:<br>
          </p>
          <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">Am
            16.02.22 um 10:49 schrieb Somalapuram Amaranath: <br>
            <blockquote type="cite">List of register populated for dump
              collection during the GPU reset. <br>
              <br>
              Signed-off-by: Somalapuram Amaranath <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com" moz-do-not-send="true">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
              <br>
              --- <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++ <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95
              +++++++++++++++++++++ <br>
              &nbsp; 2 files changed, 100 insertions(+) <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
              index b85b67a88a3d..57965316873b 100644 <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
              @@ -1097,6 +1097,11 @@ struct amdgpu_device { <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control&nbsp;&nbsp;&nbsp;&nbsp; *reset_cntl; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE]; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; /* reset dump register */ <br>
              +&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_dump_reg_list; <br>
              +&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n_regs; <br>
              +&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_dump_mutex; <br>
            </blockquote>
            <br>
            I think we should rather use the reset lock for this instead
            of introducing just another mutex. <br>
            <br>
            <blockquote type="cite">&nbsp; }; <br>
              &nbsp; &nbsp; static inline struct amdgpu_device *drm_to_adev(struct
              drm_device *ddev) <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
              index 164d6a9e9fbb..faf985c7cb93 100644 <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
              @@ -1609,6 +1609,98 @@
              DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL, <br>
              &nbsp; DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_sclk_set, &quot;%llu\n&quot;); <br>
              &nbsp; +static ssize_t
              amdgpu_reset_dump_register_list_read(struct file *f, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char __user *buf, size_t size, loff_t
              *pos) <br>
              +{ <br>
              +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
              *)file_inode(f)-&gt;i_private; <br>
              +&nbsp;&nbsp;&nbsp; char reg_offset[11]; <br>
              +&nbsp;&nbsp;&nbsp; int i, r, len = 0; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; if (*pos) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; if (adev-&gt;n_regs == 0) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;n_regs; i++) { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(reg_offset, &quot;0x%x &quot;,
              adev-&gt;reset_dump_reg_list[i]); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = copy_to_user(buf + len, reg_offset,
              strlen(reg_offset)); <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len += strlen(reg_offset); <br>
              +&nbsp;&nbsp;&nbsp; } <br>
            </blockquote>
            <br>
            You need to hold the lock protecting
            adev-&gt;reset_dump_reg_list and adev-&gt;n_regs while
            accessing those. <br>
            <br>
            (BTW: num_regs instead of n_regs would match more what we
            use elsewhere, but is not a must have). <br>
            <br>
          </blockquote>
          This is read function for user and returns only list of reg
          offsets, I did not understand correctly ! <br>
          <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
            <blockquote type="cite">+ <br>
              +&nbsp;&nbsp;&nbsp; r = copy_to_user(buf + len, &quot;\n&quot;, 1); <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; if (r) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; len++; <br>
              +&nbsp;&nbsp;&nbsp; *pos += len; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; return len; <br>
              +} <br>
              + <br>
              +static ssize_t
              amdgpu_reset_dump_register_list_write(struct file *f, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *buf, size_t size, loff_t
              *pos) <br>
              +{ <br>
              +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
              *)file_inode(f)-&gt;i_private; <br>
              +&nbsp;&nbsp;&nbsp; char *reg_offset, *reg, reg_temp[11]; <br>
              +&nbsp;&nbsp;&nbsp; static int alloc_count; <br>
              +&nbsp;&nbsp;&nbsp; int ret, i = 0, len = 0; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; do { <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_offset = reg_temp; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(reg_offset,&nbsp; 0, 11); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = copy_from_user(reg_offset, buf + len,
              min(11, ((int)size-len))); <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = strsep(&amp;reg_offset, &quot; &quot;); <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (alloc_count &lt;= i) { <br>
            </blockquote>
            <br>
            <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              adev-&gt;reset_dump_reg_list =&nbsp; krealloc_array( <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_list,
              1, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(uint32_t),
              GFP_KERNEL); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_count++; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kstrtouint(reg, 16,
              &amp;adev-&gt;reset_dump_reg_list[i]); <br>
            </blockquote>
            <br>
            This here is modifying adev-&gt;reset_dump_reg_list as well
            and so must be protected by a lock as well. <br>
            <br>
            The tricky part is that we can't allocate memory while
            holding this lock (because we need it during reset as well).
            <br>
            <br>
            One solution for this is to read the register list into a
            local array first and when that's done swap the local array
            with the one in adev-&gt;reset_dump_reg_list while holding
            the lock. <br>
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
      <p>krealloc_array should be inside lock or outside lock? this may
        be problem.<br>
      </p>
    </blockquote>
    <br>
    This *must* be outside the lock because we need to take the lock
    during GPU reset which has a dependency to not allocate memory or
    wait for locks under which memory is allocated.<br>
    <br>
    That's why I said you need an approach which first parses the string
    from userspace, build up the register list and then swap that with
    the existing one while holding the lock.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:94eeed88-69ad-5823-0505-dc86b36c4007@amd.com">
      <p> </p>
      <p>Regards,</p>
      <p>S.Amarnath<br>
      </p>
      <blockquote type="cite" cite="mid:d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com">
        <blockquote type="cite" cite="mid:ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com">
          <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
            Regards, <br>
            Christian. <br>
            <br>
          </blockquote>
          There are 2 situations:<br>
          1st time creating list n_regs will be 0 and trace event will
          not be triggered<br>
          2nd time while updating list n_regs is already set and
          adev-&gt;reset_dump_reg_list will have some offsets address
          (hypothetically speaking&nbsp; <b>during reset + update</b> read
          values from RREG32 will mix up of old list and new list) <br>
          its only critical when its freed and n_regs is not 0<br>
        </blockquote>
        <br>
        No, that won't work like this. See you *must* always hold a lock
        when reading or writing the array.<br>
        <br>
        Otherwise it is perfectly possible that one thread sees only
        halve of the updates of another thread.<br>
        <br>
        The only alternative would be RCU, atomic replace and manual
        barrier handling, but that would be complete overkill for that
        feature.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        <blockquote type="cite" cite="mid:ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com"> <br>
          Regards,<br>
          S.Amarnath<br>
          <blockquote type="cite" cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
            <blockquote type="cite">+ <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len += strlen(reg) + 1; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; } while (len &lt; size); <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; adev-&gt;n_regs = i; <br>
              + <br>
              +&nbsp;&nbsp;&nbsp; return size; <br>
              + <br>
              +failed: <br>
              +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;reset_dump_mutex); <br>
              +&nbsp;&nbsp;&nbsp; kfree(adev-&gt;reset_dump_reg_list); <br>
              +&nbsp;&nbsp;&nbsp; adev-&gt;reset_dump_reg_list = NULL; <br>
              +&nbsp;&nbsp;&nbsp; alloc_count = 0; <br>
              +&nbsp;&nbsp;&nbsp; adev-&gt;n_regs = 0; <br>
              +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;reset_dump_mutex); <br>
              +&nbsp;&nbsp;&nbsp; return -EFAULT; <br>
              +} <br>
              + <br>
              + <br>
              + <br>
              +static const struct file_operations
              amdgpu_reset_dump_register_list = { <br>
              +&nbsp;&nbsp;&nbsp; .owner = THIS_MODULE, <br>
              +&nbsp;&nbsp;&nbsp; .read = amdgpu_reset_dump_register_list_read, <br>
              +&nbsp;&nbsp;&nbsp; .write = amdgpu_reset_dump_register_list_write, <br>
              +&nbsp;&nbsp;&nbsp; .llseek = default_llseek <br>
              +}; <br>
              + <br>
              &nbsp; int amdgpu_debugfs_init(struct amdgpu_device *adev) <br>
              &nbsp; { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *root =
              adev_to_drm(adev)-&gt;primary-&gt;debugfs_root; <br>
              @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct
              amdgpu_device *adev) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!debugfs_initialized()) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
              &nbsp; +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;reset_dump_mutex); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ent = debugfs_create_file(&quot;amdgpu_preempt_ib&quot;, 0600,
              root, adev, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;fops_ib_preempt); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(ent)) { <br>
              @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct
              amdgpu_device *adev) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_test_ib_fops); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_vm_info&quot;, 0444, root,
              adev, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_vm_info_fops); <br>
              +&nbsp;&nbsp;&nbsp;
              debugfs_create_file(&quot;amdgpu_reset_dump_register_list&quot;,
              0644, root, adev, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_reset_dump_register_list); <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios;
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;debugfs_vbios_blob.size =
              adev-&gt;bios_size; <br>
            </blockquote>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------Cedu1Iu6pAA1s0vMS2yPV7qI--
