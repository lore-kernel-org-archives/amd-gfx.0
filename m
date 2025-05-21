Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E170CC54E71
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 13:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5607D14B5A5;
	Wed, 21 May 2025 13:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xd3Pf/Pk";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CF511A2E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 12:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCy/fQtnxcEpq8w4QzR5NcwosE8I8bacLnL1ODoB+YtV6Li+jk9ev24c04z4IrTQ5AsQjAQ0PNr78qsSrRTaCinGSQxMwotbngVogzmRwQXLrY8ynw/OufWO/IiKxbcGyqoGihsDOp3j2cwicyitdlArF7X/Se5tw/v9D0C3hgK/pnEkphKH7dvb8+gG6ytulwJWx2c0eEMC6TqtQ9aSgFV0hkJ0pALCggMvsqxdXDAOgYhd8ai06cqaixN/+3JzIrPCwU4l0Jy/Ur8MKyS5Ln7Ky6AZ7+XKWpVxnx0Jh2eghe7UlyjJ1wXxuDnEQE+4jcKmcXBiuONoDW+DvW1UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEGRM+qwXVifhXpjW0be+IFBhs8KXEdjTWtt5HETdv8=;
 b=cTmxGRuEEcbGWa/9zDXMTkecLoiUQbqmmEBKYcCIJs4aiaLN/LhMkji6ImtUM2TffxTxfjQBw+R8H2uobHzpGaY9O/vLZe/YIYxZAf7IWJRZgZzdzMnmSWjd9ri2zlrbGov8xlcUpO1J0pqhELd+c2WgpB43zVIPcBgV4582bV0j00waL2OQhvMuoZuDeW/sWM0pgnjWTLJzzsdsjs5VnmYIlIfvWW2FsySni3L56QVf4jhAzggTZZrmqbXi+fN8LfMfjEEIYj7Zsl/K2a1AYi+vCEnfvnkQyvs7fDvmX0ezhg30yHNVHGD55Fxf17oftziSeDssj65nF/u6pGYXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEGRM+qwXVifhXpjW0be+IFBhs8KXEdjTWtt5HETdv8=;
 b=xd3Pf/PkKfa+t9IQJ4v/PNhH9LmuRdNpT3hxG5uiZKVVPGkJS6AWZhrJuVUCcYWAzxSsppQQnCfpYFbOnbWpfl2pBq+vYxlgFiNTeCGHfW0UK96R8U8zMiJQgBSJ7k2TH1c+WwZrQ36IWs1CN1akZXY/wRPGZWF4Jos2ffOmhgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 12:51:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 12:51:22 +0000
Message-ID: <e27d1105-9ff7-4bbf-96a5-293c4021a844@amd.com>
Date: Wed, 21 May 2025 14:51:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] drm/amdgpu: make devcoredump reading fast
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a264cb8-62e5-4fb1-3682-08dd9866303a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU9Db1pWMVA0N0JUallxQWpXV1NRVWx1c09CTFJQTkU2MWFwTXpGV1dxWWtX?=
 =?utf-8?B?SGFtZ29IbHBnR0s1MVZyaENVWEI2dTV4RTQxTEN1TUh2UE5pUFdBT2Jnbjdy?=
 =?utf-8?B?T0FCbUZUcmRYQWs4dWRtbExzYlozZEJuYXBVczgvWjVqbjhlMDRrNjU4OEZF?=
 =?utf-8?B?OTFaVXJLWFQ1TVExT1dkcHhGbkp4OG0xVnNjTFZVQ0I5OG5ScFF2WmlyS3RJ?=
 =?utf-8?B?VDJjbTZQcm5tcUl6K2M4RytiQkwvUWV2WkpDYkhBRm5IRjJlMWVaZnUxdlhJ?=
 =?utf-8?B?ZEhyS094ZUlBY2hVV01hWDFqbE1nRGhxQ0p5WHBVdjdxc3l1ZzBaMGZoem54?=
 =?utf-8?B?R3htVEE0ZTFUcjgvMitidVRiYVR0ZGdxSERTRHhOOFMwNmxqaXZQRWR1RWtO?=
 =?utf-8?B?bTlwSDlMblMzdTVWRHMvdHNPTGN3MUtCVkVzNzRCSFM5UVBza1ArNWlSOUdm?=
 =?utf-8?B?bjVhVTlvS24vdlF3OFZSaWtWWlVJbnZvZmhRZzdaa052dzY3YldDL0VJZDBL?=
 =?utf-8?B?dnN6U0dKMDI4MzdYVTI5N0EzOTJqK2V4RWphakxpMjY2eTlCWWRZd0dYVy84?=
 =?utf-8?B?SmVOdSthWEpOZzdOMDk4YUc2bU5HQVVndU1sNERGRlRNOVIyeWVwQzh2NEdu?=
 =?utf-8?B?bXFPMTVIdFBJMTZXMWNmMngzNXJWUWs2VG5NRi9lWVRUOGt4cC85Q0JOdkdw?=
 =?utf-8?B?aDkrcGNYNG1XQ1ZNaWsrMHY1a2Q4cW5mbWRGMTBZRHVvc2puTjlBT2V6MUQr?=
 =?utf-8?B?WU5DeDJ3TjZoS1NjQ3E5RFozejB3R2luT2ovSGVqYzZuZnpwSzhGN1JIeEFi?=
 =?utf-8?B?T0RZREtlZUE3aHRsRVpzWjBlM0Z6TWNLZTF4MXN5ZS9GSmR4S0lRUVpaQ0t5?=
 =?utf-8?B?SjdOZU01VXY0YlV5Y21Hcnlja2luaFdHaEZySnZoS0R2RTFjVUZYaGQvMHZK?=
 =?utf-8?B?dGEvNmtBR0pYc2xNcGV3T1JtZkd4U1lrQXc5NHRvOUZmMzVtQlFZK0NqRmRh?=
 =?utf-8?B?SU4zZk05MTgrUWVaZE1pOVVYV2I5WGVWQ3EycmVOeVJwYTNqWnRvOVpPeDQ0?=
 =?utf-8?B?Z0FXdnFZWEMwNUQxamw4aGhjYzNsL3Y3V29rMlVRSVhudzVVZzYrZnRWdzZD?=
 =?utf-8?B?MFBaRnA3MkdmcDhkbmNpT0V0NXUzL0hjL01iNkV0ekZsYkZESG9ETkNhcWw0?=
 =?utf-8?B?VHRrbTk3NmRiNFFINTZ5Q3hnbUlndjNrNGorWjJQVnBQVlJQVlk1L0pOWXFC?=
 =?utf-8?B?cUo1MzU1SU9pVjdNd0QrQnEzR0pyUUJnVUtPSE9ZWTc1cmZrQmpjOXhlN2VR?=
 =?utf-8?B?Y2QxMEQwbUoyNzB2cS9VTkJXS1ByV1FJbGMwVnBPYzVrc2JXU2dBeXc0eVc2?=
 =?utf-8?B?ZjEySXhqQlVNUktaRlYxdTh0UHVnUFVZQjRYWi9RUUM0d0xWYzZYWXNwbXR1?=
 =?utf-8?B?VlphdGFXaE55YjdxVkMxbkVkbC9tZHl1bURPbTZEK1BhUGNaRDhWR1FmT2R5?=
 =?utf-8?B?L0tsejJWYVBaVkM3QVBJMWJmMThNZmw0akRvanVyQlZMcG9jYW5TZzlucU5U?=
 =?utf-8?B?R2IyREtLbkYzMUpxQ21FKzRVRTN6SUxJQUl6a0R5cW8zUmRUZmZFMU82bVBL?=
 =?utf-8?B?Rm1oUjEvY0RkbXcrUy95anJKMDgwanRNREhRZzRWN2hKZVVLSk0xTHdCcEsv?=
 =?utf-8?B?RGI3SDZoV0VPVXRSZVU3cWF4cGpJWmhJWDBWZ1U5by93QXRGdm81bVZuZlg5?=
 =?utf-8?B?c0YzNjZnNDFEUnkwTlZKVncwcmJ4MDdYbElEU3V6WmtxOTBNT0RrK1pIVVVK?=
 =?utf-8?B?S0k4eGFyV3VHeC9ncHh3U2Ftdi8rYm5aVnVqT2NnaUFGcEwxdkoyb1VyNUFl?=
 =?utf-8?B?VGYwQnlXMkttK0ptc0lJSUNHRVRXUG1kaXRkUTRmZU9JYmo4RlhwVXk5Nzl5?=
 =?utf-8?Q?lU7AY3Hrdi8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2hZZzRpYS9DMzBUcWNzMXpsQUJJOUVhR1hlc0VyVWpndUJoMVA0RkhleDZV?=
 =?utf-8?B?cmtKUHZsZUxoV0tVcWphRDdKc3N2Qkh0YkNPcHF5UmZZWFo5YzRET0p4NVFR?=
 =?utf-8?B?RmNMZDlrTXlxN3NqVTA1ODhqT3JMUmlMaGxQYUs4c3UweDhEWnRZeGlBY0xz?=
 =?utf-8?B?OUtOUW8xS1YweWs4c21ON1M4KzZad0pwc1NzRkpodWFGNlk1NmpIbnVCTlFU?=
 =?utf-8?B?cXh0MkdFSEpXZVlpZGtLOTR6SDdOR3NHWlBFbjB2R3RXUVovRDVwSkFONFZj?=
 =?utf-8?B?WFBybkdneml2VDA1ZUtCZzZ1OFFEZFFqaWtpdHlMT0xWSGR5bWdNTkNpZUlL?=
 =?utf-8?B?Vjl3ZWludnMrNnJPWXEzSzcwM1lqMzVTNW56bVJUZDdDZFEyZHQyNXY3RmJQ?=
 =?utf-8?B?Tjc3QlRSM1dZcHpIWFk2U3pxV1p1L1ZIc0UwbTVIMUFsVEtDZHJJR3BVVnMw?=
 =?utf-8?B?U09JNElIWkl2SHlqOENGZzZBWTF0OGg2VHdidkJ3elFUaHl4cXRPbG8wRTRL?=
 =?utf-8?B?bkVFOE50MVN4Q25RTWozd0UvczRkZ2M0dWJwb0lsT2RGb2lIRUxFL0pDdVBa?=
 =?utf-8?B?MVFWTXMwKzM1OXIxaldERUtFWG1QeklUWjhWNnJuMVJ0eWpSU1VrQVlXSmtZ?=
 =?utf-8?B?dDVsV05lQ0N1cjd3SHROc0NZYVNlMW1BVXhWM0Vpa0NZSExidmpsZkNVV0Vl?=
 =?utf-8?B?TFozZ1RVczFzUnpES3dZYzMybW53WDl2eHJNak5Xd2dGSVVoN0Nydk5yd2M5?=
 =?utf-8?B?aGx1cGxtTVJXWUpoYlZNUnlVL1VFektZVFlrTXpNckNvVk1VRVVNK3VOaWNS?=
 =?utf-8?B?b0VTcm40SExNNDBncnJ3YldrT1RqeXExbjhXTnlMMTdOTFBLSDNLRFJVZ2VU?=
 =?utf-8?B?UXdTcUJYWHU4V1ZMRDl3NWdQSnFFVzRGdnVWajFYRnphTER3d0NvdkNDKzNK?=
 =?utf-8?B?Z2NXSFBzbDRuQ3lFOVZqNVR2YWVKTVJ2ZG1TQTN6UnM4WG9XRVBTdkhSbWVT?=
 =?utf-8?B?emUySUNZU2JiRDhGZEdMV1N3RmNwUmY1RERwUjJjSFVKTzBYTUpEbWVkVGV5?=
 =?utf-8?B?T0p5TjBXNGduK1ZHSGwwUXc3VFY0NEVKYi9rVkVNaWxtYkUzcHZNN05OdHpI?=
 =?utf-8?B?eWcxWDNsRERIMVVYUTFMK255cnU1bzdiVFZ4a3VqelJHV0s3TUFOK3lYRnhp?=
 =?utf-8?B?N2R5MjgvSG5ML0RQU1dtemZ3M3BQY0RDc2NtY3VEeXV4YUZ3Z1dnUEJGaUxU?=
 =?utf-8?B?R3V6c3VsMzhrVXFmLzZzSm84MDhGazNZVEpzclcwWTlLTmUvWGhja0dDR216?=
 =?utf-8?B?NGZNQlJBS3JuWjdmYmgwbFR6OEU2bldYSG9QZ0VRVXYzUWVMdUNMcEZtM2F5?=
 =?utf-8?B?SG51Zk9jLytwQTNCalZlMDRSMCs0M2UzMU9yWG1MdkNJTGs1K1ptRmJtaDVz?=
 =?utf-8?B?NlA5d0ZocEtwaEcrNGpOYXc0ck5zdUUwTTFwRzJxSENrQmZTWFlLZmhJRWlN?=
 =?utf-8?B?cmE1ZFFqNEhvM05sWDZhUHV5ZmozbndvR1dlQ2tzYi8vNDk2UmxhcG9yb3U0?=
 =?utf-8?B?U1FLWTdMRU5lWTdYRkFITlpkaXlTdklYQ3JVcHFRNGREcEVrSGFjdzZDMHBh?=
 =?utf-8?B?R1BBUEE4TWlmSEFrTm9GL0w1b3BLZ3BESzhGbUhRVnR3a2lISEhNY0RpcE9D?=
 =?utf-8?B?ck94ZTNObGlUVkRJK2ovTUJ6UlIyT1VKYUJaeVBaTnVwSlFBQi9ObWhUNzNi?=
 =?utf-8?B?Q2o1ZXNXTkZWNWNaVnErSnNZd3RGdGdMVHlHQVhQZ0ptdkczVFNWL2V0a0xj?=
 =?utf-8?B?aHBPZTM0ZklMWHp0QmxHTk9qcEtyaThNMEdHVWtTdWNrclpsbjRBNzIwTm5D?=
 =?utf-8?B?cklKc3FWdDludERYd00yM1lzUysxeUk2UTV0azVzclhKaGYvb0tvWGpLU3Nu?=
 =?utf-8?B?S0l2L0dyb1pheWRrK0M1VWkvRW9QczlCcjRxblFIeElqb1NtUE8yOFI1azRN?=
 =?utf-8?B?Ym0va0RlUi9zODVYcFVQVTQ3UE1tNVhGOFo1c0hXSHFvMmVWbU5OOUNpOTBq?=
 =?utf-8?B?bXhMeDh6cGhTR0dOK09ZdnBRNzRhVm9BMmVsazVTOWdSSTNZWXRNOEgzendi?=
 =?utf-8?Q?OoomRwSqtHuvBuduqYx8EgLrJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a264cb8-62e5-4fb1-3682-08dd9866303a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:51:22.3199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvaH/hxzLeQsn0f6bYXTjuQEbC25s1ZByAalmYCoBDs+AcW+jeYl1QbjAY1uyBvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
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

On 5/21/25 11:49, Pierre-Eric Pelloux-Prayer wrote:
> Update the way drm_coredump_printer is used based on its documentation
> and Xe's code: the main idea is to generate the final version in one go
> and then use memcpy to return the chunks requested by the caller of
> amdgpu_devcoredump_read.
> 
> This cuts the time to copy the dump from 40s to ~0s on my machine.

Well that indeed strongly sounds like something is going wrong, but I'm pretty sure that copying things into a temporary buffer is not the right solution.

My educated guess is that userspace reads the core dump in chunks of pages (or similar). So we end up generating the same dump over and over again and then returning only like 4k of it at a time.

How do you copy the core dump on your box?

Regards,
Christian.

> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 43 +++++++++++++++++--
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  7 +++
>  2 files changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 7b50741dc097..de70747a099d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -34,6 +34,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  }
>  #else
>  
> +#define AMDGPU_CORE_DUMP_SIZE_MAX (256 * 1024 * 1024)
> +
>  const char *hw_ip_names[MAX_HWIP] = {
>  	[GC_HWIP]		= "GC",
>  	[HDP_HWIP]		= "HDP",
> @@ -196,11 +198,9 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>  }
>  
>  static ssize_t
> -amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
> -			void *data, size_t datalen)
> +__amdgpu_devcoredump_read(char *buffer, size_t count, struct amdgpu_coredump_info *coredump)
>  {
>  	struct drm_printer p;
> -	struct amdgpu_coredump_info *coredump = data;
>  	struct drm_print_iterator iter;
>  	struct amdgpu_vm_fault_info *fault_info;
>  	struct amdgpu_ip_block *ip_block;
> @@ -208,7 +208,6 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>  
>  	iter.data = buffer;
>  	iter.offset = 0;
> -	iter.start = offset;
>  	iter.remain = count;
>  
>  	p = drm_coredump_printer(&iter);
> @@ -321,8 +320,44 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>  	return count - iter.remain;
>  }
>  
> +static ssize_t
> +amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
> +			void *data, size_t datalen)
> +{
> +	struct amdgpu_coredump_info *coredump = data;
> +	ssize_t byte_copied;
> +
> +	if (!coredump)
> +		return -ENODEV;
> +
> +	if (!coredump->read.buffer) {
> +		/* Do a one-time preparation of the coredump output because
> +		 * repeatingly calling drm_coredump_printer is very slow.
> +		 */
> +		coredump->read.size =
> +			__amdgpu_devcoredump_read(NULL, AMDGPU_CORE_DUMP_SIZE_MAX, coredump);
> +		coredump->read.buffer = kvmalloc(coredump->read.size, GFP_USER);
> +		if (!coredump->read.buffer)
> +			return -ENODEV;
> +
> +		__amdgpu_devcoredump_read(coredump->read.buffer, coredump->read.size, coredump);
> +	}
> +
> +	if (offset >= coredump->read.size)
> +		return 0;
> +
> +	byte_copied = count < coredump->read.size - offset ? count :
> +		coredump->read.size - offset;
> +	memcpy(buffer, coredump->read.buffer + offset, byte_copied);
> +
> +	return byte_copied;
> +}
> +
>  static void amdgpu_devcoredump_free(void *data)
>  {
> +	struct amdgpu_coredump_info *coredump = data;
> +
> +	kvfree(coredump->read.buffer);
>  	kfree(data);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index ef9772c6bcc9..33f2f6fdfcf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -38,6 +38,13 @@ struct amdgpu_coredump_info {
>  	bool                            skip_vram_check;
>  	bool                            reset_vram_lost;
>  	struct amdgpu_ring              *ring;
> +	/* Readable form of coredevdump, generate once to speed up
> +	 * reading it (see drm_coredump_printer's documentation).
> +	 */
> +	struct {
> +		ssize_t size;
> +		char *buffer;
> +	} read;
>  };
>  #endif
>  

