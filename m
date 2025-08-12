Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F6DCA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 05:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ED310E588;
	Tue, 12 Aug 2025 05:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WPTHlDzy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9413310E588
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 05:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7gDMq1B0Mi83FvKGBEDfz0q+knMayP84XKMpMlqMusBCqWdaXo6p7t59rE6PdZ4LgqvIOStYVwHiBuJaguHW/e6qU6lv6iSCLLHB5Y4P09pcaF0CTSo4+ByHqm5OF4QHxDiaK8TvBHC2u02Q3378Jx+bu9TYWzud5d2/8S4kPu/Q9Guqv9t2RcDborrz8dwucWLFA48Xz5ulfyaG1fl1kZCZ7L0oTw2rF3d2RZ6AonzXUOh0Cdl4iBbY48+3WzV2xjvALC4Uo5flOQhf/vtX4wkHkt0Uyj62OlLYNMLAXDqlTGjJ3yg6OBWXMl/Bg1GUdjNmtig33L5xGGMRnJEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD8P9OLWULPVjcjeGhfcyzNLHYeVmkeeH51yghmNPg4=;
 b=CAVZMEU/Ud2oGtWzYC062tQqJoPRTbwzGxP8D537QQ7c+SXqMlE1J6fG7FkwlKciMZ31OiuZqWb4HE8+2+Mx+nbrnAbclJYwlwaM3o8vT70TGoxrVAqu7pTbhZn3e9F4hBQUTUU0NsVrWsF4IDW3kdAY+7ydBSsV7FwaVthsgPvbrbK+menbM1PPsdE5CAQpuiWrYcwYBMUPlgGXacfjDyiMj7TexXqaDkyPiIv6oBOUqteEMxyljcRY6bZski/i+bWqGAlohJmt9JQW4JldKXYkjOjYonKSpQkhBVEurD33UAFEkNNZ6ltVOASdz7bAFj6EEpbxCF2thU854e2hBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD8P9OLWULPVjcjeGhfcyzNLHYeVmkeeH51yghmNPg4=;
 b=WPTHlDzyw2aq5YWns9eQupZdare/xPD+2+s/Vp1bdba8TvFmdqV7ip0Gg1SX2xHOfGqgnDU+I3N6qMjv+5UXGPR9XhTaF9UhJf+aD5pHfUcthW4XmbjqyXM5l9NGuCnUZDjWekWQz0FZLcjDmZI6eXqtCAgYS/8hugNt93a/Vxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.20; Tue, 12 Aug 2025 05:51:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 05:51:39 +0000
Message-ID: <552a6e27-5313-4f88-8976-2bbf5ee0accf@amd.com>
Date: Tue, 12 Aug 2025 11:21:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: set uuid for each partition in topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250808150056.45206-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250808150056.45206-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e27e54-69e1-4dc6-762d-08ddd9644e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUErZWRtMGJkbVlkTXJ4VjZQT2RZWUhPL0FFK3FmL2dWSHVDbngzeUpnUHgw?=
 =?utf-8?B?MnlkRlF0VFlOejZQWjlSTjU2L0tnOTNiYlFEWWFnMmxUOWVoSW9vaTlrUnF6?=
 =?utf-8?B?azE3dGpzTExmL1VtMUJsaTh4SDQvU2tVdmxtQ2pkMnhaTHJadTUzNlVCQkFy?=
 =?utf-8?B?cituOWpxWkI4bEhxNk5POWVINlJ4bmtBM2xLQ2NIWlpKSERuM2dZNjNKQ3NZ?=
 =?utf-8?B?eC9jSUlXYkJZaUdGSGNBS3hpTFl2a2Jkd1BtWThLa09kb1l0OEh2K3Z2SkJR?=
 =?utf-8?B?a29id2NJWGZQdFNrVittQ2I4Y0RZSUN3VzBoTStWWTJZOGU5UWtrK25OajZm?=
 =?utf-8?B?VHc2UlVjU1dYTmo2RTRadi9tOVZrcFJQZzVsTWllWDBncFhsdS9vODY1U3B2?=
 =?utf-8?B?NWVqbExRYTVwczJwWG80OCs2OGdleGlCZU1od3ZCZEpEMkRTc0l6emZ3Y1E3?=
 =?utf-8?B?SXlneFQ2RnJhd2NaRzFXK2VsNHJlZFFEcDU0M21nd2kzTkdpYkpKM1hmWEJt?=
 =?utf-8?B?WG9iamRjdE1OVW1kWHIyNm5ISXduUkZoVW0zYzNqdy9kMUo2STJlOUpYZ2xT?=
 =?utf-8?B?N1pQZmN3VXVFTzhKb0ZBajhSMk9qTFF6cXF3MEg1TnhwNUVsVlN4bmVqcXZS?=
 =?utf-8?B?ZEZ3QU53QnhKR1o2ZW8rY3d0S1o1SG5KMFBIbE9EVlpTMDhBd0JENDRjaVI2?=
 =?utf-8?B?THpxNS9aaFgveHd4bkI5UlJyVVhuNmpITVdMcFRqempUOWRwK0M2VS84T2l1?=
 =?utf-8?B?T0Q0TkNUQ1RpZi9hbDVmOURpdE5abUc2bFNJUHE3MTUzOTRhRU5QaUNxNWtP?=
 =?utf-8?B?NzlvNUl6N3NUVTVycVZETzU1YnZ2SzUzVnpTTU5pbGQvRkpISWFNQkZVWkY5?=
 =?utf-8?B?QlcyM2NvU3J5Ni80bjYxRVR0d205UlZJaTlZbm5JYXBKOFJpMEJpcE1RQkpy?=
 =?utf-8?B?c0JNWEg3RDBYRWk0eDJCL0E5V28vMjJXTXM1cEFXRU04TVhralRZUWp1UUtE?=
 =?utf-8?B?bXhSaitTZWtKSzQvM1l0SjNyZk05SEhaT25iaVNKNXU4MWpEMjJWRVNlNGRS?=
 =?utf-8?B?dmVOOGtwMGxNZWFBZllxRkFFaHlGS1JMYTlOcldrZ2RqeEh3amdPUGdIUmRN?=
 =?utf-8?B?bGR2UFV6c1hRdGhUWmxEdEY2Zk5VRkpFeDcrNndIcTI2RDNCcHpFekgyU2p1?=
 =?utf-8?B?QzRhMEZJV2hIbk1hTXZMUzFId2FIZk5MMWp1bDRUVE5meG8rblk2VU5EdFBw?=
 =?utf-8?B?RzlLQnQ3T21kUjJ4cjBUMGs3Q0tzWTFPUm9jU2dwK0R0eFdNUUFtMkZVbldW?=
 =?utf-8?B?S1JIN2wvWFNVbndZU2tRZXA0eitlWHZtcU9zRllVbWVsUUNUZ05jSm9aK1NQ?=
 =?utf-8?B?Z2RWc0IrYTJpOXl0aTVUQTM5YnhONVhUQUJlTThHMkZDaFlodUVIWklkTHFL?=
 =?utf-8?B?VklJK0VueFBZWUtYblZDWkxoK1EvNzdZMDgyazZpRnkyYXRFUE5waEx5c0dx?=
 =?utf-8?B?SGRzdExJYXpTWkZzdEQvajJmN0pNMHhMck5RQjhqejN5REdWVUUxOThUK3N3?=
 =?utf-8?B?WGNaNkFPcFZyREJ6ckZhODZHcmJZYUxSa1NSZFdIQis0SWl5MTFEbHRzNUFJ?=
 =?utf-8?B?eDZyVnQwQ1ZXZGFjTkt2UDAxeTdSWFZQbnp3TEhMK2dkbFNmbDFWVkRNMXJa?=
 =?utf-8?B?TldPT2w0L05oZE1McGxJU2p2b21SRUZOSG1idGFWM2ExOHdodVR0WTdsaTVB?=
 =?utf-8?B?amJna2FsOVVqZC9WbE1UWlBheThlcXR3ZHJWZXRoS3ZxdHp6NUxQWksyNVhR?=
 =?utf-8?B?OTFGQ1VITXQzS0NSZ1F0M01VRld3UERWYWRiVFZuRE50RU5sYWRMbnVjM1lm?=
 =?utf-8?B?VThCN0F1VHl3VUpRUUg4TnRtZFlnUWNYaDhrTHlKaURGdkdmbGdDZ2w3d2tP?=
 =?utf-8?Q?tPixPpFB6Ns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clhjbGFDcWZFdUdhNHpzUnpXY05VYkJ1U3VtZDRDOUxaTEU2Y2c4ZGtzTVZL?=
 =?utf-8?B?RXg4Mi9SdkZETDVUOXhpQ3BWem1TN1pubFNJcWNaS2l3SmwxVnltSERsRm5T?=
 =?utf-8?B?RVR5VC80WU16dHk5aUR1RWhiQjlxRHJaMDVjNExLMmVrL2hOOFhZL1VMdTZy?=
 =?utf-8?B?VmNBL3p1T1ZTWE94SXpLNlR3UmpONVYwME9CczU3ejJOeE0rcDFxZjZka3N5?=
 =?utf-8?B?MkFWV0dIdXk4MGVSYnU5bWZETHFXV05WS2dHMXljTHBDeFR4a0JMa0lOQjd6?=
 =?utf-8?B?VXRUM0lJTFFZTzAwSVhsY3JrcHVzK2k5Yzk1b1RWZFZEdmxtOWhZdm9NUFlh?=
 =?utf-8?B?V1gwNFhhZGNXNkhKaDg2SDBUbUhZTHpicFAyYXEyK1RwNWRtV3JPRG9JZXNX?=
 =?utf-8?B?ZE9KZHN4V1RDMFdHbnV4cFMveFRNaG9YNGdwVzA0RnIzOUJ2S0dhb1YxRVgz?=
 =?utf-8?B?SnBKWUxBRWk5VUc1Tk1BdXd2S3g3UVFlMjdScEJiU2tBY1p3NGF5cVFIQ1Bq?=
 =?utf-8?B?aytrQzZFcXBhUDNEZ2lONlNYUDF2QVdQS0hXeml5QjgvR0ViamcwQU8vT3Zy?=
 =?utf-8?B?WCszd0Y3Q2l3ZGZ3ZmlQRlh3TXlmdUdZMU5RbHFabEtEYTArdnVuTmJLSGd2?=
 =?utf-8?B?WVFlRm10aTdndGhSTmJ2ZFR0OW1JbXJCekZXT0ZlQXByREpzN1VkdVRpdjlT?=
 =?utf-8?B?N2ZjN1IxcVg2T2JGQUZPTUtqb0Z6Z2hEY0ZzalFkVTNNZjUzc3Q1K2cxVHRI?=
 =?utf-8?B?VkhDNEZwRzg2dTNuV25zbmVUaE9EZm8wWkw0U1NNT1RpZmtYNno1a01YcmZm?=
 =?utf-8?B?c3p5Z1NvQ2pVTVZobENXdnROUHRrQ1RmSzhoamUyY0xtTytoRnp0SGpQSUFw?=
 =?utf-8?B?b3JFWnFNckwvSjl4NlgydU9RcUphTE9hejR4T0oyYW0yQ3d5cTFmclVjeVBh?=
 =?utf-8?B?SWdsdGhsUE1rK2ppcWJFallUSjZRSEFFWkpXVXYyOXRjQ0I3c2ZBZkFOQzk1?=
 =?utf-8?B?eC9xN0ZWSlM0MlAzSEVRdmE5V1dLTnBtN1BSY1UzZkoveE1WWXA4amlDU0xI?=
 =?utf-8?B?MG1BdTd5YXJlMDluNmE0Lzk3K1J5ZHFHTlRmM1FFb3MwZEl1eEtYUzd5NTdF?=
 =?utf-8?B?c0NuMU95bXJyazB4dkpuMzI2WkxvZExGT1VGWllqeGxDZzdIUnJZeGk2R1B3?=
 =?utf-8?B?emtGYTgwUEhUR1dmeGhCMEdINkZOdERjU0hzSE1FeEdSWDJOZ1kweFB6VTZD?=
 =?utf-8?B?NFpTU3RWL0o2bVNLYlg4VTJlMXltQUNubnFXZXlMYWN6bllnZTF0QmF6ei9m?=
 =?utf-8?B?ZEcvZlNkd1lPck05VWNDbUNJMU9lb0p6UUpya2xCWUN1bmV5QXl0ZFNhcUdZ?=
 =?utf-8?B?Rk9yaUxiakVqYUFNT0R2elBxNEdZeXEya01VU20wOXRBLytTYytsajlIdy8z?=
 =?utf-8?B?VDJLOUNpQ2ozZmJYTFUrVkhaS3k5ZHVtbFRBOU9Ya1ZUekRqMHJjcS9XMkFy?=
 =?utf-8?B?cm5NbXg1bTJTYWdrdExjWTBSRUIwWUh3Vzc3WnZEaWlJT3A4eXdJS3NsWGtS?=
 =?utf-8?B?dXpVL3NDNGx4YzdoOHNzeGxoVkQrYVRLdXdQOTdaeG1HakxVT3RPODJWaU5k?=
 =?utf-8?B?VFdHK2hMWVB6dXFZeW83b3VpTXdKWk1TNWdlcWNudW9Yd2NVK2VLRkpNKzNY?=
 =?utf-8?B?Nk5VZUFWNmV6dFVJbXUrNkgxalBPWVN1RUhQbDIwdDc5YS9YcnZSNkR5SG5n?=
 =?utf-8?B?cE9WUUJhWUpubkxyaENGNy83LzBzcmpsRjB2cmJTM01rOTJpRW9WWHpVUkEy?=
 =?utf-8?B?YmZrdWRkZ0dBZm5WeTFuQjJPWDNLM292aVdPY1lLM1VMak1ZUmU3K1RpRGRw?=
 =?utf-8?B?QWJUV2ZKNDZXVHZhbllveU50dVVJTFNGYUcxSG9UUGJ6MHBsY0thUUpZZEg1?=
 =?utf-8?B?TU1nTURiMjRqb1lkTmJBMWRmNjRsTENEN0ZMTEREdFZEZUhUZk51SzVvQ09F?=
 =?utf-8?B?OERYTVNTSjRIU0tIakl0NDFVMi9TVjRBUUUyYzNIQWpiQ3Qrb1JUY3VBWUhh?=
 =?utf-8?B?WkE1TjdPKzh0WkMxUk02ajhmNEFmQzhLcUJnSWc3TW1Ea1JFVHVkRmxlVDlJ?=
 =?utf-8?Q?RM8hjygbWVXshdW/SXHjJY/ss?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e27e54-69e1-4dc6-762d-08ddd9644e3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 05:51:39.3889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iu+tb5MvBHI7SjvC/xZ7Q1Fyaao0cNu9dgGRQ1sUjAavO2uLbI5ECc4FsnW2v+HJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
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



On 8/8/2025 8:30 PM, Eric Huang wrote:
> Currently each kfd compute partition/node is sharing
> the same uuid of AID, which doen't meet the CUDA spec
> for visible device, so corresponding XCD id for each
> partition in smu has been assigned to xcp, and exposed
> to kfd topology.
> 
> v2: add NULL check (Lijo)
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 4ec73f33535e..82dbd68d8c99 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -530,6 +530,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
>  				      dev->gpu->kfd->sdma_fw_version);
>  		sysfs_show_64bit_prop(buffer, offs, "unique_id",
> +				      dev->gpu->xcp ?
> +				      dev->gpu->xcp->unique_id :
>  				      dev->gpu->adev->unique_id);
>  		sysfs_show_32bit_prop(buffer, offs, "num_xcc",
>  				      NUM_XCC(dev->gpu->xcc_mask));

