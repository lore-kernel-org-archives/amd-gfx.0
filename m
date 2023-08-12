Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DE3C0015E
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 17:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFBF10E08D;
	Sat, 12 Aug 2023 17:00:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEEE610E08D
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 17:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfYtKeq9FHc8hgTY2ZRvU5pssbC1gvNf3uGWGPl4zfUTrLL25QkNj2ulN7e6rSgEf6M5zkE+/weuWQ5/sw3dcNdYyeGW7gihde+vHtzOVGwK2BsTBvyTztzprzT/QIiTxoaNoXQCmDJMlakjnTOxaDWKalK9XmRHylg4QizLtwjSV2IOuTZPGVf74ZRGW9F2tmpfqNBmbeWQEZhfUyNhxykHhmv7JR8yM6XrLGSAG9qbt+E2YecHU+6R64YF2ZmKRMp0lCPWoNxKgQoldKgKd5qzc0ZhdfyYkFPKf/unItqwt8VxgVZhFqWFh/L33NssrpUgU7yE6CBY7Rxi8gopFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9y93koKK+IQkTK041gM1ImFIaRzFFySrhu9Koom5zg=;
 b=Xyd2YSeT8H7WLFviPZ+mVGqIZzYYoJP6ZYV8esreNXt88DHAJsa/79FDfkOcaM+BOfwsyChgPp+xks/zxZZESbfySgUw+WKqGh9WMGcfWqq6JaT63wvoHTUDIKxsFoImVvUr2pTnZtGPilQImZ+I6yK5VnlcxNjUHWwKCogoELfsRVzLHt1njUhHIL1AU3IJJFd84m1nyorQP7Tfw8d6543XO3bxDUsEdtfLP3a7G8ZKM4pIqJhz+bwrX2zqz5KXAJH9C21HeMDgoXq+h5UTrgGOHi3udOohUyKguzZjUre/dGFksqZct7kFpgZynTfcTOYrC5j3yKhinz0xGPGNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9y93koKK+IQkTK041gM1ImFIaRzFFySrhu9Koom5zg=;
 b=Ew+OISGTgwdkztVMUQjoZEKm7IWZv5ylFFVwLaqp6wOG+jECq1rcVsPhHooi38G4XAgu7gzp9RzDFwPsB40JAVFff9Aah7mv1DkHrv4hWEXOyBZEvviFAirMYPcOFr3i24SE0gXhG+UDgiBJhYYBGVPVSvrHXTM0AFB3KiJ4IcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sat, 12 Aug
 2023 17:00:30 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.020; Sat, 12 Aug 2023
 17:00:30 +0000
Message-ID: <4733316f-a964-8c13-ea56-67e2f5582ab2@amd.com>
Date: Sat, 12 Aug 2023 22:30:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out of
 drm resource
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230811202337.1867891-1-James.Zhu@amd.com>
 <20230811210627.1888328-1-James.Zhu@amd.com>
 <BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com>
 <1f81e70b-2469-6042-8d97-d150e67dc9c7@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1f81e70b-2469-6042-8d97-d150e67dc9c7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df360d7-7469-4fa1-8ad0-08db9b55a1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTHEdvtABdlrWhrbbVpoKA/+M8dMLHOZmncMXOW+zZJ61yuZsnZLfDubY7jwQRCNXnlTIQiohmedWBDcX+ggSv0HNcWlIkGXX5rnQ3XV+P4WhWcELuE+71l3nJbiHKkTY828VMBvMHdrZ0Vav5ibWd+Hn1zpuZyUdEMrMPVHIYyhgF1dQMc+S+CoOWYCzVL8SEymEFNqJHUTKGOpLsQ0y9mQvbpOV59dM0Qi8dMooJ1NetOekW2r5a1FYbudi/8jdw6jqwiCdzynEge7xdaLs+eVXTqYzrb+FKNEsa9574azmeCW6+DsCkTPpkbBBSzJcUDlPwmFF8wbsRkpQWHpXKDwTU4RgXw04u1qpqVi+t/UGSG0ieEcn4tEcV2V6O9H4e65kBzfR2CSsT5znpxvdbBp0aDlFTCO1k3aowz2m29qBEJeerQ79OsBknVw/YmyZrXULsu5qgxLFSScw6muWTIkpfkZR9f9kO2iQWTIbl1iQwiRwO7Qn6ApS54PtL4JAprAZ3d8X1OSaGio/vE2fWO6OZK0tgPml+Ley9cnjHAbGQRrNDb8dCqf5E1JLBUfW8/HoBV1plpeE5DXI0IkU93yLV9sSgR8+ccHNZFgDeRkQJcuntr5Ehg+FIDGfQBXgElwX1Vq0oUGOLVJRLQZc2LvHHbsL0c9QyQOpoGBVEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(186006)(1800799006)(451199021)(8676002)(31686004)(966005)(6512007)(5660300002)(36756003)(31696002)(86362001)(38100700002)(26005)(6506007)(83380400001)(2616005)(110136005)(478600001)(6486002)(54906003)(66574015)(53546011)(6666004)(4326008)(316002)(8936002)(41300700001)(66946007)(2906002)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXg3cXdDVTlkb2t3SHJRTVplTDNpWExyR2x0UVlyZ3V2dTN4NDJ1QTZ5TDJq?=
 =?utf-8?B?bjdBVFJkUlMxNHZJMWRTRk8wWHNrdklzMkJJa2p6Z3g5Sk04aWp2N0k1UVdW?=
 =?utf-8?B?OEYrZGd1K0E0STNJd0lOeTQ2OUQ0KzZLcjBpY2xoRm5iZGk2dWxDc3FkOXI3?=
 =?utf-8?B?SThvanJNaDNUVFBOV2xxOERMRVB0VEFxN0RVYkdLNDhDUlZuWk0xOWxHS2ZY?=
 =?utf-8?B?NFVzalJnVElmenhxRGkzdFpWZGUwUVEvemllUEg0dytFQVo3UUFLaXFwc0ZQ?=
 =?utf-8?B?d1pmenpUQkxmM1pDS1Bjelg1UVJvSG1nN3lsczUyOVJYNFgwQU9rRFJ5QUgr?=
 =?utf-8?B?eWdHc3RrWHI2Qk1wWFNsYU94cVhYOW94UXgxR2g4M3lLd042SXpSdGIvMnY2?=
 =?utf-8?B?RXdsZ0kzbWRtanl4QjRaaExmdm8vVi9LY1ZzY3lyUzBWZm9IL3lBQjJSVWYz?=
 =?utf-8?B?VENKWFVzbkFrRng2VzRTeE1ETTNXaXVDL0tYYk9lYXlDekM3NnE5K2FGUkpq?=
 =?utf-8?B?d3p6RnZBdHNsUlB0V2oyZHdFc2ZJeTNmRGovRDlLS21FWkdvQTZPSmc3TTBm?=
 =?utf-8?B?R2FZMFB3a0p3d3YwZ2xtdzkxUUswcWdNYVdjNjgrK3RvUXd6YjlkTFNkYk9m?=
 =?utf-8?B?UzFHZzJGWHVPQzdoZVNEN0dTbG9jQkdXVWRDSi9RS0FobllFT2tBRVVOWUQw?=
 =?utf-8?B?SDFVdEVZaWlUeG1kQWV4MVY2U3NJRDJrdXV1Q0VnVWZMclhpQjdIZks3Lzgv?=
 =?utf-8?B?V0lFeVUwUjd4SkNTc1A2enBvOEovbHJKNzM0OVJiQkU5TEtaeklQcHA4KzJQ?=
 =?utf-8?B?cHhCQTNac2tPaThNUUlKSGtkU21nUnZXa29SNDdVSVdLcHl6aWtYR3BjajlC?=
 =?utf-8?B?T3IvK1NDSllkWFgwVDdUWDd2MXBGT3FOVm9HSS9DZ2p3K3Fxd2Z5UzRFWVV3?=
 =?utf-8?B?VWtyQTJ2OEFqakNkL3IvbnJuL2gzeXBxWkdxTU9BQXMwQkl2WVN3Y1N6YUov?=
 =?utf-8?B?bjlxVys0MWFaU1pucnBBMER2RDFVTnU4RGpOblN4SWxKL1o1UkZLZXpJOEs2?=
 =?utf-8?B?S2lKU0g3YmJnNWR5Qk1mNW15RGxKWlEwbndHWFppemUyempNLzNxSFpFRGg3?=
 =?utf-8?B?aG9zR0gzaXVFdXA3QUR6RkNwWkNRTFlTR0NJS3pwNEIzN3VlVjN5TWxZbkF1?=
 =?utf-8?B?M0RFaFA4ZW50L0ovcmdIcXN1WnpUZm4zR1FmeHdjSHE0N1lobVgvOUxacnpR?=
 =?utf-8?B?Nnp4YndCQ0Fwd2M2Z29zbkJtclhFKzl4MnhQQndoc1VLenZGeEFDYllRblR1?=
 =?utf-8?B?bVErcndYaHhWTjBmdzg0WWVhMnByV2VsQ0Z1aktuTUJyVXY0Z2o3a0xFT2FK?=
 =?utf-8?B?SEpmUE40SHBTTFdMN3YvZklid3VhZEpoSmhlTjQzb29BTkJNakp6emExQ2NC?=
 =?utf-8?B?aHhQTjdKMHBrUmdTS0hXRElKblhpb0QxUXdQbGxWSG5EVWNCSnhEMUZqZml0?=
 =?utf-8?B?Y2sveDJUSTIvd3FDSnI5Und6YUVGdXp2ZHhnY09tQldsR1JQU2lpQnFJb2ZI?=
 =?utf-8?B?TmdqK2lRUHZGOU5hWFoxbmFibGtEczEzOUF0UDAzM3dqaEpmbXF6bi9SZ0E3?=
 =?utf-8?B?bmVuSEMzTGdVK3lndHBhZ2w1TlFneFBjcy9kSGxZRHg0aXo3RjkrQ1ByTDRj?=
 =?utf-8?B?Z2xjWTV3MGRmd2g1UEtwWmtOVXhOVG1GU3NmWGZTUWxaN1RkbDNrWnVVWjBC?=
 =?utf-8?B?bnY4WGsxZmJEcU1WOE5KUW45dW53enE4ZzkyNmxOZ3BoR0FiMFVCc1VEL1R3?=
 =?utf-8?B?aytDdXd0dlpvdTltQVZZY01xdkVRZFJiTDZ5WVQrd2dFQUZRbXYvVklqRHdp?=
 =?utf-8?B?QVdITGowVm8vRXZIdURVOHRqaXRJVEVLdlFMampwekxRbGw2cUc5YlJzSXps?=
 =?utf-8?B?NHM1VGlBMnZteGZ5Y21qcGRtU1VxWCt4WmE5STcwUDZ3cWpoYmtEQmlMMm1W?=
 =?utf-8?B?T0VVRXBpNE9nSWxyTUhtMjJ5cEQ2WDk2UVhRN1hIWnNlVWVHVWZZK1FBUmRh?=
 =?utf-8?B?ZEFnUGF4dnVVYUt0MStIczl2d1p0OEEwb2pwRWRHc1NmSW1BYmVHMXhPZFk0?=
 =?utf-8?Q?zvhRbqhQ9gsiW3EA/h3hiMxWw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df360d7-7469-4fa1-8ad0-08db9b55a1f3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 17:00:29.8184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/TUnkZRYYXUnxAUxkzwvueFv9+fDqrmCtGs25r/EFBFXYHeddegOuEzb51URjl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/12/2023 6:14 PM, James Zhu wrote:
> 
> On 2023-08-11 21:39, Lazar, Lijo wrote:
>>
>> [AMD Official Use Only - General]
>>
>>
>> A dynamic partition switch could happen later.  The switch could still 
>> be successful in terms of hardware,
> [JZ] Only ignore render node assignment, and remove visibility in user 
> space, xcp continues to be generated as usual. so switch should work as 
> usual

Switch is not useful for the user unless the apps can make use of the 
render nodes. A 'success' from hardware perspective doesn't turn out to 
be a 'success' for users eventually to make use of the extra partition.

>> and hence gives a false feeling of success even if there are no render 
>> nodes available for any app to make use of the partition.
> [JZ] from driver prospective, the switch is real success, treat the last 
> one harvested in user space.. there is warning in kernel log, and final 
> solution for more than 64 nodes is on-going

The render nodes are allocated during driver load and the message will 
go unnoticed. We could still allow the switch, but the message should be 
there during a partition switch like 'only x/y (x out of y nodes) are 
usable'. The worst case is - only 1 out of N meaning no benefit - and in 
that case user may switch back to normal mode to make use of full 
compute power.

>>
>> Also, a kfd node is not expected to have a valid xcp pointer on 
>> devices without partition.
> [JZ] won't affect xcp pointer, only ddev.
>> This access could break then gpu->xcp->ddev.
> [JZ] added skip when ddev==NULL

What I meant is xcp in kfd node could be NULL on SOCs like NV series. 
There should be a check for xcp before accessing ddev -
https://elixir.bootlin.com/linux/v6.5-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_device.c#L794

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
>> James Zhu <James.Zhu@amd.com>
>> *Sent:* Saturday, August 12, 2023 2:36:27 AM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Lin, Amber <Amber.Lin@amd.com>; Zhu, James <James.Zhu@amd.com>; 
>> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Koenig, 
>> Christian <Christian.Koenig@amd.com>
>> *Subject:* [PATCH v3] drm/amdgpu: skip xcp drm device allocation when 
>> out of drm resource
>> Return 0 when drm device alloc failed with -ENOSPC in
>> order to  allow amdgpu drive loading. But the xcp without
>> drm device node assigned won't be visiable in user space.
>> This helps amdgpu driver loading on system which has more
>> than 64 nodes, the current limitation.
>>
>> The proposal to add more drm nodes is discussed in public,
>> which will support up to 2^20 nodes totally.
>> kernel drm:
>> https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/
>> libdrm:
>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>>
>> -v2: added warning message
>> -v3: use dev_warn
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
>>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
>>  2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index 9c9cca129498..565a1fa436d4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct 
>> amdgpu_device *adev)
>>
>>          for (i = 1; i < MAX_XCP; i++) {
>>                  ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
>> -               if (ret)
>> +               if (ret == -ENOSPC) {
>> +                       dev_warn(adev->dev,
>> +                       "Skip xcp node #%d when out of drm node 
>> resource.", i);
>> +                       return 0;
>> +               } else if (ret) {
>>                          return ret;
>> +               }
>>
>>                  /* Redirect all IOCTLs to the primary device */
>>                  adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
>> @@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device 
>> *adev,
>>                  return 0;
>>
>>          for (i = 1; i < MAX_XCP; i++) {
>> +               if (!adev->xcp_mgr->xcp[i].ddev)
>> +                       break;
>> +
>>                  ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, 
>> ent->driver_data);
>>                  if (ret)
>>                          return ret;
>> @@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>>                  return;
>>
>>          for (i = 1; i < MAX_XCP; i++) {
>> +               if (!adev->xcp_mgr->xcp[i].ddev)
>> +                       break;
>> +
>>                  p_ddev = adev->xcp_mgr->xcp[i].ddev;
>>                  drm_dev_unplug(p_ddev);
>>                  p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 3b0749390388..310df98ba46a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>>          int i;
>>          const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
>>
>> +
>>          gpu_id = kfd_generate_gpu_id(gpu);
>> -       pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>> +       if (!gpu->xcp->ddev) {
>> +               dev_warn(gpu->adev->dev,
>> +               "Won't add GPU (ID: 0x%x) to topology since it has no 
>> drm node assigned.",
>> +               gpu_id);
>> +               return 0;
>> +       } else {
>> +               pr_debug("Adding new GPU (ID: 0x%x) to topology\n", 
>> gpu_id);
>> +       }
>>
>>          /* Check to see if this gpu device exists in the 
>> topology_device_list.
>>           * If so, assign the gpu to that device,
>> -- 
>> 2.34.1
>>
