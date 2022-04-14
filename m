Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F51C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 14:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F3E10FF8C;
	Thu, 14 Apr 2022 14:31:31 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A151C10FF8B
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 14:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK9+H63xD/RmMtt6CBwGJ8eS7ebOCnWOyYfv5WZNII3UrzCasjjO4ktXdYHf7rg+Kw9dqEwxO7XZZY6jAOJvvrMP5HvC7IkkIALzH5OgpJPvMjT72NAqoZ7JLn0aP2XW1QFLcboC4FwP/kHxMP/vls3YQBHAz1Xips/ZwA3GDoa+TuqX/HbZ3K+4jm8ir+IW9PXi8wEGNvlbkNNIa4hIUIyTBnOk1JNHQa/oUlCuHTHl2/+l5Pm42tCelDHbM8gbCm9e6s6JwwSy2UbD1ONRoOIu08MqpIerRq2HgJLh0C/k91M8HDHPXaOWdR9xDIpHxF2bFW04JwYMhxKKscV4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS036NFH9AvPvXnpeOMO7E3zhoYQKoD2sXehzLshPdQ=;
 b=C/4Q3XUBbtQ1Nrb/iYOgAHkMmTeKW7QmAKFfLzy0TVyoaFxKfsd2xtRZEYHrs3uSqdh0MY187oe0CyGkQG8jgbCuhCmLvbtAwWMyIj+yjEzJeZj2DR8qmdTRnGS/cXl+bT6lpPDPWn6F/XZZGs8sOg9hrFKa14D8rtjBhj4Tc12keVnSP2vDl8rY6sgvDLGwbO+mrg8w+VxcfjNa6Sktu4XDkRmWmH17iJYAApXCrRkveVbl1ENVcmgHEcKlb1COd2AqH4h1RB/6Ez7/UIEMRIxwITTboxLh/28AO5DTxg6QhJnqBkgoo0zGS5NLadfN7xIqtqmgA0wtG7F4/bJs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS036NFH9AvPvXnpeOMO7E3zhoYQKoD2sXehzLshPdQ=;
 b=bZIiLAlpYWrNIiwvlJqB2rItqwwroNGXk5zH1S2nLRrcfaHTa0/CDc66U+wtbm2hsGK+Ll05Nin6cikII7sVhFKqsxglRDqKraCK0cPgqDkn7qYmvt+FnD+d6vS33Bn2oXUz4LLtYylR8yXXzhetRaKwdWde09waFncLQzhhZlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN6PR12MB1890.namprd12.prod.outlook.com (2603:10b6:404:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 14:31:29 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 14:31:29 +0000
Message-ID: <66dc1d41-2692-2715-c4d0-1d0cc12eec19@amd.com>
Date: Thu, 14 Apr 2022 10:31:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Move reset domain locking in DPC handler
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220413193100.154102-1-andrey.grodzovsky@amd.com>
 <378bf20b-8888-2efb-44c7-9ec2d28ff01d@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <378bf20b-8888-2efb-44c7-9ec2d28ff01d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9570b5d3-a38d-4091-c333-08da1e237687
X-MS-TrafficTypeDiagnostic: BN6PR12MB1890:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1890CB84DCAA551782FB37F4EAEF9@BN6PR12MB1890.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDkIB7oeQslnIwh+Mct+IqztV+ZB2wGZC7v8nq8bOPiTJuyxmdo8kLxas47OizEFWlIeHftiuvt3emBWq1BfMfQLiZvUMsKqlNEdGiNV09C6qu/58CfSnJHFlNQbKS5pwsLfGyLCbJpVpBw/0Go0hN5f7CzfDcIhRZ0AmpXrnQaSZmxhCItMmFQrCskMDNsjZZIU21kLZNQhvoLt7kOGfEeKfTCGqW6t1D/Ys8X0Lr32B2B8RV2+cbGqEqhpPFEXJHcri5DAysqTJ+CYz3cMJUDOJAHkCMaG7sSl+DHGsdoW+3sVXaub/VPBXHXVUP29/J6PWpbiRM9sU+1aQIU2kqgBi+PGvoPR5zfy5Gq/m//HqkQuY8a9+3Gn6dof2Zv56RPjxDt9lW++A8kRgeVSaJrjX/WVz74H7PjJihQraWRN2O3WrWJIO3VPUUX/Jn2CnLboHwfyV3YSG7NsjMcgPP5eyF5U76HbzT94j9JQuC1QQFEwDgecHwnzCoxns3G8tn3nMHRo+oLYLy6XZQOQn+Begcy4NEUZ++WdpD26JlTc9PY4yEcZlOqGofs/LI8qiTC/cZ70x5vm9/YW0ZiV3fQG/74+YH1FtWWKX/poDHDShno7ok30Mm4LpS3KyCFRwTPUjVTqYNCKRzTziP3NfT+DJdkEa64NcZ3c6/HrD4gdsfRxh0jBlsp1E+pAfXcmQ9N8KBuOS1/Wqywh4t6dt0dYN+BIGCflpy2Uf7/zsQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8676002)(2906002)(66556008)(66476007)(38100700002)(66946007)(36756003)(6512007)(53546011)(2616005)(186003)(31686004)(6506007)(83380400001)(6666004)(86362001)(66574015)(6486002)(316002)(508600001)(8936002)(5660300002)(44832011)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWlOL3RkRTFQdkNKdmJXMXlPcFc2Skw4a1B2MTcvdGdjZHR6bDczY3pSZUdS?=
 =?utf-8?B?U2N3NFc3c2dMN2xhaUlYcWI4bHJMQm9jM2J0OU1wV2JIQktqUUN3RFh3WEdW?=
 =?utf-8?B?OUJ5UkJTSkhPYWtWSWh5N05Sc3lRaDY4Z1Jhcks5aFpKa1dDTWk5SVh2NW1H?=
 =?utf-8?B?TDhQbkwvRU9CUlFSQnF6Q2RacG9vaGpnY2JNK1NTdlNpWDgvSTc0Q0twV3gz?=
 =?utf-8?B?enMrOElTaTd5UG83Wi9TYmhBNk4rWStBOWQ0YzRPNzJ0WGFHeDFva0pDRTBU?=
 =?utf-8?B?K0d0OWtEZlRjY3FRSy9RWUpKcUl6Z1dPcWJFeUtHanZ6cHhIN05NVjl6a1dQ?=
 =?utf-8?B?Nmk4bWFUUDl6Qmw4WmhmWXp3QjhRY09MbFRSRDNzK1F5Wm9INyszTWNMd3J6?=
 =?utf-8?B?eExRMUNVS0tVZkFFbEdGK0lwTkoxckhUTUhjakgrazZqbzFrM25aZU1sM3cv?=
 =?utf-8?B?eERMTkNveTdaZm8xL0dpZHczWFRFOUZrRFc4R3pneThaNzNxaXFIVHozQmNv?=
 =?utf-8?B?T2xtMDBGVG93a2pCcjdYVk1PcjRObkd6aW13UWVUZWU3R0dCMk1YQkdnWlJV?=
 =?utf-8?B?cG8ySzZsTTFJWFNNRW5reGZjcktmR3lORUgwYVFGMnU5OWwwVldtMThuT2hq?=
 =?utf-8?B?YndxMURVWktPT3pKeHpkQWMzNVhyVzVYUFR3c2p1RnZWWjFmb0xhOGMvbTZD?=
 =?utf-8?B?OWZmUzNpNkNIai9VQWhpRW0wdFVIb21FV2dRR3BwSFpiUDJIU0RDVndpUFhv?=
 =?utf-8?B?SldiTUIxcFkzR09ib0xHNzFZR21KSk1UcnMwc21zMjVpRlpIZ2Jadm1KOGtk?=
 =?utf-8?B?d2JTK1VNVkY1NFRXM0JDNDQranZ0cC9nN2VGZ1lqSE4xbkJBK0U0Uzg2YUNw?=
 =?utf-8?B?Z0I2RmZLVGZGbVlOVGoxOE9DeVlGWS9nME1hZjFnRnE5enRFd0ltTFNEOStE?=
 =?utf-8?B?OS9ScmkyeEUyV25ZUkxDM3YwKzdlMGlkekU2REtpbkkzWHI5a3FYeXVYZFcv?=
 =?utf-8?B?OVlyYTRFeElPQU5YOFhBS3hta3phdnhFOG1GZDZZem9Ec01nTUQrOHp4Snc1?=
 =?utf-8?B?bHhJSDJvNVRnbjFwRVJWa0QxS00yMTZ2VTFyeTk1VVpOWStjNzkxbGZ6bTNx?=
 =?utf-8?B?bW9JU2VNVlBBR3JwWVRIYzN4ekZlWmNwbXo3aXpmVmhzdW9YNU0zYjhLN0Fx?=
 =?utf-8?B?TE1oY1I3RHBVTnVpUGIrdzhsTzZDVzNBeUt6dm9lRzdnOHlla1JOOE5VbmRY?=
 =?utf-8?B?SWx1cy9zajlHMzM5OXFPODZrQ05qRGtMMmxhMjQwekxjY09FblhsUGF3R1Zp?=
 =?utf-8?B?WS9hM0F1NktqbWlqZ1lIb0hxTkV4UmN0WjVZb09iTFJXakExWld1NFBDUXJB?=
 =?utf-8?B?NzJzMXZqRDk0M0xjbElHWGwwM0d3RW5xMnhwaHJCNzlKOE1oSlVVSzlMR1BE?=
 =?utf-8?B?L1ZXTnM3MmJnd1VxY09DOU05K3hsSHJqdmNKWXpKdUs3d0hUN2VjUDdJYi9N?=
 =?utf-8?B?VDdhMWp4V1F5UzBVd0pFY2NpZ2JOUTdwTXBiZWd6Wlg0TWhPUS9mVGlLVkd4?=
 =?utf-8?B?S3JQS3dmTFpSUjd3ME5oaEdYbWFSVk1BWVdNN1hUMFprWUlJRVkrN1RyMVZz?=
 =?utf-8?B?K0ExaFA0bDk2eVNDQ0hUSURVd2V3TFQrMzFram5tYktUMjlza3lDSDl4c2JT?=
 =?utf-8?B?QjJZWGk2UmpYek9UZ1dRKzA3TDJyTHZybjVseUJDQmMrc1RoaWVVZGZpVDN1?=
 =?utf-8?B?TkQ5eVNmaFAvRDdSdzVQSld6RW1MWHYwVEM1ZnRiSmJpaGRZNENsSUhiaWt2?=
 =?utf-8?B?SjUrZmwxY2hsT1FuUDZFa1lNdWdQQWQ1OEYvOXdkdnJJTzAxU3BEWU4yTHpQ?=
 =?utf-8?B?aG9uZExjckZrb29wODh5cllsM1MwdXJzdlN0MWJ4cXY1empxYkFTWUhEZ3BT?=
 =?utf-8?B?K2RBSHhVTG1URC9tQWZmQWtqMFBNRml0T1ZyM0ZjNkFOd1ZVckgrM1NTdVlo?=
 =?utf-8?B?Zzh2KzM2cGMxQXY5RVFLK3laelFTcXowaDR6VkVtZEF3Y2t6dXYxYmowcnRC?=
 =?utf-8?B?QUhSOEVyYkYrd2FMWU85YU1ReVNWWmtHbVlIakluR3VWU2xlRk5kcDdzUGFz?=
 =?utf-8?B?SUVBTXBUS3NVak1aTnhBd3ExNG4rQjdHVkh6dmNxRTY5aDZkSUpmY3dwVG84?=
 =?utf-8?B?SXlTb09DZWNXR1JGZmZiVlpXUlpDM3hzQjVUSUJCN0gxQkQwVTBSaklGTnFN?=
 =?utf-8?B?T3ZrcU5wR01TK0ZJYzQzZkNjT2pWZ1pEK3Q3WEdwR3ZjZXNkZnR4WklMYTlD?=
 =?utf-8?B?Y0ZEL0ZQWDN4bWZ3cTVGZDNkNmpKdGh6c0pzdzRPRGE1R0NFR2EybUJGRnor?=
 =?utf-8?Q?uT/Dlw1IFKatTpGKupvnRdY82RIlE6qt20cYz8y5Z8bQZ?=
X-MS-Exchange-AntiSpam-MessageData-1: Ba7pITDy2CE/qg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9570b5d3-a38d-4091-c333-08da1e237687
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:31:28.9206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMD3BwSUpKtqXEkFNCOJM8Xjmt9VBPLKfjtOrJhl04jpA317UOsiSWdNCb/3+g/X3i3AcoV969YkQvhCh7IVAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1890
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
Cc: anatoli.antonovitch@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-04-14 02:40, Christian König wrote:
>
>
> Am 13.04.22 um 21:31 schrieb Andrey Grodzovsky:
>> Lock reset domain unconditionally because on resume
>> we unlock it unconditionally.
>> This solved mutex deadlock when handling both FATAL
>> and non FATAL PCI errors one after another.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1cc488a767d8..c65f25e3a0fc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5531,18 +5531,18 @@ pci_ers_result_t 
>> amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>         adev->pci_channel_state = state;
>>   +    /*
>> +     * Locking adev->reset_domain->sem will prevent any external access
>> +     * to GPU during PCI error recovery
>> +     */
>> +    amdgpu_device_lock_reset_domain(adev->reset_domain);
>> +    amdgpu_device_set_mp1_state(adev);
>> +
>>       switch (state) {
>>       case pci_channel_io_normal:
>>           return PCI_ERS_RESULT_CAN_RECOVER;
>
> BTW: Where are we unlocking that again?


In amdgpu_pci_resume, but you made realize I can do this better.
I will be back with V2.

Andrey


>
>>       /* Fatal error, prepare for slot reset */
>>       case pci_channel_io_frozen:
>> -        /*
>> -         * Locking adev->reset_domain->sem will prevent any external 
>> access
>> -         * to GPU during PCI error recovery
>> -         */
>> -        amdgpu_device_lock_reset_domain(adev->reset_domain);
>> -        amdgpu_device_set_mp1_state(adev);
>> -
>>           /*
>>            * Block any work scheduling as we do for regular GPU reset
>>            * for the duration of the recovery
>
