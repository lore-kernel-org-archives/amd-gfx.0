Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B910BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F5D10E576;
	Tue, 15 Feb 2022 14:39:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A0E10E576
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 14:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/dTi4eh5siJrN91vgyJeN6oiiiSRYE/cN/q/QK0I/XLoJ2pwYCL+eyx9YlTJE4FJ+UFGZTaaAgm90oqNimuC3S7yqKHMCEBUt/3Z5Th0ScceHwhpVhMZWh0UqfIxd7J/J+rpwSxgsV/rjqShgD8Byucl6FAMxhMD2H7+unJfoMjivtLB3ASSpoa3xjGZKOGiJ6wxgyio5sNbn/8xIa2HGU7bO3BL7I0QnXBREBMTBgASc9sNJmjqn8IBa0XVolAS0xsHMCuiuim/Abs0KiTBy8FvKkMepTEI96PxrtGT0ki6Q0q9/0bLPPqT9jeaNXCPjrp2VaTVhj22tADUDR54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jne9RyJQQMoNMyYgHProjclJxsJ4qePfSqjnqTzD1So=;
 b=F6XOrdrDXDPNB1qrzm9Hj2Xg+tB06VccC7viYBC8l38RoJZxv+pCKQ/dp6xxID9HMjJkchdCg+XA9Df5MsDfbVO0aVhDiCopK2KVJCB6NSh2ncVCnmnXDc/ohYBieVsmuK4s9wW8zBZ33wsJ40rnqJX6gf8Laxi5jRnbmlVWqzmAtCGLlYdr/AAbq5Q0JTXyhMqTR/meRUmERSMWsU39GkZ3yRcpLw7ipZjRruRHk8myFWP0yyMqX0FVVCA+NmAB09mLRENJfKttSI51BBa50/cKbUTz4M1k1fFeeGwQDseHaM7/5cdGUBgMyPP4sMxh5yfyyZfiMDnY2T0g8Ldg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jne9RyJQQMoNMyYgHProjclJxsJ4qePfSqjnqTzD1So=;
 b=qm/zvfS39gLKn/Y00p9AwXfIYgV58rrOwMkT/IQbK6T8wHaIoZFWBRcrs2e6pVqZMXflG/BtVibc0cytrgpD5AwuAtU64JJBhS/8plQcMpMfcmTIsPhEcim97ruxkeVXt4frNZrbot+HFBAeld8AtggFXEvwtq84ppkBVtIk2wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.14; Tue, 15 Feb 2022 14:39:32 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:39:32 +0000
Message-ID: <92035d00-a490-ca2e-f3f7-5fd910c55e74@amd.com>
Date: Tue, 15 Feb 2022 09:39:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220214231857.5129-1-luben.tuikov@amd.com>
 <20220214232154.6421-1-luben.tuikov@amd.com>
 <a0bd54e0-142c-a8e9-964f-25560e35177c@gmail.com>
 <62f50472-fdf3-86d0-edc0-69c56e9de24b@amd.com>
 <699b8634-ab4d-db1b-8226-743956c3be41@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <699b8634-ab4d-db1b-8226-743956c3be41@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::31) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e36cc0a-71c9-4094-e522-08d9f090face
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB46213E204F7B976BB4BFC41C99349@SN6PR12MB4621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwJpuAaT7Wwd/kfSL5ofSfNsIW35aDzf+2Ln/i+TZ2TWkTronzK2a4WBx/a+LSf/2B6drxnAvLYwaCrDAE6Ixy5+D/Iqvr9qd0+COU2hdhgWjphbSQIPWpmC8LMPE9G9ih/R9d5SYkXl8wkac243Q4po0BR7IOZzw4KKdz+u/t213iajqPUHt8n4u5j+hQrIdZTiwgEmrOkiwzGivEtODn3UtOak7TAUtTnBla+6Hdk9X8Pau8A05fca+sJWh+V+7K6ZBS5k4Lorp/aYGokJDJPUj/V1nDjmPCbRj8AmmUYRCCI2txyP7SAd2W75AyqVNB98PVYg9iL3NHP/JqmNoMEUmRigHJg01FzUUyVsE9AAwY0zoO9fGK/i5bbe+44+xLtJ8RwTnNpYSeonn+nMBxyyDSThB6QGVBV87omsuug5ifhyZTyBZIuL2tzLkBz0JDV36pJMtWRLXxj2U4AZCGFkoMSj/oQTYdIrNEELGzxLmuCSMhAO+udGVLfPS6j5cx9gZ0yYfU/OgcmSP4jYR4Ffii/Jh+2GQu+KBJ/a3L4WEGZUKwzzuI58wWd4zJv7OkL3h+GBrgTy1IvS/UmV7PncGzBIgOQB+QWC8OFafJ/ua3svIzshMiaueM/N8AtVQJy0F7eyB1v945D4Aiq0Ac8iOylqelUKRjqeJnmxsQ5ajZqiO84+XqGbRfoEBvwq7MJrmzNSNzGf1mlzxUNZkENjvZBr2Md9pfYNikntNmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(31686004)(2616005)(53546011)(2906002)(26005)(36756003)(6666004)(66556008)(6506007)(6512007)(508600001)(66946007)(316002)(86362001)(6486002)(38100700002)(8936002)(4326008)(44832011)(5660300002)(31696002)(66476007)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2hheldlM1NHWmdTTmNqUjJCYTQyYWxDNFUyZzZReEVFSDFvSHFnaFZHaFB4?=
 =?utf-8?B?eTB4Q0UxR1FZUSs2TGNveTViTFpmRTBQV3U5ZjVna1A0QUwrcGgvMVVtLzhW?=
 =?utf-8?B?WDRQRnhsTEJUQnk1Ri9DeHh2TGw0M0hGc3BkNVlBODVGeXpJNGhUaWc3MFNk?=
 =?utf-8?B?QStsMFhnWVVvZlYzUkxmTzE4NkQwTndMTXFJL2xXS1g3MkRXc0dybktzQi9T?=
 =?utf-8?B?RnJlLzgzYVIxZUd2VWpFY3R6bEllK3ZSdzZZeWRGTmVJUGR2Vm1YNHJOL3lt?=
 =?utf-8?B?bDNQRUhXR3dtcExrTm9pOGNyVXBHdVRvMTdWZzh4NlFMUzBORzRTbnJZaVAy?=
 =?utf-8?B?a1ExOXF0ZlhkTkhHMk1JQlc2Zjk1cC94Mm1YaFlUbUZQUDBXTHgrMmhnTGlX?=
 =?utf-8?B?Mkl6Tm93YUc5djczWnR4NGRCMCtLdnJNbnJydEJZQ21UemlvQVhuT1ZmVlZL?=
 =?utf-8?B?RTlaSXR4SmdsTElycG5wQ1hUNFN0N2RHTGNjcjdScWpsQXovTnd1ZWU4UUZt?=
 =?utf-8?B?NlVyRGNkWS9QL01UV05XWDU2bG01MFM2M3NoWlpFb2w0V0ZCbVJEbVJlUkdQ?=
 =?utf-8?B?UDREYXIrWXZJendDVkN5czR0K3dyUFVSWmhQS21xVm13VGZibUdFaDhzM01U?=
 =?utf-8?B?L1ZScHhISWRsU1VCdUpaM05Wak1IM2JuMjFkenI2aHlRMFdXeGNWeE5BOG5s?=
 =?utf-8?B?ZlZnVEdFQlRIOHBDSG4xUW85dVFXNU9hdUJJSmVob2MxakFwbGxHT1NpUCt1?=
 =?utf-8?B?bTVjemxtV0dJTE5pWE1TV3VTVlAvMkZLbW1nU0U5TlVCUXg5NFFidXQvSk1W?=
 =?utf-8?B?cGZYZ0VncUVOZVlpeGdpTlQ5aXRpNkhSdXJQOUVwR2pSaHluSjhpMzkyVFJM?=
 =?utf-8?B?YUtIeEViWXIyS1JnRnJXSmhxNllJMWdWSXE4RjQ4NHp3d1hEK2dMcDUxK2lw?=
 =?utf-8?B?d3NNWlErd1luSWRVdWh1ZzhTNFN0VWdTVEI2OEQ4dWVXMVU0TVcwRlJGNEpD?=
 =?utf-8?B?RWt4bE5ZQU45ZkpNVEUweEt5YjB1SGp2Rm5saENlbHUwcjlvdHZ3YVB3RU5z?=
 =?utf-8?B?Q3UzYkw5Vjhyays5Y3EybTBudXFPNGlKOWc1N2tkczY3Nmh1L0lORVhZSEFY?=
 =?utf-8?B?SHMzOGZBM0RRTDhCVzlKL1dobFdXUzFiZy9jdWJMWGFkV20yb2duOG9wdjdV?=
 =?utf-8?B?TUFZcy9hZ0lGTzkvVVpRektmVDBNbTNtVlgvei9wVTFwWVV1eHJnYUY3SXlr?=
 =?utf-8?B?b1E0STV2QVRkVUpXTEErMDUwVThlc0I4VTd1RlFBQlREWFZsaURmWGg0eUdO?=
 =?utf-8?B?dHIvWEI0cDY2clcrTDJHcEo4aCsxWmR1d29yc2UzdFRpT1V3UHZ1RU56V21W?=
 =?utf-8?B?Ymc0S2JZSFBXSTVpUWxxazluZ2lCYkp4Zk0vdlY1bHlCSnF2MnMrUVpZeGI5?=
 =?utf-8?B?ZzhVYVRLWWZ1T1F6UnRuWVNzQzUwcGdic0Z3YWp6Vm40UVZiNVdCZmZna2xx?=
 =?utf-8?B?OUQvYzEyRWxwSjg0cTZBYllHQXRMVDFsdy9IMTJVUHNqVGFsdkNwNExRblo4?=
 =?utf-8?B?eTRZWGZOQXNjaGhrMno1RUU0SXZtaEVQOFZnQUpPLzFDbExneGdEWmZmOE5r?=
 =?utf-8?B?TDFiczVJNnIvYk5wdEdCOU9hNnR5MWhFVE9oVnNmaHR0Y3pQS3BKdWRPOU02?=
 =?utf-8?B?d2RhVDhRc25nVWhDYjd2VldIYkZlU0EwalJXVGEvU3UvUWhjTnd4NVF5U3pw?=
 =?utf-8?B?NzFSLzA5SHVkY3Q0SUp5aVpqamYyTkg2bUtuTFdMeXJKRjNmYStISk9DZGFI?=
 =?utf-8?B?VVd6amNJMWtQaG13YUNJcDF3Z1lqUGpYUW9uMDNObFB1N1NjbWJuelhBS1E1?=
 =?utf-8?B?SVJLR2ozK2ZZT3RReWtwaS9CSDhrWHpEV0xTYlRhNkZhRnRRaFF3c3FVV1Zm?=
 =?utf-8?B?emlUUWpRQis5dnFiZE95WWJqZ0dPY1lCN2ZWcXNIRUtZMnc1ZEhZWVJHYjlp?=
 =?utf-8?B?RGJGU1lnNkMrWFBERk10bkF1VVVBbCt0SFVmdVg1VG5HVEEyT2ErZ3dzTWoy?=
 =?utf-8?B?SW9KTVNiN1NaL1c5N1FtMGJFOWVzMis3YUxsREhDbDZPakhhVHJyZGljL0FK?=
 =?utf-8?Q?Znkw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e36cc0a-71c9-4094-e522-08d9f090face
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:39:32.4861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Cnntaavf2JMz5vT1LS5sG/iu/N5skhJ1WAN5VCWmobw/b+ZeUgKP4kxJ4QngYOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4621
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-02-15 09:37, Christian König wrote:
> 
> 
> Am 15.02.22 um 15:33 schrieb Luben Tuikov:
>> On 2022-02-15 09:25, Christian König wrote:
>>> Am 15.02.22 um 00:21 schrieb Luben Tuikov:
>>>> Add the "harvest" field to the IP attributes in
>>>> the IP discovery sysfs visualization, as this
>>>> field is present in the binary data.
>>>>
>>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> index c8dbdb78988ce0..0496d369504641 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> @@ -393,6 +393,7 @@ struct ip_hw_instance {
>>>>    	int hw_id;
>>>>    	u8  num_instance;
>>>>    	u8  major, minor, revision;
>>>> +	u8  harvest;
>>> Should we maybe use bool here instead?
>>>
>>> Apart from that looks good to me.
>> Thanks Christian.
>>
>> I don't mind using bool here.
>>
>> I saw the field in the binary data is 4 bits and represented that.
>>
>> Is the field actually bool in the IP binary data?
> 
> I'm not sure either.
> 
> I would have expected it to be a single bit flag in the binary, but 
> 4bits sounds like it serves some more purpose.
> 
> Probably best to stick to u8 for now in this case.

Okay. Can I get a R-B then?

Regards,
Luben

> 
> Regards,
> Christian.
> 
>> I can change the patch and resubmit.
>>
>> Regards,
>> Luben
>>
>>> Regards,
>>> Christian.
>>>
>>>>    
>>>>    	int num_base_addresses;
>>>>    	u32 base_addr[];
>>>> @@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>>>    	return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);
>>>>    }
>>>>    
>>>> +static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>>> +{
>>>> +	return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest);
>>>> +}
>>>> +
>>>>    static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>>>    {
>>>>    	return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
>>>> @@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
>>>>    	__ATTR_RO(major),
>>>>    	__ATTR_RO(minor),
>>>>    	__ATTR_RO(revision),
>>>> +	__ATTR_RO(harvest),
>>>>    	__ATTR_RO(num_base_addresses),
>>>>    	__ATTR_RO(base_addr),
>>>>    };
>>>> @@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>>>    			ip_hw_instance->major = ip->major;
>>>>    			ip_hw_instance->minor = ip->minor;
>>>>    			ip_hw_instance->revision = ip->revision;
>>>> +			ip_hw_instance->harvest = ip->harvest;
>>>>    			ip_hw_instance->num_base_addresses = ip->num_base_address;
>>>>    
>>>>    			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
>>>>
>>>> base-commit: d8604f1d237a145db48bae4ea60b85a5875df307
>> Regards,
> 

Regards,
-- 
Luben
