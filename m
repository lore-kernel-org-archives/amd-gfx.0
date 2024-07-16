Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D123C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 15:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D923A10E779;
	Tue, 16 Jul 2024 15:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HJjd0hvG";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBA610E789
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 15:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZqwAOJWCPVBC/A/CkiJc40pv41EuYRBCvqzCgJhFihHnxgyzwe7c2LuSb3/AS22BABp9YaSI3eBTt6ZS4X1hdvCzYJfmIjwkUz/rfYAq2PHrYmo3EgouAN7oqZiocxhIu30gvdUDKPL7JEisDTx5do+HuRsRAsi9u7KFQhthmkKcgv1qwMlZPxY+wyYEY9crEIi/nBrrpBtHXiIgcdSX4+fE6micp45RrCejGsP4+xuhYerLUA6An9+m24NHjSUOn6uhE4uZIpobHaFDSMaNv1YwwRv2RTPe0xl0CdfnKnW3Av1OYgkqJNIrOS4DtN654nOlQVjry9az8cC8iXGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKUSKFUmoxeF/7snWXHOV1BU+DtjbbtsFvltiZxIKCc=;
 b=CNl5l46Y0bx5Q56F9MQs6+JGx+UTafX3Lc5rM7OWJw3oMIq3pv3Frde846I3kOA0xc48JpN44bwzTo0TBwFSjoWikl5S1x1X5ybkgbJeFhuSDIdeMzCuTubB2r8hJSK3zYQepdcKnoT9tOjL/Aoy0QdspNrj2R0+u8sI3DDq/Yu8bobU2f2A3aXkJcp7naPzmgq+fE/ATE3LEdFSGNJrcn1xCTX6kN3BVJV84uL2KmOPTO0jizMgyJytxqJd1rZlLcFxtbX6hkxmXCXtSLj4nI/Pw+fvuZsH3EkvfzrkZ29YFw5lHguTPtiIWWa3c+iWWSAIP3orpO6HupUukM9/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKUSKFUmoxeF/7snWXHOV1BU+DtjbbtsFvltiZxIKCc=;
 b=HJjd0hvGSRcciYoWExI+WOUF+kR6Y876FoBumstWRvMC5uWpWM0GbIIP+WZc1pMP/W3yJWHqZ40JqaBrCzHl12bkNZr6+aj5FF/6gnP4T2N2lSrdbyMU2uME4dTJP1YE6Lcm+WLd0Y5xNYvQtUtV2WDNpZcPNvc6zNfM84prt9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 15:28:38 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 15:28:38 +0000
Message-ID: <9182e4a0-955d-451e-bb77-efcc1bfa4362@amd.com>
Date: Tue, 16 Jul 2024 11:28:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add null check for dm_state in
 create_validate_stream_for_sink
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20240716150828.218679-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240716150828.218679-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::12) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: b33767f9-e6bf-4930-4579-08dca5abf73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y055S3JUM2pnbkl5dlVwaVg1b2pZNkJva2xaYXR5bEM0YkhrUFBxR1hYcURJ?=
 =?utf-8?B?dmlWaU12MjdUZ2M5VGtaS205WW4rR20xZ2l1OGlhbHR4ZDJBVGdBMXdnVXI2?=
 =?utf-8?B?ZHRXWXBGekdqNHljbzRleHJIOVNzY2tvSEZhckloK3Q1OWpBTTY3eVZ3S1Za?=
 =?utf-8?B?WXdCZlkwZ0JxeFRNeTVTMXhRQlg0dGxxRFdkNENtSlBTQlkzYm1zaUQzem5N?=
 =?utf-8?B?MkhWT1dYcUZacEI0YWxLc2JlNjJ6SGYwSGxCZVA5WXBmUmI0L25SckxLWDls?=
 =?utf-8?B?YnRqTVR2UktkS0w4WTRDa0ZuRm5YaEJOcGVrWmM2NEQyN0lFZHVkd01aTC9t?=
 =?utf-8?B?YndqL3NUMXdCVFpLQm9pOENnS1BOelZLR1pwb3FmaytjVFQwOXBWNXNWbWw0?=
 =?utf-8?B?eERnWE92dG8wUUZ3NkI3WU1ZVTl6aTA0L0cxRkc3VTNSTDRjanovQjdJRmZJ?=
 =?utf-8?B?ckVDTTlrRzYxeGxtWjhIN1dENjB3Yk1rY051eitjR2xodWZNcFZUdnhUUm8y?=
 =?utf-8?B?SGthVEJhenErTmpOeTc5RTZvUkhKSXduQmFSaHlPTllnU2psM2pNV1RrbUd1?=
 =?utf-8?B?a240TGpubHVSOTBUcFFrZDhGb1VqMEFTSnE5bTBvTFpSK2hYRDZ0bzF1MDlI?=
 =?utf-8?B?UFdVZGxyWW00MnlRL3NTZEhFMkdsMHZCNzZxUmcvQXJuQTFZc0hPSTRqclpH?=
 =?utf-8?B?YVFxYkYyMjZ5QTNCRWt4bWwzb2JVMjFNV1I4dUVEalJsSXQwMWxUTHRrbGpH?=
 =?utf-8?B?dmRKeTFtVzh5TU9nQ0JhOGVDanJmcGp4c3hHOVZ1OFFNcVA3K3RSUFRPQWMr?=
 =?utf-8?B?V0swSDVQMVRkOEJpdVJqckgyWm5aNTN1dERRUTZpbmE4aFdBZks0ZHMrQzFI?=
 =?utf-8?B?U0h6NU9VVjJ2ZVJMQmo2d1dnSHJVUUxvWkdwbktBdlh3dUVSYnRkUEZxbisx?=
 =?utf-8?B?OGVaSVBvenVzN21uL2JJL3BvTmJka096N1JHb2NvcndobDQ1TG5VWWNTRDZt?=
 =?utf-8?B?YUNIK2NEdm4wRjhoMFp3TkFGelp3Z2laSlZSbmhkWDhqMTRhM1B6Z3E0YzhS?=
 =?utf-8?B?S05BVXpLbDI2S1AxamhPekU5ZTVOTCtBc0ZnR2RncGNncTFTSmo2T3NodGJQ?=
 =?utf-8?B?RGthZmhGM2ZnOE44V2NWY2NZNDlkY0xIdkc3cGhDQzJHWmc0clhkOU1CZFRo?=
 =?utf-8?B?QzE5ZlNlY0tFY0ZodFlDRkpuckd2aDhYbWt5OFJOMGRNM0xvcmNwYUxLeXk1?=
 =?utf-8?B?Ti9zY0luL2VCL3JUbWZmd1Zoc0psVFZwbkRhNFlVN2Q4YlBjYVhUZDFIakI3?=
 =?utf-8?B?Zi9nRjF1Yzh1dE0xMWxPUk5JVDVrVWExTFBKTHZuWWFuc0MzUnNrRWpxb0do?=
 =?utf-8?B?Znl6MzgzYjRvOG04TG94UElIeVc2aHNUQTlVSmRDT3E0Y050OTFxWmZCQzVj?=
 =?utf-8?B?K0JDclFyMldBN0pYVklmc2ZEMmZSeXM1aHJKM1FWRE9kWFAwbEN1dUtJQmRK?=
 =?utf-8?B?ZXlzaVErZXA3M2tpWjZsanM1UEN5WmpKWUdSMlhNV010VjV2UW5GKzVhNURn?=
 =?utf-8?B?NzZ4Wm10RENMWk1QOHVJV3NYZ0gvTzhFY3daL0NxWlBSSnFwdFN6cDNFY05B?=
 =?utf-8?B?OW0zbjlhc0dUTFl1WU90ZktqS1FuYmRoVGE3QW96UG8xeHVWVjZRNjRGdWpX?=
 =?utf-8?B?NWt2V0UvZkNwUnVlcXhuSy96NHFURUZ4b0NPMFl6UVlzUi9JSWtVTW9Kdi83?=
 =?utf-8?B?VzFsd0t2QXpSaFlVbkVXcW1uOWhRTTNud3d6Tm9ETzNSQ1JMVjVGWE1WTFlo?=
 =?utf-8?B?WTcyUVB3MW51UkkzaDRvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhtUFFjVGx0VGw5M0lIRXRTQ1NWYXpKV3VIWUgwZG0wbU82WTZBdXArRGc4?=
 =?utf-8?B?RlBwdVBaSXlUUFVMNmhCUlRJQTE2bEJQbWlBMVZ5Z2J0TlltWEZoVnovK2Vr?=
 =?utf-8?B?ZHd0SmFia2Z0SzlVamQ5SjMwbjdFNkpLdzRZcUFjQUlZa1BwN0diVS95MXh3?=
 =?utf-8?B?R1RUN21aWW9yVUNwL3Zrc3A0VXVTTld2cVJvZHV0bGtOU1RQZitDQm50eml0?=
 =?utf-8?B?TUo3cGtXQzViNEVjdm9UUDRzdmsvMGVIL29lWitadlVWWEJYbmtsN0xCUHhT?=
 =?utf-8?B?elJzbHB2UmFNRHJGQWxiNURsSFkxbUoxRklpZUpPaXBrTGRaWUsyOVhWdCtC?=
 =?utf-8?B?YzhlMEt0OG1mTHlVK25keDc4K2dESW9HcEF3SG1XL3psLzZieDdtRUZqdnNk?=
 =?utf-8?B?NjdnME1xeUxMSDY4ak9sMDJoZ0NkODg2aEp6NnZ1MFdlQzdUMjNIQ2ZoSjcy?=
 =?utf-8?B?RUFFbHhyTzlaMTdudkcwcC8yK05jTGc3MTZxYjFBNDcyK3k0SEdBemFLR3dr?=
 =?utf-8?B?TGZCSGJoZXhnbmRIdEpuSUFsUndiMW5zOUJaUDY0SVN3L2dXMUd0Q00zeVFK?=
 =?utf-8?B?Sm5PWFdMb01FejBZSTlpRFBqSmphNjVyV0RXVmxmdGNMLzlRRHR6SXNkclVx?=
 =?utf-8?B?S2NmeVk2SWI5ZlkwYTVEcXFxckVTOGJqV1ErR2RQWENaNlNuSnZpbWFCejFs?=
 =?utf-8?B?S2w5YXNkaDFsZXlvSkQxbjQrdXZZNFJDWHAxOHluRER5bG1CT2JIVjNvUFBR?=
 =?utf-8?B?MGJqWW44K2JxSlVHU3VNSzZRRkRWN2dlOGtEL3h0N2Y2SEM3SERLbldoT0t0?=
 =?utf-8?B?cGZEWWtJQ3liMXRzMTMybFVwSUkyS2w5dzE0WjRzdDc1M2s1dDlpbnFZVGF2?=
 =?utf-8?B?U3hlbzJsNjZjK0dpNGJldmFEb0JDS1FrR1doZG9ReWNjQTNPN212TVkyNStZ?=
 =?utf-8?B?RXFhQnFMY09zVFFMVWJ4cDcrSk9QNzJCMlVpNWZJbCtyNlpacVk0a3B5M0U1?=
 =?utf-8?B?NlVWbUk4RWwwV1orQ1FuMkY0d2xid0drVEp5Z1ZSVUdWSURNK2g2WFZDckRR?=
 =?utf-8?B?eU1LMkEzeTNMY3JTT2wxcjVoVWJrZHpEOEJNQ242VFl2QjJaa3Vpem5uZkhW?=
 =?utf-8?B?WktSMHRlSnNNelM1UEtwcHg1T0h4UVVnc2wrWGtBZWpCbFRnUFlFZ3RsU0ZE?=
 =?utf-8?B?VktJYmxrMGtJT2JmZWdHeG56TVNoYldIV1pBRWhjblhpbHpQT0dmdmp3WnRD?=
 =?utf-8?B?RGR0cTM2Rk5HNGxGek85NmhaS0NJQ1Y2MjRSeFlvYjUxKzEyMi9mdU05TFYy?=
 =?utf-8?B?Qmtid1hxSkczL3FUUExZejMybGMxUEhSRnY2c1czWFRFQm5ZQmRTbm5PT1pq?=
 =?utf-8?B?VkJucjZhdWQ2Zk1CUXFDYWR5UDhVbGxjdkxUeTFqVmMzaXZrWWtBcjZ0TmNa?=
 =?utf-8?B?RDBtNXc2MGVrNXhSbU5GcnI3L1AvWjRhajJ3SDFVcFpBbk9lUDJYckd1NHZ1?=
 =?utf-8?B?UThlZGlWSW15UTJ6N0dmSDU2dkJRVFBkdjIwK1owSjhmWGpyVVRwY1JqT3RQ?=
 =?utf-8?B?c1ZVQjI1b0EyaUJ3cW5FeG5lSC9jaUUvVVNnQnZCVUlCdkx0NHJkRTVBT1lW?=
 =?utf-8?B?eGJkMzBnNWpYSVcrWlJjYVlHV041VUl5dGdZZ0NTc2s1QmxZR3hzYzdwd1VT?=
 =?utf-8?B?ZlFibFlNVFhMbGJrRitPZDZHMHhRZ2hCMkdab0Rzd2VqK1hmbXlnaEg4bENQ?=
 =?utf-8?B?K1pWRkhuUHVuekw0RHpjM0h3dmRocFdrZm94TE1tUjM1TU95Q0tUSlJhMjh6?=
 =?utf-8?B?czVNcFBBZDlKQU9lSXV2SzFadk5JakIvcGZFZGFrTDI2WnY4WkpFK1RINUdD?=
 =?utf-8?B?eWxNNlIzbU02Y1RBTmMyTlF5WkdLc1JGVlVCM29xc1h3eURnTGUrOHArZ0dx?=
 =?utf-8?B?dWNya3Y2ZE83eU5WMzVMYk1SZTI3ajhQelFKeTl1VHFyYVp0NHAwVnIyOGtM?=
 =?utf-8?B?S1VYM1Nab3dqTVdXcDdBY093bWswNUVTdmlrbThYRzl0bVBIRW5KOFY0N080?=
 =?utf-8?B?L1hjMVMyUThhbGNiaEtKVTZzUGRiaGFJRjkxaldVYzJDSTQvV3N4bVZkd0ZR?=
 =?utf-8?Q?rq2JaoaPgPv0GkkoX8EA0pwwm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33767f9-e6bf-4930-4579-08dca5abf73b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:28:38.6655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Tm7PXYZPVMKG9T+DL42NhVx+Z3mWb9lkxRHGdBDaYN+2VfHiRCNN6o53CDTPBioQPv3kafoLZq9CVF9uR0jjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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

On 7/16/24 11:08, Srinivasan Shanmugam wrote:
> This commit adds a null check for the dm_state variable in the
> create_validate_stream_for_sink function. Previously, dm_state was being
> checked for nullity at line 7194, but then it was being dereferenced
> without any nullity check at line 7200. This could potentially lead to a
> null pointer dereference error if dm_state is indeed null.
> 
> we now ensure that dm_state is not null before  dereferencing it. We do
> this by adding a nullity check for dm_state  before the call to
> create_stream_for_sink at line 7200. If dm_state  is null, we log an
> error message and return NULL immediately.
> 
> This fix prevents a null pointer dereference error.
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7201 create_validate_stream_for_sink()
> error: we previously assumed 'dm_state' could be null (see line 7194)
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
>      7185 struct dc_stream_state *
>      7186 create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>      7187                                 const struct drm_display_mode *drm_mode,
>      7188                                 const struct dm_connector_state *dm_state,
>      7189                                 const struct dc_stream_state *old_stream)
>      7190 {
>      7191         struct drm_connector *connector = &aconnector->base;
>      7192         struct amdgpu_device *adev = drm_to_adev(connector->dev);
>      7193         struct dc_stream_state *stream;
>      7194         const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
>                                                                 ^^^^^^^^
>                                       ^^^^^^^^^ This used check connector->state but then we changed it to dm_state instead
> 
>      7195         int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
>      7196         enum dc_status dc_result = DC_OK;
>      7197
>      7198         do {
>      7199                 stream = create_stream_for_sink(connector, drm_mode,
>      7200                                                 dm_state, old_stream,
>                                                           ^^^^^^^^
> 
> But dm_state is dereferenced on the next line without checking.  (Presumably the NULL check can be removed).
> 
> --> 7201                                                 requested_bpc);
>      7202                 if (stream == NULL) {
>      7203                         DRM_ERROR("Failed to create stream for sink!\n");
>      7204                         break;
>      7205                 }
>      7206
>      7207                 if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> 
> Fixes: fa7041d9d2fc ("drm/amd/display: Fix ineffective setting of max bpc property")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d1527c2e46a1..b7eaece455c8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7195,6 +7195,11 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
>   	enum dc_status dc_result = DC_OK;
>   
> +	if (!dm_state) {
> +		DRM_ERROR("dm_state is NULL!\n");

Use drm_err() instead, DRM_ERROR() is deprecated.

> +		return NULL;
> +	}
> +
>   	do {
>   		stream = create_stream_for_sink(connector, drm_mode,
>   						dm_state, old_stream,
-- 
Hamza

