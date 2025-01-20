Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867DEC02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 13:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1659D10E414;
	Mon, 20 Jan 2025 13:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zq5I7sUy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038B110E412
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 13:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV7pknu60z8rhCwdrUO9jUTa6Qs40RuL8zoT+/Mza3mtw2P0wnPfqMF3bgerfaG6EQynIYk7QsDRKRdeFKPwt76YFnzkXj5vTUrA2mrmad+FZDeiZk0LoSp94aHVw+80RoEzTYzqOjLt9moIa/DR/gmm9AYH4yQJVeYzJx49CBGEj+yvhJKu9acw6X053eHlX0taaOoA1thKuG53tvavRiw/JQk+BZ+iOSgaZ/z2Ixh0BNLXH0yKGfT4cfMlOqYgyZOhpET2SvKW2kAngymOgMJQUwqYvxmLG4SOqUJ4EEWXMkgabINNfJZFpJxPgquHprXgV7tZgkYu3+IjoHHsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xEfkKFwGvsqyfsqvGviUX+v3FuUcs8sTnVbQP7mDA0=;
 b=yW6t7Rl5NHmnnVcoly5UM3lxaY/NkDjgLQ/CxZ8e7+0+op7hG6ZtRwm9LyEenPRQ7FZHKjsWUUhQ/WSJ9mxX7Amyj3csljshvt2WwnKlST2ED+x4hWxNkjIrT/pubsreCUPEKHb9iFu5xDDzjVlRopYOHLrKno8BeNLyPrHDW+o87+EMghLPjuyQfokpSZeoRNffH2OkSQYuPlXxGTeXwBbA+lsP2nwP/Ms7PHbTm4OqqSVyMxOHv6wEfSl/Fl+YWront2vROjrBTaVYRkF1wAJysFUY/Cb7ETLNeIJ5bvYqXUHmgJaScd389LUWAY16/LZ79IuaCWL5mCGg4y1r0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xEfkKFwGvsqyfsqvGviUX+v3FuUcs8sTnVbQP7mDA0=;
 b=Zq5I7sUy6R+U1rB0td33UWILeiYQKhcANNfqs9wjY1iIFPQoRgZtHlzY2cgVbz3l4bY6jaIz2XmJ2UW/Da49xEy8pczEp+qvFuk6xLE6oJ1gwew7RuG3/7xPW8Khv2wEujywoMkHS6iOp+3xC30tkv5gp96iwXWhY9rDMC9Qigs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 13:33:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 13:33:19 +0000
Message-ID: <b2c88ebe-d52e-4482-9597-e61846adde91@amd.com>
Date: Mon, 20 Jan 2025 14:33:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/amdgpu: Prevent null pointer dereference in
 GPU bandwidth calculation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20250120133147.233770-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250120133147.233770-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7da28f-face-427e-66b5-08dd39570097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFcwalNPcEFJN2FaaXBhRmw3dzdERWkyMktST3hFUVFMSFZkU1JjQ2sraHNV?=
 =?utf-8?B?enVjbWNvQWROTzZVL0FXTUc2Wk5DaG50bzc2MldGcG0ycWVtemN0a0hON3lP?=
 =?utf-8?B?Tm9GQnAzM2VBZnh2TWE2QjJGWmNXcjhKUHZVVVp4SG90MEVWTDBCM3c4ZVNN?=
 =?utf-8?B?MG9hYk1XT1grMEYzTDJlRU03Y1BNL01uU2RJNFVzSkxZc0ZOa29vZCtlQjdp?=
 =?utf-8?B?NXRLWVNaZDByNHNYVXB1cDc0T1R3dVYzNHFHa2c1WEI2ZkJCdGtyNFhtUE9F?=
 =?utf-8?B?MnVFZ1JEdWpBUGtiVWV4SHhrREgrUXgrSWgrS0lKVlhNSFhPL0FnNkdKQUFY?=
 =?utf-8?B?ekdZL1IwdkJ0Mm5lVC9IVUx6MWZXQ0xoQjR0eVE3eStwMllnQkFub1BtTWlY?=
 =?utf-8?B?T0krcFgrN001b3RaVzZ1THpqakdaOVFtK2hqUGpjdUZ4dmJPdEZ1a2N1WlRL?=
 =?utf-8?B?S3U5Q3FoOVFvQ0IyWjJrdURiYkZtTU54ZXhnc0JjcFhraHExVytzWFN0NlAy?=
 =?utf-8?B?cCs5ZHVyTy9jS1hsU1psUGl4ajlzYWhpTHUxQjM2ZlZqTHVrb0c2UENMbVVN?=
 =?utf-8?B?clZDelh6enptR2I2VzBuSTgzWlpBRkVnUk4vRTlCdTFoWjdnbVpPellBdjk4?=
 =?utf-8?B?TzJzbzJqU3lHOXBDS1djQWRlWVdTdXFNNGpCaGpCY0NFcjgvamFzSUxleXhJ?=
 =?utf-8?B?THJjQWRSNGx2bTRjZzUxWkU4VGJJWmhoRTJGNUJkNGtuSmhONWdyNSsvOXQr?=
 =?utf-8?B?MFdKdmtNU3lKTkYzSE9CeXYxZjJOQTgzS3lpblBnY1Vra2FZZmcrdmxMQ2Ry?=
 =?utf-8?B?SE9abUJqUFJvRENENDZHN3NtWk1mK0VNNnI4YmM1TEdzWjh4OHJZVzU2bTlw?=
 =?utf-8?B?OFlEaUZzQ2dwbm9Qck1BU0hLQ093aU15RUI2OS9FL05LdHRFWVExcDRXL2Nw?=
 =?utf-8?B?bW52UHBldjlnL3NDTk1ZUjQ1ODRLbGJBZHNkQnV3VWZIbGV3Z0R5cUtxMDV1?=
 =?utf-8?B?Ni9zS3JhVXQ1RzNUTTc5SllZMU5rTFhVamVPQ3VyRVdzbS9pZENBQjZsMXpR?=
 =?utf-8?B?a2JCZFBiVzgxV3BhYjBvQUt6cG9IcmtJOFVEakpXNjV4Mnc2T0ZkT1hQaVov?=
 =?utf-8?B?d1pQTTVSRWFXSll4S0lRRHVvdkVLclpjTU0zd2w5bld2TDllY2xzbVZocHd0?=
 =?utf-8?B?bHNHR3FENUpmbWpxbmZWOUxzTTY2cUN6cHJTWk4yeGFsUk90RGZtNXNCUzds?=
 =?utf-8?B?R3ZGZHN1aURSRjNWSnBPbGlyWEZmd2ZEbnZoMVUvakJuK0JYMVdLWXVOSDZh?=
 =?utf-8?B?SE03Um9IN1d3SW1yZHJMQkJZNUdFODlKWDY2N3dtYzRzT1Qza1Q0K3R4YWJS?=
 =?utf-8?B?dkxvK3gvZUttRlRWL0NZOE9yYi84YjZiV010OHdQQVhZSEdqbk9aN2R0YW5P?=
 =?utf-8?B?aUI4Vy9kTnlhZFBiaXVES09ZVjRnaXhNMEUzS0lqdExwMTJDbDFDL3lEOWVq?=
 =?utf-8?B?a2ZKWlNzMTM5UjUwYVJHdHlwNVVQSHROWjRjRU1VQnllWmFFR0drOGhpa0x2?=
 =?utf-8?B?NUNCYyt6eUNQbytJUldpRkVuVXY4S05MWU8xYncybDZ1QmlTZUQ3T1RpQ2U2?=
 =?utf-8?B?Y3ltZnFHQVVyVUpSbmh0b054UVlkMWk0d0kzSHg4bWdlV1lBcTFQc0R6SlNq?=
 =?utf-8?B?UUg5Sk9oT0JWTlNpZzJWZnZSY2FFWmhXTCtNTnBlUnJ6T1BiNklncVBnajRm?=
 =?utf-8?B?cEloVFlFeDdrcUdCcXI1R3dTQTlzeEU2Z3FNNGJka011STdpdmZIWjhOWC91?=
 =?utf-8?B?MitLNE56U1FKUWd0c2VJQ1lWZHFzeDlqUitIUGZNZmhNc05qMUhjbnMrYmhi?=
 =?utf-8?Q?RLKO1PZwMSPl7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJPanJaRktPRW8xcG8xQS9tNFBjcVRZcXczelNseEw5c001VFpZV3AzRDEr?=
 =?utf-8?B?N2F6VFRqMXhCYjVJbWFVVXBmZDIzY2lHNkhKdWhQTXJFNjBrYXdHMlgwUTJu?=
 =?utf-8?B?S2JGS21mZkFxR0xwQVhYaVUvNGZHSEpIVkU3bGgyNHpKZEUzMk4xOVB2ZTdZ?=
 =?utf-8?B?YWF0TTJha25UQ2lod2c5UkNSelF0UktGekkwWjVDQkRtdVBqMjZmZUoyS01S?=
 =?utf-8?B?c0dsOXdQWUNNbzVDME51b1dHSFJYLzNEK2pwU0pBMWRwSm5xb25hdE12UnFa?=
 =?utf-8?B?UnY0aS8xemZSZjR0ZVNzcUlISHRaemNkd2tYQTJZOVRrcTRiVDl5dzNmQ2wz?=
 =?utf-8?B?NFpIYk1mWnZ3NWxXbFRBU0FqYjZreW8xazIxcEU5RDJueENKaUJGeWF4NVdL?=
 =?utf-8?B?bXJuWm1tWWRuRzdETXZrVTRDVU9hZ09VVFFJMElTYTRtSzBGOFJ1Nko4SjZQ?=
 =?utf-8?B?eWR0SzNiZVVJRHhMeDdyQ0tmU2UvdTZabkdmWTZzU1ZBajVMWVRHSkRoWHpE?=
 =?utf-8?B?WkdrQ0dJQldhYlFBMEZqRW9iaEUrV0Z3VkNpaWQ5R2YzQW00NU9sOUVtY3VM?=
 =?utf-8?B?OEZpalVxNmdNQWMyTm5SbFRiM29tblBjaFFaeUlweDVBcTllRlNxTlRsdHFi?=
 =?utf-8?B?Mm80aDI0azlCVUQ3MHFBOXI1a1liM1I1Qnpycy9pRjN2Tm4zZjZUR0Z5djU0?=
 =?utf-8?B?bWJZZzJvVXpvcFV5ZnpGVTBCRFBkUW9SckRXSkp0dVpqZk1oWSt0bWNVVFNx?=
 =?utf-8?B?dUFiSTlPRDE1Z3hjaW55UXB4OWc0YjJrT0VkRlF3cllkWTk0cXNNck16VVJs?=
 =?utf-8?B?QVRpM0c5emhKUU5mS0JKOFB2WXJlazEwUGRmdjNHWmFyaEttVHFsbnhNMWlP?=
 =?utf-8?B?R2FsZ3BTMUVWc0ZQc2VHcVJOdXBkZWRrd1hjdUNaM00zeCtqRVZZeHV0SHo5?=
 =?utf-8?B?RVgxN1BtYlNMZHJ6dGtsL0s2MXRhT216RS9seDRYZ1RFbjI4bXdVU0s2ZE1D?=
 =?utf-8?B?aVVkK0JFWmtQWEQ1MitQSU56S3VnT1RGa01nNm9kZVRkUjJSQTZjZ1dyUUc5?=
 =?utf-8?B?WkoyY1k3Yk5VOStxcE1nUFZjZVFwdmY0a0R6N0RZY3lIQnNQL3FxUUR2VWts?=
 =?utf-8?B?djl5aHBublNXTGtVVThSRkxucSt6RFQrTUdDTktIZEdNQ2pnQ0pSbFFkaC9n?=
 =?utf-8?B?OFZXMmRLUHFQRUxJWllnbHE2azZ1VVk1UEZWT05nVU5UR1JsM3d6c3ZmVk5i?=
 =?utf-8?B?MTFNdVlWQUdwMzNoOTBjK1Nzdk5peHl2NGF2d1FqeWhaVlNoZWFHdFR1MW9R?=
 =?utf-8?B?UG9QSU9abWdyVWwySHNVODIwd09VQ2Y1dXBwWG81MmFESGxkaHp5ajc2enpi?=
 =?utf-8?B?by9FWG1ubFRlZVNpc2pMelZUaWNQSFRTQ3B0VkpqZCtnMkRhZmZZTU5zTXdk?=
 =?utf-8?B?L0RTZ3h0RVBhdldncVBnRDFyUjRhN2Y2MnB3aTlNSk83UnRWbFd2eWVQMWxu?=
 =?utf-8?B?V3l1RXVreGRxZCtETkxkdHB5MGJBeDB3cUNNcVB4Y3ZzM05vTzlVMmNYMlRh?=
 =?utf-8?B?UWNzYTVDTUVPZnRnbkkySS9SVy9PMzF4WlpPcWtzVXpDN1JXS2NLaGgzUmhK?=
 =?utf-8?B?QjMxcnpRRXF5eitlVUZza1M0WGNsNzNPaGJ3ejd0K3lSUlZacU5nNGlDbkh1?=
 =?utf-8?B?Mi92dllwTjNqbVJ0cDM4TkhoejhBWThwSENDd2F3NTBXcXFvaUxpL1FYTnZ6?=
 =?utf-8?B?VFpIdzF2cXRvLzdtdG1weTFJeWVzenFIOXVmT2xlWlNhNXk0SE5ZNkpUd28v?=
 =?utf-8?B?NjlWRzRqWnJRZkRERVFjWWVJT0s2VlV6eWpqNkUwZjdRcDZrUUd3b1B4cEJO?=
 =?utf-8?B?VEh5dU5zK0x0KytqamlNLzNNZHVSa0RwV1lWdUYvUmN3WVo3WU8wVmY0SzA2?=
 =?utf-8?B?NUROemV1N1kyTnFieFk3cVZzbTBHMnREaklsajg2VUdha0IrWUlrZ1NKVkE0?=
 =?utf-8?B?T2pFeDZwdlRTb3hhbjFoZnZtd2hpZ0lpTUM3eEV6QWoyRDczVUF5SWxIclhv?=
 =?utf-8?B?RnZlVzBqbHBVWU5QdksyZW5FQlA0andDTW5EUktHcWNFS1A5cFhhVHVxWk5j?=
 =?utf-8?Q?5YnANfbaHDIpGvfeC5Em7Z8dG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7da28f-face-427e-66b5-08dd39570097
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:33:19.4162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wj4TOspEVDEEFc/6K9ksq8Q8XfpVS37aaVfggAfJpbWY47djqEu7ae0xlPtJzZOh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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

Am 20.01.25 um 14:31 schrieb Srinivasan Shanmugam:
> If the parent is NULL, adev->pdev is used to retrieve the PCIe speed and
> width, ensuring that  the function can still determine these
> capabilities from the device itself.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6193 amdgpu_device_gpu_bandwidth()
> 	error: we previously assumed 'parent' could be null (see line 6180)
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>      6170 static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>      6171                                         enum pci_bus_speed *speed,
>      6172                                         enum pcie_link_width *width)
>      6173 {
>      6174         struct pci_dev *parent = adev->pdev;
>      6175
>      6176         if (!speed || !width)
>      6177                 return;
>      6178
>      6179         parent = pci_upstream_bridge(parent);
>      6180         if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
>                       ^^^^^^
> If parent is NULL
>
>      6181                 /* use the upstream/downstream switches internal to dGPU */
>      6182                 *speed = pcie_get_speed_cap(parent);
>      6183                 *width = pcie_get_width_cap(parent);
>      6184                 while ((parent = pci_upstream_bridge(parent))) {
>      6185                         if (parent->vendor == PCI_VENDOR_ID_ATI) {
>      6186                                 /* use the upstream/downstream switches internal to dGPU */
>      6187                                 *speed = pcie_get_speed_cap(parent);
>      6188                                 *width = pcie_get_width_cap(parent);
>      6189                         }
>      6190                 }
>      6191         } else {
>      6192                 /* use the device itself */
> --> 6193                 *speed = pcie_get_speed_cap(parent);
>                                                       ^^^^^^ Then we are toasted here.
>
>      6194                 *width = pcie_get_width_cap(parent);
>      6195         }
>      6196 }
>
> Fixes: 9e424a5d9087 ("drm/amdgpu: cache gpu pcie link width")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
> v3: change the else s/parent/adev->pdev (Lijo)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 46af07faf8c8..8ed7f2f8546d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6174,7 +6174,7 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>   		return;
>   
>   	parent = pci_upstream_bridge(parent);
> -	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
> +	if (parent->vendor == PCI_VENDOR_ID_ATI) {

That will now crash when parent is NULL :)

Christian.

>   		/* use the upstream/downstream switches internal to dGPU */
>   		*speed = pcie_get_speed_cap(parent);
>   		*width = pcie_get_width_cap(parent);
> @@ -6187,8 +6187,8 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>   		}
>   	} else {
>   		/* use the device itself */
> -		*speed = pcie_get_speed_cap(parent);
> -		*width = pcie_get_width_cap(parent);
> +		*speed = pcie_get_speed_cap(adev->pdev);
> +		*width = pcie_get_width_cap(adev->pdev);
>   	}
>   }
>   

