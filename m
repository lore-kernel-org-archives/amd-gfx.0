Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF15C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 07:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ACDB1131C8;
	Tue, 23 Apr 2024 07:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aeO+hH9q";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138D01131CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 07:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ina8msZl/C8yXDGwwRtm+EO+W8yzgH4sL+tQRHJqVjcB+jM71vP8Xp7hzAhHjzdGfGGompH30PedH9PGqTrt3Sh7kGgtzy2wc2a8t7WKCzGpmwiKDGDAgLZF0/J7LeiNVF1xV5gGEf/iJt1Gl2+Iu2zFF0XvRPqoT4qUsfyDgK/k52hOtC/pITIrce/q6tLvzjYidqxq0jjft6uaBNQVMuu2QpJ/mANbChxyuzur2N+QLdN0wgdAkZNWxbrXa/kdVAvnsYWaOdjuJWUsRwgwt/tuLvch++a3mDoaCQ6v6LIdHgnoLjiiNHd5sOzfvAOAA8uZb5qlXLOio6jFhEP8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk2oHTr7UEPMXExI4EOugqTfcN7WrW9msqASwGYGKE0=;
 b=LlwJuVykyCNAvjOd3tGlOFhXxIg2DCPrq5nqOMx+4EfUMsOdarvB5ccjPFncPAl6i2z7Q64e2uLXiw0mPIo1HNLHPxMLq601s4aAJFCpZwbOSqhlMSyFPdmIZg9QI/9Kfe1CxBb04tm6BKmhb/y+p2PRJEuNDGEhv32fdshS9B6m4YTvTE+DnEAhaoNutfWFJT+SoRJAhsUqYdgtv+yjMHnWfgbI+ertIPxKWEitvAaO/gFxj+iSx+xEpHJlmrvOtv/aPGT1kDgc2d6iMFLVqtFCK6K3WJ0SgnMYT9qHbgKQb9QPcJeBGjl96niWUOYNX8zssoE237ZoU9M4UWiX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk2oHTr7UEPMXExI4EOugqTfcN7WrW9msqASwGYGKE0=;
 b=aeO+hH9qVsbv6oriKshbKXDBBFqVB8QWJmrEI+kAyx+kJabpx0IPX5SDWJ/eIRTgtsNnctaDAQocjxj0xwTF686gNlM6MTSXcI+d76dY4X003tRhbwUZgTzZXjTiXeRTa/xjARv3rkP1AmsxTbpl4YKS6I9p2eeWG1pRoFY3/XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:41:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:41:15 +0000
Message-ID: <ed766f80-357d-4b24-9071-042332641f60@amd.com>
Date: Tue, 23 Apr 2024 09:41:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
To: "Zhou, Bob" <Bob.Zhou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240423053334.884670-1-bob.zhou@amd.com>
 <5fb6b05e-0e50-4a0e-94c3-c40d96150f61@amd.com>
 <CO6PR12MB5394A20AAB771D483B54783494112@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CO6PR12MB5394A20AAB771D483B54783494112@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3a3254-cc31-4e76-7c96-08dc6368c0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnliMmNxRGlRelNjYjRBSG5nZEQ5am1tNjR1RnBoWFlndjh5RjF5YkZhNkVo?=
 =?utf-8?B?cEtpSVhDeUpNSUdKN2ppZzRkSzhuU1FZQjhCYXNHeTZtNmVRem43TUhrME5F?=
 =?utf-8?B?OW9BSTZ4cmFHZzlFdlUyS2pTaXFIaEtHWXpCakkydXpNRkJwL1F5TDZxWEsy?=
 =?utf-8?B?RUY2WGtKR2Ura0Z0SHlSZkdrL1JyN3M2bytGZXZVVEY1NkVBbVdySUJhZ1I0?=
 =?utf-8?B?NGZ0T0puQTA3V0hGQ0RZYXgvYjdOb25nRlNvRHp2ZjhNMUREQTZoYWdqdEhL?=
 =?utf-8?B?b3F6ZTB6K054ckloYm1CSG43MUNOeE94Uk1VNHFrNXZwaHg4VjI4a3hnT2kw?=
 =?utf-8?B?akg4RlVMb2hLNkdDelJLWmozUE1hcWlJaEpwaW1hQTdDSDA3dG91bWxIVjlN?=
 =?utf-8?B?bDFRMmJnVk8zQk9nMzcvZ01wR280dE93a0dYcENzeGdSWEZJdWZ6WU4ydFpE?=
 =?utf-8?B?UEJ2NmhPZGd4OWJwbzNTY3dYd3RZbTdjY0UzekhSWm9Ma09EZmlNOU5FRE9H?=
 =?utf-8?B?b1IvSHVvQktTc25pdE94cWRzSm9wSHZLVWZqUFA2NG4xVjVQcVFjMTdiMWwr?=
 =?utf-8?B?QlZQV3VjOElreHVGUlk0Y3d0Qjd4S21Zd09vbHYyL2NsRklNMnRndVkxNm5n?=
 =?utf-8?B?NHdqOWg1YU80by8rTWcxQXZQNHp0VDJGam9mTExDQkROSk1wZTIvbEExQ1Vi?=
 =?utf-8?B?K0lZT2toTHlCaXNKM1VXWWFpUEU5NHc2bHloL1I4T0FJbDBCMlU4M0w3VkZX?=
 =?utf-8?B?d2U1WU9odnJmVFRvK3NhaHdkTzRmNVNXcFcvem8xOHRqRUJIaVg2VUw0N0to?=
 =?utf-8?B?Ylo0TzdRazl3dnRyTWxsV2tFbGJ5ZkYrK0UwN3VobXA3QWtZQ1gvT3o4VmJ2?=
 =?utf-8?B?cjVjQzZ1UmlIMnNtOXhvRHhtQXY0cEt3NzRweG9ZOEZrazY3bjMxaW9XT05F?=
 =?utf-8?B?VnNhamtIbC91bmticFB4OGYvdXE4ekwzYWNkNFAyU2IvZXdVcU9tSUdyMzNt?=
 =?utf-8?B?dkZmZ0pKQ0svZzFtSmRiV1pQZ3BDY05kQjUyY1QrRm1nVkJtN0llNWRzZzRD?=
 =?utf-8?B?ZzdjZmhlQTZFNSs4TmFqVXZPUllJeTNYalJkeFNhVjQxbWlBc3E0UjErRW1E?=
 =?utf-8?B?QVc5VmdrNU1yVERwc1Fxa0xVVXdwNFR2TUQ2Wm83RVVrNVJUTGdTVU1XVDdV?=
 =?utf-8?B?a1E0eWpkSEcvaTc4SUppL0l6bDFTR3lqbFllZGNtc2JSSGlmdjJZRzNtRERT?=
 =?utf-8?B?Vi9mMm5tT2JaNE0rZWltdFAvc000bHlpN1JXNDEzMVpNRUxWQkV2dGhzWHhR?=
 =?utf-8?B?YllIZDVJeVhIVk0zUjNlMzhWVnU2OWhJcGRCaWw5OUVPRTVqTEt0cjhFQzBr?=
 =?utf-8?B?TVNyNjlkR21zaUZzOHVwNlNsM3owMi9BT0J5aTl3NGhSMlQrUnZJRk5ValNQ?=
 =?utf-8?B?VXZGWGg3QWhGS2UrZmoreCt0eDNlOS9ISVBCRGVIdzZwSHFpSEZNWDZpb0N1?=
 =?utf-8?B?L1B6NTFycVR6SFJ5VlBubnRZTFQvV1VtWjEwc2kySjVLemE0ZmZiUEsxY3Bp?=
 =?utf-8?B?NzZDM00yVXFHNDZqZFY5cWcxRkFWU3liVzhqd25wYktLdG5iQzl2d0Q3ekpk?=
 =?utf-8?B?ZmV1bXFBb1MvU0hhcUtwU0tnV0ZTMW9QUDdtbm5zTENGanJrQnJXaUdabXFC?=
 =?utf-8?B?Tnp5MzVNYnhMM09PcW9rdWpxMElOZDdZMlQvL3RxbDU1RE5QQk0wY2xRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9pN3hrYzdzNmlCbERPV3NWelFVQXNtQVA4MWlIUjFHSWJQenpzNWFLNktP?=
 =?utf-8?B?SFpZcDVSWC9mT1lhcG5lV0xqNTZXYml4ZDlRTm9HcHVCUk81MDF2RXViOWVu?=
 =?utf-8?B?U0FjVDEvSWNhNU1JRFNkanJYaUxEYmc1d2Z1anQyMkZFU2t2MitqV3d2SHJI?=
 =?utf-8?B?VmdVcmMwNmlvVWFTczFXa09xQ2dSeWZVQzV4NHcxSEZsSmtUQSt1a1RMTGlv?=
 =?utf-8?B?UlRMWFlSOGpVMk5wSFJQMXd6c21tU2ZHUDZ6SFZvY2RkN3d0RThjZXNaVkhP?=
 =?utf-8?B?UXQvWjRXbFJ6SjJ5ZHZPVWtmYjNyWmEreEVTNVZlcGNQTGYzWW5zeDl1MlZV?=
 =?utf-8?B?QU5iditBYkZEeEtQUEMxM3NtajRJc2FCZTFvY090OEYvdm1ibkFpR0RKVEo3?=
 =?utf-8?B?cVBCR2NDUC9QR3BGd1I0SjZacGFSMUpZQ3BWL0JvMVRwTmM5S3BUWWNZOU4x?=
 =?utf-8?B?MmF3TTZjK0hPMUwwaU1hclZLclI2MC9ackNNdmpYVkhBR1RBSWlmdjIwOHpi?=
 =?utf-8?B?YlJGWUNHei92V053Y1FoclNBL04wV21FWmdGemZYOTBERmVmWHVDZFYzSTJJ?=
 =?utf-8?B?ZXFPSklNS016akQzSmhndlV6TTIyendtZkpaWURUSGNZM1hWNEFMZjVHa2I2?=
 =?utf-8?B?VWhIdmZQQjBkMmJBSmJPUS9lZERKSXBwWmFWY2RnNE01YWdmY1BFRzNhOERP?=
 =?utf-8?B?SjgzRkwwOWtGM0NsMVd0S1F5TlFFc0xkSVI0Ry9lSTZ5YTR4REh2eXlia1ZW?=
 =?utf-8?B?ZTJyeFN0N05GeXJ2K3liSEgvbkxMaG9RYmh0V05LbXRiK1l6bkdDckxOR1BR?=
 =?utf-8?B?Q3hyeHVkbkg4VG5vQWV5VWIvMTVJQ0JZQXE1SmlXVE9Odmc0Rmo5RGl1R3Bi?=
 =?utf-8?B?cno3Tm9vaFdobWF6K0ZiRno0cUpLWkFLVGZUOXhBc0ppc2UzRjBQd3cwaXIr?=
 =?utf-8?B?eW40d2hzM2Q2V0NER09MaVRwVUZQTUVUSTlBamNJS1I4ZWRSMnBRcytORE5W?=
 =?utf-8?B?dXM4Zm1WMEUyV3ZkdWhnck90NXNCby93VVVneXdOcWRtZkFKRXRwUk9LaWQx?=
 =?utf-8?B?THFKOXJZWUJlQ3RCTk80aXNSeTU3dDFMN3JKb0VuMlRYSmRkZk80YUIxMTBI?=
 =?utf-8?B?aEgvTE5lQnMvUkN6R0NmckNCR2pEMkplczM3bWFTSm0reWttOExGTytPMmt3?=
 =?utf-8?B?TXVXOFlpeHllbnNqN05EWUhYNW41c2o0aXYxc25NTlhYMDg3cGhuS1FMa2Zn?=
 =?utf-8?B?SXhPblhXcUhIZGpvaEdBL1ZocEZIQ2pyMnVQZ2NXYW5KNGxubzRzZVc2cHpT?=
 =?utf-8?B?ZFhFYlNUbnBSck5VRFVPNlFESzlkOUc4VWhuaGg2TFRYcExNcThjdzlvTTJQ?=
 =?utf-8?B?dEJ4YUNpMytLbTF4bWh1VWFyVDhxMEw0QzNtMFVCQlBUMi9CazZUQUwwWkFL?=
 =?utf-8?B?ZEwrS1Jock5YeE9IYTNxYVVPTW5ueWdiSFZCcHNOYm5kNXEzVm1laG42ZmRa?=
 =?utf-8?B?SnU3NnN4c1NOUHhhZUxxbFdqbk5oeW1ZcDFuY0o3ZWplOHc4NWVUSlJzQWFl?=
 =?utf-8?B?RmJxSFgvY204NysyZjJKaU9raTY4NlA5ckR1eHd5eUtYRHUwQmltNlQybkpS?=
 =?utf-8?B?cXpSb3IzQ3crUisvcVNSMmlTQ0k2aWtYREhqRFQ3T04zNXhGbFIxWTZUT21R?=
 =?utf-8?B?MGdCNW01UzQreUtna2RtdWxuT2NabFJ5Q01BcTRWYlNoSGNTOFFVT1pIK092?=
 =?utf-8?B?UGVlOTVRRTRiQXM2TVJTNEQwMklIS1FxS1ZWOVo2Qi9pcjI0NGswOGZWa0ZT?=
 =?utf-8?B?SmRkc2F0dXdIN2dkRGQzNmZySUpMNWJIRmw2WVEwcEliN3AyNjIxeVhOSWFa?=
 =?utf-8?B?NE5DNGVoWlNvckFkWmZreDRzZUkyN2dPTTdOczhqdjgyMk85Tmh1eHlLZVJj?=
 =?utf-8?B?Z09YZm5RTzZKd09sbG52TWpEQldkTVFYWFpsRzFLdjJyUU5IZklvMGhWZ1lR?=
 =?utf-8?B?RlJzWlllVVNQTnJWbTVLVFEzY3J0ZmwvTENJK1MyUjhIT0JXd3FrVFRPREdH?=
 =?utf-8?B?OER0VHFHUUEwRC8wWnNDV09aSFZLeXZqVFhpc2NFSitoMDNKSjg0WlYvTmNV?=
 =?utf-8?Q?tcb2wkMuS/JW72rKxKLzduj//?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3a3254-cc31-4e76-7c96-08dc6368c0ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:41:15.1441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evuvgod3n5Hgl1t4wLirZMK/Es1mf778XhXYrPEuKiVmmfE4o3GSCalZvSnESpHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In this case we should modify amdgpu_i2c_get_byte() to return an error 
and prevent writing the value back.

See zero is as random as any other value and initializing the variable 
here doesn't really help, it just makes your warning disappear.

Regards,
Christian.

Am 23.04.24 um 08:27 schrieb Zhou, Bob:
> [AMD Official Use Only - General]
>
> Thanks for your comments.
>
> I should clarify the issue. As you see the amdgpu_i2c_get_byte code:
>                  if (i2c_transfer(&i2c_bus->adapter, msgs, 2) == 2) {
>                          *val = in_buf[0];
>                          DRM_DEBUG("val = 0x%02x\n", *val);
>                  } else {
>                          DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n",  addr, *val);
>                  }
> If the read failure by amdgpu_i2c_get_byte(), the value will not be modified.
> Then the amdgpu_i2c_put_byte() successfully written the random value and it will cause unexpected issue.
>
> Regards,
> Bob
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: 2024年4月23日 14:05
> To: Zhou, Bob <Bob.Zhou@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
>
> Am 23.04.24 um 07:33 schrieb Bob Zhou:
>> Because the val isn't initialized, a random variable is set by amdgpu_i2c_put_byte.
>> So fix the uninitialized issue.
> Well that isn't correct. See the code here:
>
>           amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>                               amdgpu_connector->router.i2c_addr,
>                               0x3, &val);
>           val &= ~amdgpu_connector->router.cd_mux_control_pin;
>           amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
>                               amdgpu_connector->router.i2c_addr,
>                               0x3, val);
>
> The value is first read by amdgpu_i2c_get_byte(), then modified and then written again by amdgpu_i2c_put_byte().
>
> Was this an automated warning?
>
> Either way the patch is clearly rejected.
>
> Regards,
> Christian.
>
>> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
>> index 82608df43396..d4d2dc792b60 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
>> @@ -368,7 +368,7 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
>>    void
>>    amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector)
>>    {
>> -     u8 val;
>> +     u8 val = 0;
>>
>>        if (!amdgpu_connector->router.cd_valid)
>>                return;

