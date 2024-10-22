Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083E8D1CDAC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 08:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB99E10E605;
	Tue, 22 Oct 2024 08:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TmYRfN1D";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD2810E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 08:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6av6DxoalFobi97NUvmwdpKeA/7zJC0J/KaN+Vp3Y+COHmhXPF8opzCJy0BV3pdn3LbPGX4ONv0nQHRmgAkgEnRRO/PU+VzOpIC3R+J29p84ZSaYYUopGhKqv9URMO6MjG/y85gWr/ptqtCYVTwqoAL22AWhmrrrxn3xdecpAcq44oSsQHaBjCkGHofAa6NekhruytZBlFJW5+YIPv/Mc5zzQ7LViotYSMRvWAh1x/aoa2yELYQpoB11S2KxTdDPE044L9TOiDFFUTTtJpihhRr567kT5aV0kh4tQYjCA6NBpjE/LwnEMbyYmqeDPTFw+DM9a5wCYPe/U2OWQnOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0MvOFon1hrgz/bGW0yDrv8vkIcVk47rmGxGDloHLi4=;
 b=QQhCd6ailkAtnGUfND/6z3s1SVJ8TXi8He0kk4zEORjBP1b+3IJNsS+KCRV5JvIbEJH76tpRtTJBVxFwlwuhxH0SUO5KJVi+evITZJoB6MBCnZofH4/B1/GnaYPO+F/Jr5ynsQBOhuMIyrza9+w/8dBA/furQOOPBwHX2HMPRWOS4b6tbYLqFyUxru3dWkXGRWLV3CDFIEEClRPa8OPqZZ0s/czbCuWHNL+jrVGaqK+ocu3+zjbvfj6LK4kw+AWyKTXcjM23CVVaGkHl7dk8y8JOKtMvZv4cNZoYJDpQVpjL6SDA2PjxOmkpH/4XYgVdT1VHiskoezO1b/AD53saaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0MvOFon1hrgz/bGW0yDrv8vkIcVk47rmGxGDloHLi4=;
 b=TmYRfN1Dimo/shueTlIiyMeMfIN9Xp5/qWLk10LHio1/umypfxrRFImwb7kGfJGBDznMppZovP6/+QZQlfaGhrbyyW47ULQGVL/kjXvYJq2+N3uoFayX5nz6r/7XjK3Vz6eM9nDSjjdhVOMXuce+kB/2IVSAE5K192ydk8g8hVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 08:01:19 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8069.020; Tue, 22 Oct 2024
 08:01:19 +0000
Message-ID: <a938652f-b641-4afa-88a5-47308ffccecf@amd.com>
Date: Tue, 22 Oct 2024 16:01:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: Explicitly specify data type amdkfd_process_info
 in related functions
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241015035150.1477582-1-lingshan.zhu@amd.com>
 <db85737d-9489-453f-85c2-dbd740a98904@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <db85737d-9489-453f-85c2-dbd740a98904@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6ef7b6-18cc-4cb7-741e-08dcf26fb5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUdncnVaN0JoWWtnbzl3bExBTE5uNVVYbm42ZFZZck5zcFdyOU1uS0MxQUli?=
 =?utf-8?B?RXJUK2FMblNydjg3WTBveTZCemlIZ2dEakM5UG1XOG9aZTN0NE1tZmw2MEpl?=
 =?utf-8?B?QXVnbmRpOUxFdDE4REJscTY5M1FKRDlQampBMXNENHhuZGN5NmlhdHROTkVl?=
 =?utf-8?B?bHBWUDE4cUlCV1U4YW93ZWFuVms5VWRoVTlnclVnYjhLYmhvVlg1Z3Y2SXRE?=
 =?utf-8?B?eGVUaFZtT2xYQ2pJYlAzS2dickFGR2luSHhiTDNGRjNuenUxajhYalZ4OGk2?=
 =?utf-8?B?UkQ1bmp2MitiTXNYOWdrVjVIR2VMTExiK3BJMFUzaHd0eXA2bkVtM2JTNlJ4?=
 =?utf-8?B?S2ZtRmdMY1lRcGRIV252TDVwSWZKWjIyRHAzbkdZdVU4b2x0MGdsYXFhNE5U?=
 =?utf-8?B?WVlhWlB5SVREZW9relVEdkF6aDlFQm5QN3E5ODRyeDdVYnpIZHJETnBLQ3pr?=
 =?utf-8?B?aU9TQ0VyNVl0bDBqR09iQjVMNnZ6bExGcjNHK25xUUQybkwxL00zU3g5TlpH?=
 =?utf-8?B?UUVpMDAwNUJjMmtCVWdkZ2VOUGoyOEN0bHd3VkZFdG1PVDIxWWp0YVNRWGpT?=
 =?utf-8?B?djlDT3BlTGpvNWNTTVVlMDIvc01YNXBMNW9nNnRpbWZCT1VVTk5uSjJYZnhx?=
 =?utf-8?B?UlQ3bysxaCt4WkNOVXljT1lEajg1MlVOWmF6bzhHblVNMnNva1Y4eFYzTzlp?=
 =?utf-8?B?UU9ocEJpZ000V1U5a2ROdWUyTjU4WWJtZEQvRjI0bC9GWk1tM0dBa0ZvYW4w?=
 =?utf-8?B?WmdKcXhYMmxMNkdsTW81aUVVSGNmQjBkYTB1dGUycTZHeUc5MUNUS0c2NW5E?=
 =?utf-8?B?QnNHTFFGQW5oUlNhT21FRlhPNTlkVjA3L3lIalpBSVFRUDNiTVhhU04zbnpB?=
 =?utf-8?B?Q2dCVVQydXMybmFtUEovSWRYV0IyN3ErVXpaNFFyNWY1cEMwdUExMEJmamtW?=
 =?utf-8?B?a3VMdkJsOWlaUHdaRjNXc2NXZ210MjRUU0VhTDhud0xHU1VtbitwZ0N2dkxX?=
 =?utf-8?B?Qm5YNzRGeDg4dTBZN25qMjhwNHJBRldLV0ZPckpHcCtJZVdvdHlpckZmckk4?=
 =?utf-8?B?R3pkYlZMaGZKelVMUzVxZnU3T2p3WkQwS2tZSWhrS2FvdnRkbnh5UzBCU0Z6?=
 =?utf-8?B?RDg2UU90SXpKaTdySXcrdzdzQjBEU1NBTnQzM05sYWZtRlkzSXJieE5IYzZW?=
 =?utf-8?B?MkZYNXZZYUZqMk5mMldRekVXQmVkTnEyS21FdHlKa1dueGg3Qm1BZ21vUjAv?=
 =?utf-8?B?Z284bVNaaFdVdEk0V2liWUhmR3I0UitjM3JzL283bGpUK2l3bUphdDVHQVM1?=
 =?utf-8?B?SWxOemFrUC96TnVzejBZMFl2VzV4SnJZV2czK21MdmVzNVpQVHQzZm01RXBE?=
 =?utf-8?B?UzlyTUZUVzZ4VC9zNTZWUTFKMkxQOG1Cek04c2lwV3MvdGpsTFBRd3RkOVBP?=
 =?utf-8?B?SlFCbGwyaTB6UVoyVXFvVW4yWUNrd2ZablVSWGRXV1ltWGR5bEF4L2VpWDdK?=
 =?utf-8?B?WldKa0JiTVBrdHc4cDFuYzVHeVFWcUljWlNyWHlLZGMrSXRlNlN4dkJySXZa?=
 =?utf-8?B?QkNZeDkwTy9wdmtEWVhwdmQzdTdKMElpTTk2Tm9kcll5WlVCZ3FnelBQdVdW?=
 =?utf-8?B?L0pzUkpHMDVmM0pCeEYvNVBBU3VybktpYmVZUGVXTEJiaEllZ3JGaitndFNU?=
 =?utf-8?B?eUVvWFNHNTdyTENIdzdHQkM5VWgxQ2xHMWkwOWlVSTZqdE5WUTRzMVcvSlpr?=
 =?utf-8?Q?zKYfPE3mMlgitYibu1gemZZZE/2L411O5yYDMet?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNxMmgrMjZVOWdwTkowRzJLTVo4RjZMZ0dyZ0gxZmVENXprbkkrTjdORnRp?=
 =?utf-8?B?dlJuci9qQW1MZTNwL0cxYmErMGREbS9sTDllbk5vN0xZRWNLa2xFRWNKcVZl?=
 =?utf-8?B?L2ZPUU9TQUlWTko0ek9OZlV5OWVWcGlFTzR5eUMxcTNMQnV1OEt3TW44Y2tn?=
 =?utf-8?B?QnJ0N2V6eTNlZ29nL0p0K25qcVFtY0d5SnRNdThIWlQ3alZ6UlpMLzFjV0RS?=
 =?utf-8?B?T3hKUk12UnJxWFlhczdVMEY0MUNEbGRFMkhQenEwWWtLaVdTY091YVV0V0V1?=
 =?utf-8?B?aURCZEJoN1U1cUl3anFjR0syRGNaR2QyZG4vS0d0UzQ0RE1lVStMTDVCeklo?=
 =?utf-8?B?dlJSa1pWbldpYVFpSGkzM1ZRUXRhdG5kbFZBU1lnWW1ZOUQ3dWI3akNhNExz?=
 =?utf-8?B?K0pvdTdJcWxqTWE1VjQ2L3AvUENobGtYRDcxMEFaWTRIZjdLQ2l3QXZPbFZK?=
 =?utf-8?B?TWw0d3VOMXllcWRidE02dWtONm9tUjRUTm1BSDc3dEFpd1lOdjkvZzQyT1d4?=
 =?utf-8?B?M2FLaWJLTjVheVhYS1lsOVVqSG5ydzdnaHNSenQvNFp2RkZFaVRKQllOeTRx?=
 =?utf-8?B?UGh3Rm8xV1NpY2ZUSmRZcmNyMWtocXZVWHd6aFM4MkUzbkx1dVdUVjlIblJY?=
 =?utf-8?B?L09TMDdpeGJYRFJmRVZUL0F3S0hZUkNVWnY0ZnB5REVmZm5HVUpJeG5vUHhr?=
 =?utf-8?B?NlF2VktDbE1aU2o0K3hTdVI5NEo5VlhmSXZLNmhBTWhiY2NqbHRVTmpqcW5X?=
 =?utf-8?B?T1hnTEZzeXc2SS9Nbjh0M3BtS2g4TlR3d3ppSFlZZzVxWDJoWXdJSFpiL2dU?=
 =?utf-8?B?OGtDck54a2crZVhUSDJnS0hSemlGLzhwNVJ4NUljcmJEaW13RzdKYVo3Wm90?=
 =?utf-8?B?dFh4L1NyMEVneXgwV3pvaFU3V3VHZDNJakxrdEMyNDVLTy94cktnd2orand2?=
 =?utf-8?B?bU9hemYxNkIyaU5uNTl5WDhQNDNHMXBkOGJxdVRNdGhsN2RUR2gzU0UyZzd3?=
 =?utf-8?B?NEZ0aS9mMS9OdXBwdjMrOHQ4YlVnamN2bW9RWlVpY0VIQnRQR3VsWlkrWFY5?=
 =?utf-8?B?UDBBRUZMSzMwcVNiWTI4VytyMmNyZ0lHVU1hNC9yd2FSM0ZON0hXQWFOenF5?=
 =?utf-8?B?a2tQTytpZ1dwSGNSMG03aXFDUnFhMmp3dnd0VUpySmNwMm05Y3JLQU1jODV0?=
 =?utf-8?B?NUJ5MjVCU3R0OEp6VjNKSC9FQ1dNMitGbWZ3OEl5ekFLQldMV0IyWkZUTG1P?=
 =?utf-8?B?QmZ3VDErVUdJZGFFLzZTSlhhdUVOTTFYWksyTjFpazBEWGFxSVhDb0xNMTIr?=
 =?utf-8?B?MTV3dWQyVVhIUEMvZGFqaHliOTJaR1pDTjdwZVFOSS83OUZGZTVld0ZOSnhN?=
 =?utf-8?B?NVhqL29yQ0t3eFl4QmFwMTZ0VmZrK0xPc1RUZjNObkJaZWh4UVM3S2F1aFA5?=
 =?utf-8?B?amtiMElOb1lIbytMa1dUUGNSMk9yNEg1NkZTSU9KcUR6NEUzVHZhUjE4RXVx?=
 =?utf-8?B?dmlqTzgrUnlFMWVNUmdZSVpHYWpPWHZ2WEV2b2tPN1ZsRnFMVldOam82R2dv?=
 =?utf-8?B?ZFpLdUl3QWttK0t2aGJxUDVzNkJ1eUpLQzJDV1c0TGJKU1NXbExadU45TEZp?=
 =?utf-8?B?QnRjL3gwTDh6ejZiRmk5YVovMWpweGo2WGw4RXNPSEVHQXV4L2lFcXNmNkNQ?=
 =?utf-8?B?TjlZZzI0VlRzYWtteHVMd2QwTFRxUHF1cnIrMlhpeTMzU1VPMVZFUVBkNUVQ?=
 =?utf-8?B?RGxZNGVMSkJZeW1veUQwL0dKb0kvMFdFbGszMnNYOFFwelJ2bko0OUZvSU93?=
 =?utf-8?B?U3F4OG0xRkFMVS9CQlBwa2QyM0xqYkNCaTdyN1c4aFhzQUNjb0tVZ05WdkhF?=
 =?utf-8?B?QkJwcmtRN1RIbVoxNnV6bG1HYXlvVnFiU1U2QUF5WnhSSVFvdCsxOGRPdmJa?=
 =?utf-8?B?cWJKNzhUamR3ekl3cklaNDJyS0Z0OHhYYTUxaDJ4d0hJTlNjK1ZncXdvQU9o?=
 =?utf-8?B?UmVvUHgzaExaNWI5eFhFQVY4b3RkaEV5enFMZ3JJZlF2TndNQzNETnNteDIx?=
 =?utf-8?B?M1dxNEpZTjB4bURPRWJ4amQ0Q2FZQUdaTE9GeExuYjUwZUhqT282Y1dLOWRw?=
 =?utf-8?Q?IYok4FeTQX8mQC0M/XsxoaTD2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6ef7b6-18cc-4cb7-741e-08dcf26fb5e6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:01:18.9991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Gj9AH+NRKGSlhfkOmbId3LMHhEHhf+FZAca0jNdkTjkqamYsYDqIW9DGEzspEReCU2vcotmkl9mQLC9wtNP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
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



On 10/22/2024 12:20 PM, Felix Kuehling wrote:
>
> On 2024-10-14 23:51, Zhu Lingshan wrote:
>> This commit specifies data type struct amdkfd_process_info
>> rather than general void* in ralted functions.
> Several interfaces in amdgpu_amdkfd.h use void * as opaque pointers, e.g. process_info, mem_obj, drm_priv. The reasons are partly historical because KFD used to be in its own kernel module. That said, there is nothing fundamentally wrong with opaque pointers when the upper layers doesn't need to see the contents in the objects returned by the lower layer.
void * is workable but imperfect, IMHO it representing a compromise that could ideally be improve especially when we know exactly the data structure type.
This change provides better readability, type safety, compiling checking, and avoid the castings
>
> It makes me wonder, though, why you're singling out just process_info? Are you proposing to change more interfaces to eliminate opaque pointers?
That is because I just happen to read process_info related code, I can surely improve others if any individuals of them also represents a certain data type.

Thanks
Lingshan
>
> Regards,
>   Felix
>
>> kfd_process->kgd_process_info is initialized
>> in init_kfd_vm() by such code:
>>
>> static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>                        struct dma_fence **ef) {
>>         struct amdkfd_process_info *info = NULL;
>>
>>         if (!*process_info) {
>>                 info = kzalloc(sizeof(*info), GFP_KERNEL);
>>
>>         *process_info = info;
>> }
>>
>> That means kfd_process->kgd_process_info is type
>> struct amdkfd_process_info, therefore we should avoid using void*
>>
>> Using a specified data type other than void* can help improve
>> readability. There are other benifits like: type safety,
>> avoid casting and better compling chekings.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 +++---
>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 31 ++++++++-----------
>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>  3 files changed, 19 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index f9d119448442..c1346b8c9ab7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -239,8 +239,8 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>>  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>>  				void **mem_obj);
>>  void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
>> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
>> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
>> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem);
>> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem);
>>  uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
>>  				      enum kgd_engine_type type);
>>  void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>> @@ -299,7 +299,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>>  				     struct amdgpu_vm *avm, u32 pasid);
>>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>  					struct amdgpu_vm *avm,
>> -					void **process_info,
>> +					struct amdkfd_process_info **process_info,
>>  					struct dma_fence **ef);
>>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>>  					void *drm_priv);
>> @@ -348,8 +348,8 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
>>  
>>  bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
>>  bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
>> -void amdgpu_amdkfd_block_mmu_notifications(void *p);
>> -int amdgpu_amdkfd_criu_resume(void *p);
>> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo);
>> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo);
>>  int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index ce5ca304dba9..2a1ee17e44a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1376,7 +1376,7 @@ static int process_update_pds(struct amdkfd_process_info *process_info,
>>  	return 0;
>>  }
>>  
>> -static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>> +static int init_kfd_vm(struct amdgpu_vm *vm, struct amdkfd_process_info **process_info,
>>  		       struct dma_fence **ef)
>>  {
>>  	struct amdkfd_process_info *info = NULL;
>> @@ -1552,7 +1552,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>>  
>>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>  					   struct amdgpu_vm *avm,
>> -					   void **process_info,
>> +					   struct amdkfd_process_info **process_info,
>>  					   struct dma_fence **ef)
>>  {
>>  	int ret;
>> @@ -1639,19 +1639,16 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
>>  	return avm->pd_phys_addr;
>>  }
>>  
>> -void amdgpu_amdkfd_block_mmu_notifications(void *p)
>> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo)
>>  {
>> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>> -
>>  	mutex_lock(&pinfo->lock);
>>  	WRITE_ONCE(pinfo->block_mmu_notifications, true);
>>  	mutex_unlock(&pinfo->lock);
>>  }
>>  
>> -int amdgpu_amdkfd_criu_resume(void *p)
>> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo)
>>  {
>>  	int ret = 0;
>> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>>  
>>  	mutex_lock(&pinfo->lock);
>>  	pr_debug("scheduling work\n");
>> @@ -3093,13 +3090,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>>  	return ret;
>>  }
>>  
>> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem)
>> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem)
>>  {
>> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>>  	struct amdgpu_bo *gws_bo = (struct amdgpu_bo *)gws;
>>  	int ret;
>>  
>> -	if (!info || !gws)
>> +	if (!pinfo || !gws)
>>  		return -EINVAL;
>>  
>>  	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>> @@ -3110,8 +3106,8 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>  	INIT_LIST_HEAD(&(*mem)->attachments);
>>  	(*mem)->bo = amdgpu_bo_ref(gws_bo);
>>  	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
>> -	(*mem)->process_info = process_info;
>> -	add_kgd_mem_to_kfd_bo_list(*mem, process_info, false);
>> +	(*mem)->process_info = pinfo;
>> +	add_kgd_mem_to_kfd_bo_list(*mem, pinfo, false);
>>  	amdgpu_sync_create(&(*mem)->sync);
>>  
>>  
>> @@ -3136,7 +3132,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>  	if (ret)
>>  		goto reserve_shared_fail;
>>  	dma_resv_add_fence(gws_bo->tbo.base.resv,
>> -			   &process_info->eviction_fence->base,
>> +			   &pinfo->eviction_fence->base,
>>  			   DMA_RESV_USAGE_BOOKKEEP);
>>  	amdgpu_bo_unreserve(gws_bo);
>>  	mutex_unlock(&(*mem)->process_info->lock);
>> @@ -3149,7 +3145,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>  bo_reservation_failure:
>>  	mutex_unlock(&(*mem)->process_info->lock);
>>  	amdgpu_sync_free(&(*mem)->sync);
>> -	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
>> +	remove_kgd_mem_from_kfd_bo_list(*mem, pinfo);
>>  	amdgpu_bo_unref(&gws_bo);
>>  	mutex_destroy(&(*mem)->lock);
>>  	kfree(*mem);
>> @@ -3157,17 +3153,16 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>  	return ret;
>>  }
>>  
>> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem)
>>  {
>>  	int ret;
>> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>>  	struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>>  	struct amdgpu_bo *gws_bo = kgd_mem->bo;
>>  
>>  	/* Remove BO from process's validate list so restore worker won't touch
>>  	 * it anymore
>>  	 */
>> -	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
>> +	remove_kgd_mem_from_kfd_bo_list(kgd_mem, pinfo);
>>  
>>  	ret = amdgpu_bo_reserve(gws_bo, false);
>>  	if (unlikely(ret)) {
>> @@ -3176,7 +3171,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>>  		return ret;
>>  	}
>>  	amdgpu_amdkfd_remove_eviction_fence(gws_bo,
>> -			process_info->eviction_fence);
>> +			pinfo->eviction_fence);
>>  	amdgpu_bo_unreserve(gws_bo);
>>  	amdgpu_sync_free(&kgd_mem->sync);
>>  	amdgpu_bo_unref(&gws_bo);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index d6530febabad..b0426a1235b8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -934,7 +934,7 @@ struct kfd_process {
>>  	bool signal_event_limit_reached;
>>  
>>  	/* Information used for memory eviction */
>> -	void *kgd_process_info;
>> +	struct amdkfd_process_info *kgd_process_info;>  	/* Eviction fence that is attached to all the BOs of this process. The
>>  	 * fence will be triggered during eviction and new one will be created
>>  	 * during restore

