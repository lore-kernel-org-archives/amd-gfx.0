Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8764C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 10:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6822110E267;
	Fri, 14 Feb 2025 10:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NiaMAv2a";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1907710E267
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 10:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zch3uXU0yBd3t8qUr+jEeiCeTayI+CdCDOh1q63VVVXauzS6xazUbI4zvarv3CsB7HIbLClIuzgLESuBDDlLn6jYbR4pHDT+HMKm/xaE7E9B+kP7GbTGZTweqZfaHb+JiRUIOKckHFhMkt22+5Fb9pyF3FmR+k4gpgJw8lCzJDiN0ySSPrN5vK+9zCDWcxS6mYldtQ7C57RppZ8Zv+iv8rdVTWhjSWRatolK0Im1MT5Oo3nYIKhQqKrXjlfckKNFGChEZy1RCzt07kX65pp0blF7LzBOUrAIC+j7Ok+EWeik2fLSGNYW/3T6xzNDn8+NSQcyDEmW3PootUN0gHDxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+Karkv6/RunPqtXK+R8At9pqSNMWxwOzFVE5EIrPS4=;
 b=osdPP7eJTMfCHUdgJNorQc+UiyeT0AFQWBRaMevotv3jWtKFBkBq76eW8sf8wFdszxmHKChHMoBHF0jIBHb/HZYK5pXJMp73QNhAHfqQozCrbqNjoz/8O+FC9W0+90lAuSeAWvanzdBQ1GsNkH6KvfyHHySM3hB40uH/zDnSaROPcfYBLzArwAvyQMV94sXbvDNJbYXjzsJqxeNxcDEPVsKDPf/bfPi8BzREmJxQnNYi3mX4gImP0yDdE0z5N47FNsoZ/ZBKnZ9EyItvIxHjJ8fjBq6H46bca94oxmHhKSWIt0y8qbm9ZZy55K18OXhPfUd5QfvC5YCIYcaLWElTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+Karkv6/RunPqtXK+R8At9pqSNMWxwOzFVE5EIrPS4=;
 b=NiaMAv2ab58ciN8XiP0O9JII0smTbhKchsoS+39IxtayKUbxepGDL2RzVEUhiXqk4+ZZ4Z1buJq1BWZx1y8GNMJglZQa9+ILKWxBSk1jSjksJrwhJLEwUwkZ/VtbZeDdg6jhiI3SNo76v9iowqNIMaLt/dUR/tY2UgFnPlH5bRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 10:00:03 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 10:00:03 +0000
Content-Type: multipart/alternative;
 boundary="------------IKTu1XsrDVew3hFzMQklo1z2"
Message-ID: <ad3e75d4-1bca-46f0-9892-5492f292e4ec@amd.com>
Date: Fri, 14 Feb 2025 15:29:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace Mutex with Spinlock for RLCG register
 access to avoid Priority Inversion in SRIOV
To: Victor Skvortsov <victor.skvortsov@amd.com>,
 Zhigang Luo <zhigang.luo@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 lin cao <lin.cao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250214085755.662775-1-srinivasan.shanmugam@amd.com>
 <955a3d4f-06fa-4a4e-85f5-b7b1aadb30bf@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <955a3d4f-06fa-4a4e-85f5-b7b1aadb30bf@amd.com>
X-ClientProxiedBy: PN3PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::22) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e01cfbf-9d00-4916-356f-08dd4cde59f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUd6dHhzcDA1cFppOS9CRHJGZjN6b2FJQ0ZhN1EzSWJuV0t1b0NEVlJVaVZn?=
 =?utf-8?B?RFVSRFlpbEluWDQ1WFZzY28zbUVJcnk1Zm43Y3Y0eGJPcFA3TDVKWjJYa2l4?=
 =?utf-8?B?K1g5Y2lWTnEvRTF0NDF4enhaeFI2OG5nYk1vT0x1NmdDZFN5UWtka1NPcGl5?=
 =?utf-8?B?bm5MbG1wN0FFVXNHdUtyekRuWUZBVGhaY1huVWx2aWFnT1E2OTRsL3ZqR0FD?=
 =?utf-8?B?OVlNQ1dHcXZGdTNkRlgzQXJyaFMzWkZMY2IvVkkvT1E5ODI1M1BmeWthMkt3?=
 =?utf-8?B?djV3S2ZCNmFoZEYrd2hMZlVJeEY4citQQXltVTU0cHJiUEgra1NCazJtTEk5?=
 =?utf-8?B?eUxySWl6ejBLMHBCRWZKNVF1VjRlNUVad0M4dTR1TmUxQ0p4amlQVFUzRHdt?=
 =?utf-8?B?U3NIeHArTFR3L05qMnpkRXVVM1pYVkYreWVseCtHY2Y3TzVPWkl4WDhYZ1pW?=
 =?utf-8?B?Sk54ZFRjY2x5T0xmOXFqRHJMcEtuUU8ydDVYbnR6UGNUMUwrYlNTNlRNNVpj?=
 =?utf-8?B?Z1JYVW0yZkU2SlBjUVJxYm1RL3ArdzZLMjhUcmNRZ1ZpTnYxQUc5UVNCOXBp?=
 =?utf-8?B?QnNpQjhBNHhBQVIveVFyeGRpaDg3UkxKd3h2M2YxRHN5ODNFdTVVekVnWnFz?=
 =?utf-8?B?bDE0cUNvbGQwQ3ZhNCthYXVyM1lqb3VDODdNMHVGT3RUcVViL0VSbWc0bnJq?=
 =?utf-8?B?L0lkUnlrYmFsUUF4akh0KzdqK1l3eTBvSkhzd2orZkZjeGE3SEVPd3FESU5N?=
 =?utf-8?B?RTZMUFU5eVpBT05ONWNDRFpvZTA3bU9KbkZ5MXFSOHBKQkQ0ZmtwVTE2UmRC?=
 =?utf-8?B?czAvMVF6aGRRdnArcGRVQzBHeWxkUCtZcnJZYytocWRHeldYcWFUZ3B5N2wv?=
 =?utf-8?B?d0ZhaVJrV3pyelhsR2kzTmVUOWowdUZaeW9oQm1zcXZkVy9HZkZucHl6cVFu?=
 =?utf-8?B?YWJjOHZFRjluZ3IvdkQ1Wjc3K2FhckI4VWo3WUhqMXdHdE93QmlqbEFHREdp?=
 =?utf-8?B?RGtoTXEwOXdPY1ZtVloxazYvVDRoT0dOeWtsbUNsMHRCZjJ5TGZhUWZoTEpm?=
 =?utf-8?B?OHNoZ1BjUGwvVFUvdE1YNjYydUFROGVMY1BweFN0aWRndDEycTcyL2Y5UVRq?=
 =?utf-8?B?VTBMdzZKTThCQTYxZzhpU05hcTBiaHAwTDh5L0NLM21KWmVkNFlnUHNkOWIz?=
 =?utf-8?B?TldXSi9Cb04xTHdjQ0hpWWFEUVh6Q045NXR1VE9Nclh0UVZVZFg1aTJzTjlu?=
 =?utf-8?B?QTM2ZVBOcjlIamVZU3JvUXY3dkJsWE10WEt5S0VBUGlONVh0QStLODNTUlBJ?=
 =?utf-8?B?WGVFR2IzazA0b3Rzd0xnMVFwaUkvUDFXditoekNVcUxzanNoeW1NYUlJRXlx?=
 =?utf-8?B?UWtkbVFJQzdPNjNGenV0QTVkaGkycWZjamg3emE1cDUvMjUwN3VRY3ZpVHdD?=
 =?utf-8?B?cHNkOWNUVnpLNUEwdm5kdVphZmpQbGppQlpwUXFLcEJZQmQyNXp1VTNvMGkx?=
 =?utf-8?B?b3F6OW16YWhKRi9lNDc2QnZ1YS82bVl3ZzhvU0g2c3lKRnNKaVRIODRmL21a?=
 =?utf-8?B?enJBWHZxU2txZkhiUWNMbDZ5UGxVOTNMT1o1eTA4bTF4UFdKZDlLVEM5cTd5?=
 =?utf-8?B?VjJuQmxMNkNrSlVlWU9rSEZTcHRvRjBFc29TL3dhbFBCaDZJMDU5TUdRdWhK?=
 =?utf-8?B?Qk16YU1GajRQbERFRnlBZ0Fod1Q2TFNXeFlSVEZIOFpEWWl1S1lhd2lGUjBv?=
 =?utf-8?B?OWVDUkpKZUhPVTJtTE5XTVA1NE8xUFV5UmFYMGJ2QnNRQjFRR0R5SFpzMWxU?=
 =?utf-8?B?b1M2dm5RRmpvRlk2eXI2VW9JMGhhTW5IUXFEbXROdFZLTGNMNWdXdndxNWdz?=
 =?utf-8?Q?DC4kA0qD9vQ39?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDh4WkxsdWd4T0RPc05wOU96blcwNjF2aWlDRXdIdkZBOEkzVkNRMUx4dHBW?=
 =?utf-8?B?NTFZM2NNS2drUHdOV2dIckZwYU51d0NNelFKVUZma0tIL2RIYVZ1eU9hd29C?=
 =?utf-8?B?M3IyQzBGQlpxNVgydFl1S3JhcFNhMUsxZGJScWs3WldLNVhKaktzTjdxK3ZF?=
 =?utf-8?B?UTE3S2ZjVkM2OEU4YlRWSnRzZlhaSHNnUjJHdzVpaVU4ZTFvM1NFcDZ4RkxO?=
 =?utf-8?B?N21OdnhjSGFTYnNsZ0o2VlhSUkRadTJFaHRNSWtBT05SaTJoT1VwRGFvU2hR?=
 =?utf-8?B?UGpXZGpDQ0lwMWVaWlo2Sm5kVllKVy9keFZhYXdrTXFNYzIvUkVGZElrZWVT?=
 =?utf-8?B?MkVvUDRDTTZjd0V0OUJlRE5LVURuOXRoYUoyQnE4N0xocGZRZVFSTU5MS3JJ?=
 =?utf-8?B?SzNueWVqUTRPTkI5SUVPVWtmRmdHS0kzeURnM2F6MUZTWGxPNFZZM09KeDJj?=
 =?utf-8?B?RHRtQVUvMmU5UHRIZ1dJMHppY2d0ZkJTZ05jRnpucFRqTFJnOVpQS1hiK2lk?=
 =?utf-8?B?cTg2OU01QjVTN0RIbm1rZFRWeStoYVdNTWEwbmtHN2V0M0w0Wk9PUk9HMDFZ?=
 =?utf-8?B?b0hEQmthS2JHUVQxVENaekhTeUtES1FlemlTN2ROMjkweDRYWjJNUUFrYk5M?=
 =?utf-8?B?U2tXNm8wMTVUT21STFJFYm5Bd2N1T2FQaUVYMUlCc25QR0dxMngvemhiSUVK?=
 =?utf-8?B?c3V2K0UvT0Z1cStaaWNLR2NDS21OdkNnM0NYek16K3E0cURydjU3akRNcE83?=
 =?utf-8?B?VnVSZ09oV3ZvUEZMNUJoUGRMTjBSb3NNelBTV3VKUjM0Q3FqNE43U2ZQMERH?=
 =?utf-8?B?eFl3MnVaZHNrL3VXTHNxU2tUNEZTNzkvWjVVOWxrNDRpeGZNdytUeit6L01l?=
 =?utf-8?B?Wms0SEJYL0lTdzJUcGVnclcvcFkwNCtuNDA5NEFEUFE2enJuUlNWSHR1d0tp?=
 =?utf-8?B?WFQ4ZjJjTTBJNmJ3alN6YTdCeHlqcEpVbzRDeGo1SkpsUS9YMDdpNnRUYllY?=
 =?utf-8?B?allmNUYya3A0S3RUTVdzbjZHOE0zbTI4ZnUzM1FFZ2M1SEREY1U5Sjd1Kzkx?=
 =?utf-8?B?ZVFHMVY1SjNSVXRnNjN2ekFzdEJLMW81cUVnQ2hsYTNFNG9idkF1bFlGMUs3?=
 =?utf-8?B?cFpMVkEzZk1oRmtJaHNOZHhnamp3UERKVjZYRFpYR0FDSVIwUXhvNi9ZVDNu?=
 =?utf-8?B?RUk3RTNteFE1RURlR25nUlhWYmllcGViY3BiNkRMUUJPbXFvMDQvR2pURS94?=
 =?utf-8?B?MWFHSkdNSFVOVXZjVGNFbEJnYlNSOXEzL3ZqZFJSaDdxVWticnNFNXVKb0Vw?=
 =?utf-8?B?YUlCa2pNZkdvSlZlTVJrN3pYQjl4dUthc0VuL1BUbU9mNDJUVUV3L3RISU9u?=
 =?utf-8?B?dWZHczJ3dStwbFFYU2wwVnJ0Wmd4WnRzSkwwenpuRE1RZ2RaMmZveGU1WU5T?=
 =?utf-8?B?bEJvOHphOXNrWk9yUTFFR0o3K1R4OWlXdC84a3hBZXNYSUVIOUhsbXMyQzJQ?=
 =?utf-8?B?cnpoTUttVzJxeVFQTTJ2VDFQeEF5dldhUzNGenV1NDJzRmZ6aThBOUFRQzZv?=
 =?utf-8?B?blBRUXIxWUVtRFBLMnlZR3FMSzZEa0YvNVZQN2l3TjFxenNVNTFhNzlLbVpG?=
 =?utf-8?B?UnRHVkZHMXZoQXdnQ2tkcFlHa2ZreFM4d1hJdGZWVEVmMHVweFRVamVUNzcv?=
 =?utf-8?B?K21zSWxMTy96VDMzL1poZlprcGwydyswem9OcXcxZnl5cUFPOWNqdWZ2VzdJ?=
 =?utf-8?B?QjRXVUE4NzdpbjNwRUM0ZEtPY2lvUXRSY25qYkY4MjZUdkdad2UvNWJMSEJ4?=
 =?utf-8?B?YVJxYWtIa1paUTZhYTNiUlBjN2lCUEpXWTUxTkljMHJIeTJGRjdDeU5IVFd4?=
 =?utf-8?B?Zk5YM0tJY09CbE8rWWVMajQwdTFQTXoxQkt0dUhjZ1dpRDJiTUd3NDZHSmh6?=
 =?utf-8?B?ejZIQ2RWZDQrcVovMU5qSFVlWmcrQ1BrZE5ieXdPVnVaUElob0RMUGxGYlBQ?=
 =?utf-8?B?bGhrTzF5LzY4MXY2OGFLNTFjTVJGZnpzZmkyT2liQkI3MlUvQk9DbjBPTjdX?=
 =?utf-8?B?YTZWemdiYk51S2ZGM1owdVFtcUdrdEhORjN1M3NGL0IzUWtrZ1QrM3JMNStz?=
 =?utf-8?Q?6yonYjBUP14CS1wWMc9HTmuFr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e01cfbf-9d00-4916-356f-08dd4cde59f1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:00:03.4090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIgd3MaSAFxBziTYZ/Yzqr0BgPTT6xeqJjOGekCSNuWqPjAxQqqlEhss+RKaBsYkF5TMSrpQrMCKWFI0NI2JQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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

--------------IKTu1XsrDVew3hFzMQklo1z2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/14/2025 2:39 PM, Christian König wrote:
> Am 14.02.25 um 09:57 schrieb Srinivasan Shanmugam:
>> RLCG Register Access is a way for virtual functions to safely access GPU
>> registers in a virtualized environment., including TLB flushes and
>> register reads. When multiple threads or VFs try to access the same
>> registers simultaneously, it can lead to race conditions. By using the
>> RLCG interface, the driver can serialize access to the registers. This
>> means that only one thread can access the registers at a time,
>> preventing conflicts and ensuring that operations are performed
>> correctly. Additionally, when a low-priority task holds a mutex that a
>> high-priority task needs, ie., If a thread holding a spinlock tries to
>> acquire a mutex, it can lead to priority inversion. register access in
>> amdgpu_virt_rlcg_reg_rw especially in a fast code path is critical.
>>
>> The call stack shows that the function amdgpu_virt_rlcg_reg_rw is being
>> called, which attempts to acquire the mutex. This function is invoked
>> from amdgpu_sriov_wreg, which in turn is called from
>> gmc_v11_0_flush_gpu_tlb.
>>
>> The warning [ BUG: Invalid wait context ] indicates that a thread is
>> trying to acquire a mutex while it is in a context that does not allow
>> it to sleep (like holding a spinlock).
>>
>> Fixes the below:
>>
>> [  253.013423] =============================
>> [  253.013434] [ BUG: Invalid wait context ]
>> [  253.013446] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
>> [  253.013464] -----------------------------
>> [  253.013475] kworker/0:1/10 is trying to lock:
>> [  253.013487] ffff9f30542e3cf8 (&adev->virt.rlcg_reg_lock){+.+.}-{3:3}, at: amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>> [  253.013815] other info that might help us debug this:
>> [  253.013827] context-{4:4}
>> [  253.013835] 3 locks held by kworker/0:1/10:
>> [  253.013847]  #0: ffff9f3040050f58 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
>> [  253.013877]  #1: ffffb789c008be40 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
>> [  253.013905]  #2: ffff9f3054281838 (&adev->gmc.invalidate_lock){+.+.}-{2:2}, at: gmc_v11_0_flush_gpu_tlb+0x198/0x4f0 [amdgpu]
>> [  253.014154] stack backtrace:
>> [  253.014164] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
>> [  253.014189] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>> [  253.014203] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/18/2024
>> [  253.014224] Workqueue: events work_for_cpu_fn
>> [  253.014241] Call Trace:
>> [  253.014250]  <TASK>
>> [  253.014260]  dump_stack_lvl+0x9b/0xf0
>> [  253.014275]  dump_stack+0x10/0x20
>> [  253.014287]  __lock_acquire+0xa47/0x2810
>> [  253.014303]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  253.014321]  lock_acquire+0xd1/0x300
>> [  253.014333]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>> [  253.014562]  ? __lock_acquire+0xa6b/0x2810
>> [  253.014578]  __mutex_lock+0x85/0xe20
>> [  253.014591]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>> [  253.014782]  ? sched_clock_noinstr+0x9/0x10
>> [  253.014795]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  253.014808]  ? local_clock_noinstr+0xe/0xc0
>> [  253.014822]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>> [  253.015012]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  253.015029]  mutex_lock_nested+0x1b/0x30
>> [  253.015044]  ? mutex_lock_nested+0x1b/0x30
>> [  253.015057]  amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
>> [  253.015249]  amdgpu_sriov_wreg+0xc5/0xd0 [amdgpu]
>> [  253.015435]  gmc_v11_0_flush_gpu_tlb+0x44b/0x4f0 [amdgpu]
>> [  253.015667]  gfx_v11_0_hw_init+0x499/0x29c0 [amdgpu]
>> [  253.015901]  ? __pfx_smu_v13_0_update_pcie_parameters+0x10/0x10 [amdgpu]
>> [  253.016159]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  253.016173]  ? smu_hw_init+0x18d/0x300 [amdgpu]
>> [  253.016403]  amdgpu_device_init+0x29ad/0x36a0 [amdgpu]
>> [  253.016614]  amdgpu_driver_load_kms+0x1a/0xc0 [amdgpu]
>> [  253.017057]  amdgpu_pci_probe+0x1c2/0x660 [amdgpu]
>> [  253.017493]  local_pci_probe+0x4b/0xb0
>> [  253.017746]  work_for_cpu_fn+0x1a/0x30
>> [  253.017995]  process_one_work+0x21e/0x680
>> [  253.018248]  worker_thread+0x190/0x330
>> [  253.018500]  ? __pfx_worker_thread+0x10/0x10
>> [  253.018746]  kthread+0xe7/0x120
>> [  253.018988]  ? __pfx_kthread+0x10/0x10
>> [  253.019231]  ret_from_fork+0x3c/0x60
>> [  253.019468]  ? __pfx_kthread+0x10/0x10
>> [  253.019701]  ret_from_fork_asm+0x1a/0x30
>> [  253.019939]  </TASK>
>>
>> Fixes: e864180ee49b ("drm/amdgpu: Add lock around VF RLCG interface")
>> Cc: lin cao<lin.cao@amd.com>
>> Cc: Jingwen Chen<Jingwen.Chen2@amd.com>
>> Cc: Victor Skvortsov<victor.skvortsov@amd.com>
>> Cc: Zhigang Luo<zhigang.luo@amd.com>
>> Cc: Christian König<christian.koenig@amd.com>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 9 +++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 3 ++-
>>   3 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index eab530778fbd..14125cc3a937 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4251,7 +4251,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	mutex_init(&adev->grbm_idx_mutex);
>>   	mutex_init(&adev->mn_lock);
>>   	mutex_init(&adev->virt.vf_errors.lock);
>> -	mutex_init(&adev->virt.rlcg_reg_lock);
>>   	hash_init(adev->mn_hash);
>>   	mutex_init(&adev->psp.mutex);
>>   	mutex_init(&adev->notifier_lock);
>> @@ -4277,6 +4276,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	spin_lock_init(&adev->se_cac_idx_lock);
>>   	spin_lock_init(&adev->audio_endpt_idx_lock);
>>   	spin_lock_init(&adev->mm_stats.lock);
>> +	spin_lock_init(&adev->virt.rlcg_reg_lock);
>>   	spin_lock_init(&adev->wb.lock);
>>   
>>   	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index 2056efaf157d..073fc34e43eb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -1038,7 +1038,11 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>>   	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
>>   	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
>>   
>> -	mutex_lock(&adev->virt.rlcg_reg_lock);
>> +	/* Try to acquire the lock without blocking */
>> +	if (!spin_trylock(&adev->virt.rlcg_reg_lock)) {
> That is clearly not going to work, you really need to block here.
>
>> +		dev_err(adev->dev, "Failed to acquire rlcg_reg_lock, aborting register access!\n");
>> +		return 0;
>> +	}
>>   
>>   	if (reg_access_ctrl->spare_int)
>>   		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
>> @@ -1097,7 +1101,8 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>>   
>>   	ret = readl(scratch_reg0);
>>   
>> -	mutex_unlock(&adev->virt.rlcg_reg_lock);
>> +	/* Unlock the spinlock after the critical section is complete */
>> +	spin_unlock(&adev->virt.rlcg_reg_lock);
> Please drop those comments. Never document what is done, but only why.
>
> Question is can that be used from interrupt context as well? I think yes, so we even need to use the spinlock_irqsafe variant here.
>
> Regards,
> Christian.

Thanks a lot Christian for your feedbacks!

Hi SRIOV team (Victor Skvortsov/ Zhigang Luo), Could you please confirm, 
if blocking is acceptable, then I can change to 
"spin_lock(&adev->virt.rlcg_reg_lock); & spin_unlock();" & further if 
this function is called interrupt context, then I can change this to

spin_lock_irqsave(&adev->virt.rlcg_reg_lock, flags); & 
spin_unlock_irqrestore(), so that this disable interrupts while the 
spinlock is held, preventing any interrupt handlers from preempting the 
thread & trying to acquire the same lock.

Best Regards,
Srini
>>   
>>   	return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> index 270a032e2d70..0f3ccae5c1ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> @@ -279,7 +279,8 @@ struct amdgpu_virt {
>>   	/* the ucode id to signal the autoload */
>>   	uint32_t autoload_ucode_id;
>>   
>> -	struct mutex rlcg_reg_lock;
>> +	/* Spinlock to protect access to the RLCG register interface */
>> +	spinlock_t rlcg_reg_lock;
>>   
>>   	union amd_sriov_ras_caps ras_en_caps;
>>   	union amd_sriov_ras_caps ras_telemetry_en_caps;
--------------IKTu1XsrDVew3hFzMQklo1z2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/14/2025 2:39 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:955a3d4f-06fa-4a4e-85f5-b7b1aadb30bf@amd.com">
      <pre wrap="" class="moz-quote-pre">Am 14.02.25 um 09:57 schrieb Srinivasan Shanmugam:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">RLCG Register Access is a way for virtual functions to safely access GPU
registers in a virtualized environment., including TLB flushes and
register reads. When multiple threads or VFs try to access the same
registers simultaneously, it can lead to race conditions. By using the
RLCG interface, the driver can serialize access to the registers. This
means that only one thread can access the registers at a time,
preventing conflicts and ensuring that operations are performed
correctly. Additionally, when a low-priority task holds a mutex that a
high-priority task needs, ie., If a thread holding a spinlock tries to
acquire a mutex, it can lead to priority inversion. register access in
amdgpu_virt_rlcg_reg_rw especially in a fast code path is critical.

The call stack shows that the function amdgpu_virt_rlcg_reg_rw is being
called, which attempts to acquire the mutex. This function is invoked
from amdgpu_sriov_wreg, which in turn is called from
gmc_v11_0_flush_gpu_tlb.

The warning [ BUG: Invalid wait context ] indicates that a thread is
trying to acquire a mutex while it is in a context that does not allow
it to sleep (like holding a spinlock).

Fixes the below:

[  253.013423] =============================
[  253.013434] [ BUG: Invalid wait context ]
[  253.013446] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
[  253.013464] -----------------------------
[  253.013475] kworker/0:1/10 is trying to lock:
[  253.013487] ffff9f30542e3cf8 (&amp;adev-&gt;virt.rlcg_reg_lock){+.+.}-{3:3}, at: amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.013815] other info that might help us debug this:
[  253.013827] context-{4:4}
[  253.013835] 3 locks held by kworker/0:1/10:
[  253.013847]  #0: ffff9f3040050f58 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
[  253.013877]  #1: ffffb789c008be40 ((work_completion)(&amp;wfc.work)){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
[  253.013905]  #2: ffff9f3054281838 (&amp;adev-&gt;gmc.invalidate_lock){+.+.}-{2:2}, at: gmc_v11_0_flush_gpu_tlb+0x198/0x4f0 [amdgpu]
[  253.014154] stack backtrace:
[  253.014164] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
[  253.014189] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  253.014203] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/18/2024
[  253.014224] Workqueue: events work_for_cpu_fn
[  253.014241] Call Trace:
[  253.014250]  &lt;TASK&gt;
[  253.014260]  dump_stack_lvl+0x9b/0xf0
[  253.014275]  dump_stack+0x10/0x20
[  253.014287]  __lock_acquire+0xa47/0x2810
[  253.014303]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.014321]  lock_acquire+0xd1/0x300
[  253.014333]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.014562]  ? __lock_acquire+0xa6b/0x2810
[  253.014578]  __mutex_lock+0x85/0xe20
[  253.014591]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.014782]  ? sched_clock_noinstr+0x9/0x10
[  253.014795]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.014808]  ? local_clock_noinstr+0xe/0xc0
[  253.014822]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.015012]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.015029]  mutex_lock_nested+0x1b/0x30
[  253.015044]  ? mutex_lock_nested+0x1b/0x30
[  253.015057]  amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.015249]  amdgpu_sriov_wreg+0xc5/0xd0 [amdgpu]
[  253.015435]  gmc_v11_0_flush_gpu_tlb+0x44b/0x4f0 [amdgpu]
[  253.015667]  gfx_v11_0_hw_init+0x499/0x29c0 [amdgpu]
[  253.015901]  ? __pfx_smu_v13_0_update_pcie_parameters+0x10/0x10 [amdgpu]
[  253.016159]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.016173]  ? smu_hw_init+0x18d/0x300 [amdgpu]
[  253.016403]  amdgpu_device_init+0x29ad/0x36a0 [amdgpu]
[  253.016614]  amdgpu_driver_load_kms+0x1a/0xc0 [amdgpu]
[  253.017057]  amdgpu_pci_probe+0x1c2/0x660 [amdgpu]
[  253.017493]  local_pci_probe+0x4b/0xb0
[  253.017746]  work_for_cpu_fn+0x1a/0x30
[  253.017995]  process_one_work+0x21e/0x680
[  253.018248]  worker_thread+0x190/0x330
[  253.018500]  ? __pfx_worker_thread+0x10/0x10
[  253.018746]  kthread+0xe7/0x120
[  253.018988]  ? __pfx_kthread+0x10/0x10
[  253.019231]  ret_from_fork+0x3c/0x60
[  253.019468]  ? __pfx_kthread+0x10/0x10
[  253.019701]  ret_from_fork_asm+0x1a/0x30
[  253.019939]  &lt;/TASK&gt;

Fixes: e864180ee49b (&quot;drm/amdgpu: Add lock around VF RLCG interface&quot;)
Cc: lin cao <a class="moz-txt-link-rfc2396E" href="mailto:lin.cao@amd.com">&lt;lin.cao@amd.com&gt;</a>
Cc: Jingwen Chen <a class="moz-txt-link-rfc2396E" href="mailto:Jingwen.Chen2@amd.com">&lt;Jingwen.Chen2@amd.com&gt;</a>
Cc: Victor Skvortsov <a class="moz-txt-link-rfc2396E" href="mailto:victor.skvortsov@amd.com">&lt;victor.skvortsov@amd.com&gt;</a>
Cc: Zhigang Luo <a class="moz-txt-link-rfc2396E" href="mailto:zhigang.luo@amd.com">&lt;zhigang.luo@amd.com&gt;</a>
Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eab530778fbd..14125cc3a937 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4251,7 +4251,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&amp;adev-&gt;grbm_idx_mutex);
 	mutex_init(&amp;adev-&gt;mn_lock);
 	mutex_init(&amp;adev-&gt;virt.vf_errors.lock);
-	mutex_init(&amp;adev-&gt;virt.rlcg_reg_lock);
 	hash_init(adev-&gt;mn_hash);
 	mutex_init(&amp;adev-&gt;psp.mutex);
 	mutex_init(&amp;adev-&gt;notifier_lock);
@@ -4277,6 +4276,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&amp;adev-&gt;se_cac_idx_lock);
 	spin_lock_init(&amp;adev-&gt;audio_endpt_idx_lock);
 	spin_lock_init(&amp;adev-&gt;mm_stats.lock);
+	spin_lock_init(&amp;adev-&gt;virt.rlcg_reg_lock);
 	spin_lock_init(&amp;adev-&gt;wb.lock);
 
 	xa_init_flags(&amp;adev-&gt;userq_xa, XA_FLAGS_LOCK_IRQ);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 2056efaf157d..073fc34e43eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1038,7 +1038,11 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	scratch_reg2 = (void __iomem *)adev-&gt;rmmio + 4 * reg_access_ctrl-&gt;scratch_reg2;
 	scratch_reg3 = (void __iomem *)adev-&gt;rmmio + 4 * reg_access_ctrl-&gt;scratch_reg3;
 
-	mutex_lock(&amp;adev-&gt;virt.rlcg_reg_lock);
+	/* Try to acquire the lock without blocking */
+	if (!spin_trylock(&amp;adev-&gt;virt.rlcg_reg_lock)) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That is clearly not going to work, you really need to block here.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		dev_err(adev-&gt;dev, &quot;Failed to acquire rlcg_reg_lock, aborting register access!\n&quot;);
+		return 0;
+	}
 
 	if (reg_access_ctrl-&gt;spare_int)
 		spare_int = (void __iomem *)adev-&gt;rmmio + 4 * reg_access_ctrl-&gt;spare_int;
@@ -1097,7 +1101,8 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 
 	ret = readl(scratch_reg0);
 
-	mutex_unlock(&amp;adev-&gt;virt.rlcg_reg_lock);
+	/* Unlock the spinlock after the critical section is complete */
+	spin_unlock(&amp;adev-&gt;virt.rlcg_reg_lock);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please drop those comments. Never document what is done, but only why.

Question is can that be used from interrupt context as well? I think yes, so we even need to use the spinlock_irqsafe variant here.

Regards,
Christian.
</pre>
    </blockquote>
    <p>Thanks a lot Christian for your feedbacks!</p>
    <p>Hi SRIOV team (<span style="white-space: pre-wrap">Victor Skvortsov/ </span><span style="white-space: pre-wrap">Zhigang Luo), Could you please confirm</span>,
      if blocking is acceptable, then I can change to
      &quot;spin_lock(&amp;adev-&gt;virt.rlcg_reg_lock); &amp;
      spin_unlock();&quot; &amp; further if this function is called interrupt
      context, then I can change this to <br>
    </p>
    <p>spin_lock_irqsave(&amp;adev-&gt;virt.rlcg_reg_lock, flags); &amp;
      spin_unlock_irqrestore(), so that this disable interrupts while
      the spinlock is held, preventing any interrupt handlers from
      preempting the thread &amp; trying to acquire the same lock.</p>
    Best Regards,<br>
    Srini<br>
    <blockquote type="cite" cite="mid:955a3d4f-06fa-4a4e-85f5-b7b1aadb30bf@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 270a032e2d70..0f3ccae5c1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -279,7 +279,8 @@ struct amdgpu_virt {
 	/* the ucode id to signal the autoload */
 	uint32_t autoload_ucode_id;
 
-	struct mutex rlcg_reg_lock;
+	/* Spinlock to protect access to the RLCG register interface */
+	spinlock_t rlcg_reg_lock;
 
 	union amd_sriov_ras_caps ras_en_caps;
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------IKTu1XsrDVew3hFzMQklo1z2--
