Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADDFC28B28
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 08:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF4210E453;
	Tue, 18 Mar 2025 08:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tx8nFdfR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B470C10E452
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 08:33:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1KZO/QsL+lbTB6pUgINNcU6jR/0GOJ7NfhSJX1lZywy6WVg58f8Riy2bxshIkOGrWD/ITRNtdCjdbYCSfPSIIZfN3O8dC5l8p+J37ZQafYQoP4FHcqh5XMLY8r1P5TTV5RN0aO+PGFNJaFYv5Rt4ty3PFxbktCjsqwdKxzhUFRnE6VAVT+vfM7vpglpjhYylMq+htzBppdQx76nMYNebafx33EV03OOlDcpu8sLOVLn+9dBl+d+clKbTAO3iAJnjLbgv6Q2/YfD6h47z+TRVEgYZhRkXTZwOCr3b9rsxFvDIk45gE7C7+PWVum2SeRjRY5IllhM1TsZ68zugMrlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llP2vVHZ/A/VLNkweaMd73oBuSzPAPvd0GZApnIMT8o=;
 b=ADx1SBH0HYFkgjfnKZ7iwDiiIhn+GNr1ZMrTj9IEf1emhVQTszIr7OdVw2aGPXsyCh6Bvh2hTpNPBGI8XlF9ax1Nwt9jki7yrAkF62r45AAts+XrlMtO8Og9eZS84qr4gI4kg0LXUQ5K/R/tqP948K5+77g3R1BPAe0P0AH7G21IMfepkcYlp1ZX1dvQ+Ezeyn2uP0voxz2UGYa1vsU/SWVx2otv7E+3ugK311WrBm9IClW3uwMJOy1i8OL7txSHgPMiS1xqTfROPSd4+v5jPr9TxYCecb1yHCu2mQbi7FdWHmc4anRG7CTh7K/al4lSZ4GOHhm4cPJ+5NoCFBK5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llP2vVHZ/A/VLNkweaMd73oBuSzPAPvd0GZApnIMT8o=;
 b=tx8nFdfRCo8z2QOb8wfr4/5Re1JHctyjkuuIwjr6XVOnOgRPUcLu5rBeujVEPCPpj+he3CWe9ei8nbhCVj4dIxXxLwIaRTqyfxmH3zdUcdRtedZWKuPkkXOMbSecqP/n9MLy/BK+1I2oE3sa5FEFevCIJ5qxtkf2uQjZsAbzIC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 08:33:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:33:00 +0000
Message-ID: <adbce954-ace6-4c36-946d-eeba77fb2fd4@amd.com>
Date: Tue, 18 Mar 2025 14:02:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 2/3] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jiadong.zhu@amd.com
References: <20250305032520.1745117-1-jesse.zhang@amd.com>
 <20250305032520.1745117-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250305032520.1745117-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 64145d41-6f8c-448f-f90f-08dd65f77dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3Y0S1VKRUdwTEdyVk01b2FaL1MrV096SUYxMy9kNFJVbGtUeENuNW42dmlC?=
 =?utf-8?B?dmc0YmpIdWhBcDZ2MlZlOElBbllOUkVXa0srdEhLVjIzNWd2WHlIbm1VZzNW?=
 =?utf-8?B?QWRiWjE0d04rSUdMeCtlTDZXdVlSU0FVNDRod2xPUUx2Z0lESmErQUJmN0dh?=
 =?utf-8?B?anAzRDN1STlDT25wa3BBciswY3JJWGFEZERhcHAwbXI3cXZKZXNOM1dkaWY3?=
 =?utf-8?B?OXFYZWdwQ2ZvMlVXWExaR3Y5VlRUcXdzaUkyVlJmOGFGUXlCTXFadGp4ajRi?=
 =?utf-8?B?VURKWDV1N3JmaWcxaEdJbTEzNzRZVjhPU1lWVXllQWJHWVhYQXFaeXJjNSth?=
 =?utf-8?B?SExkRDBjU1lOaE1JVFFXSk5xQXZyUGIxT2srYVczdzUwalNIcHJzZHk3czJ0?=
 =?utf-8?B?VVZWcnhKR2ZBS1cvMEplbDlSOS9sNnNOR2pNUGJNakNUUXR1TXFGV1lmM0Fp?=
 =?utf-8?B?M1N6M3lleGM4T2ROTFN3ajB3TUlnQTloaTI0c0dDNVZvWlA3OVJsM2ViRnRS?=
 =?utf-8?B?K2Y0T1BPTFJid3REVUVhaTk0eXBMOXhqMlNUZDVoOEFZWUt2S3BVSTFHSDh5?=
 =?utf-8?B?cUFvQ24vNDMwUFJscmFNU25EMDhHdk5IR1pvUXgzNVMrbWt5S1NHN1MxK1c3?=
 =?utf-8?B?WlM1SlZtdk5NM0FDQ3Jpd256T1ZaRXNpQVZ3N0ZJdkY4OUQ1RmFQakpRQ1hk?=
 =?utf-8?B?M1h5VVZKb1RmUjRzdVJXUVlPYVR2bnJoQWpNNmlPR0J3T2VhTnVXblo4Vm1i?=
 =?utf-8?B?Y2xSSWt6SXlraStmTWFzdkk0YVl1VjZKTnZWblY1OVJ2M0JTdWlXZG9qZzYw?=
 =?utf-8?B?YW1LU1BZNEN0U0syWDlIdnhlUFVLVGUvSjJPZEJIaEptRUJHSDY1WU8wbmQz?=
 =?utf-8?B?N1NVYkpJeTRQRnFKd2h1OFMwVXY0bGdYQUJyUDVZdjZHK0NEL2FyOWNMaWRJ?=
 =?utf-8?B?bjdNVldpODViQk9oUmd3SFJLcUdtR3ZadkZONGdoaHJSa25DQW9lRUpwVXFy?=
 =?utf-8?B?Q29WcEd6dDFwTytOaEQ3dHh6TGloajhRRGVvZlg2TEVMTjZ1d0g4WTl3MS9u?=
 =?utf-8?B?TEJjektjYyttdEhRdkdKeUdGZnp2dlg1MVRVOVl5NWNpS1BjbHZxL0VVTlA3?=
 =?utf-8?B?YW85RjFkMDVFdkJ6cmswRENFdVRsYjRSTmEvcGhqVWFIeEpSMUZYbWE3RVgv?=
 =?utf-8?B?TWtiR29jL2JpM1VNMWdxWWRISmpRdXgwZzV1YVdYYkVjSUVOQytwSFBsTUZy?=
 =?utf-8?B?Y1NXc0lOUHhnR2RZMUNCbVhUdGxiemJpODllbjQ2OGs5R2Zmbk5XWm5ObStJ?=
 =?utf-8?B?MUpWRE9vMGd0QlFSMXR2MHQ4OE83Ym5Wdkk2K2FIL0luQ1RWTlhVYzNWSFZB?=
 =?utf-8?B?aTBId28waHZ4MXFuSFg3b2hWMk9LNG1GZktTMnJHNzh6eGRBb2RZSVlnRVFj?=
 =?utf-8?B?cDd4MWRKWm5RY1hqMERMaVFLUW9pMTFPcksyUEh2N3lEeDF0UU5JSDFuWGlN?=
 =?utf-8?B?Sis0NEVRVFlDcTlQdjBld1liSjVpQlhNNVovME9oQllyYVRIU2JzMUpod3Y2?=
 =?utf-8?B?YnpVbmwxV3pGaHBVd0pCcDUvUUkzY2N1YXJ5L2ZUTDY5UlNWZmo3dU5nRlBK?=
 =?utf-8?B?NFRwdDBTSWdsWGNCcWc4OEE4eXhjWDYvUjNxWFpqWXdIa2hydUJIdjNVTjBZ?=
 =?utf-8?B?MkFpVlpBcWQ1cnNmRXB6R0pLeUlqL3Q5UXVJU3ZKNm9MZ3ZKT3VEQ0ZZcEhR?=
 =?utf-8?B?UzlLeWQ4Tm5Ccmo0MGR6dTgvZ0NoemdQTFVvcU12eDNIMkhnQTFNUE8wZDl1?=
 =?utf-8?B?MWEwVWFnYlVoL2FCQ1JEWmRYdXZ2WjNOS0E3c2dTQlNTUkpxWDRKWTFTd1JS?=
 =?utf-8?Q?51x/Eze7BR48U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVKTTYyME9nc2JaL3VBQUVDWVFraldCU0hxY3V6TENpU3BFak9kWHAwSGw5?=
 =?utf-8?B?RlBENm1RY2hadVhCZEdHOWR1bE5IemtVRGphRTZXMVFBdjZCR0dGOUVzN1Ra?=
 =?utf-8?B?Z01QNldkK3F0ZERKV05PYmgwZEczOW10emNUc2NmWlBtTDZDSHo0aENCeUtn?=
 =?utf-8?B?WW9EZ0NoNVNYT1JKdTlFRE5xZzZpU3lEdEZjKzQvaTgxV2l0U3VDMHRWSmNL?=
 =?utf-8?B?aXl1Q2RvQi9rYTVhZ2MyWGwvVk9XME9YWndBclZlZnJPNEpPS2NISG9FQzZr?=
 =?utf-8?B?anRqTWhhVFQ2QmhjSDJIMVF5amRUMlIzRDIyVUFWbnZNVnlQWG1INmVXWHEz?=
 =?utf-8?B?a1pyOEMyKzVQUnBEbWN1SnZXcjBERXd0WURKSVBDT1lRV2JBM0dkdFB3SWdZ?=
 =?utf-8?B?SU8yd0V5eElzbWpCb2xSbWViUksrSVhXTHlOME1PR3lKa0RUWUJBbHZvbG5v?=
 =?utf-8?B?ZzhOSUVBV09zYnUxSXN2V29pY01vN2ZqRzZqVWVhVzRCVkZFSzlUTEZWeG51?=
 =?utf-8?B?MFd3UWJtTlYwbW10cDBiK0VNMXdvT2x5Rmg4RXk2ZFkvbGdGQ3hxeGtEQXRC?=
 =?utf-8?B?aVRMVDhRYW1UTWl0bGEvNnEweEhxMTZ5NVRCc1hUYmd5Uk9nMVlZU3VrZWU2?=
 =?utf-8?B?K1lkeFlKcDlLYmFnVms2NHpicHpjUWNxVjlBTUR2bXB4NVVPVC9SdldTeWZS?=
 =?utf-8?B?UzVrRktQSG5hdnBOQmtZYWFYVm5lTTh1TjJOTmU3aEdrc1g4azBzTmVJRjFz?=
 =?utf-8?B?TlZNNUhxU2xpMVlEOWdVUVFCVE5zQTNHVUlINDhvVFpXbGZvcHZ6RVMxMThO?=
 =?utf-8?B?cmRSY3QwbGh5NjBjUkJSOVRRRHBkR1lmSTlrbTdhcGdaY2dEbFgydGRmWmNN?=
 =?utf-8?B?MFFJek43RDVuT05EVFViTWw1ckhtZlY3dmVDclpPZHVXcmJnMHBHUUlibzNR?=
 =?utf-8?B?Q0NQK0d5NGF2akNPMUtaa1VPZXVwMmFueVlrbWorQi9zSzJLaU1TdjlRVUVB?=
 =?utf-8?B?RGRuV09iLzVsUkUzc3dDdTZqK2NjK2xmeHAwSE1GNi93V01xSEYrK3l0RW1T?=
 =?utf-8?B?VTh3Tkd3Ylg3MDVzK3dFRzRKWkNTRjN5ZXAzY2lCL3JDVXJIakFTWUtaZnNS?=
 =?utf-8?B?MDFsbDh2YWpaK3dVNnBPN3lYNnZPeTZQWXdnbWNid1ZqRWpWWHd2eHJZdDg0?=
 =?utf-8?B?QW83OHZpdFE0dmdBTnBIeVBka2pVN21DZzUrS3FsanF2UzM0Vjk1VExnZjE3?=
 =?utf-8?B?Q2pFVlVScmhGZDNsZ2E0YnI4Q0tCMy9wdHU4Yy9ZY2dhOTN0YSthcFhsUlgx?=
 =?utf-8?B?QnNJa1ZDUWtERU1tTXBjMUNiNk9TVGtxTFpMOGlhSjd2djgyeG5JUDlpZXlj?=
 =?utf-8?B?NW52RmFuQVYyOEZGM2JWemx0N1JpMTdtbUpkYUhJRWdOeE1nV1RKaDJVUFBH?=
 =?utf-8?B?S21ZUzRaYWl0L2FDaU5NRGVOOHU5QS9rWWQ4RE5TZWQ0aHFoZHNqYjkwcXh3?=
 =?utf-8?B?U3FaajdNTGczUStudGlxZ3owaFZHTXRndE5zdVNVUVg1OE9NOVlaSDFBelVv?=
 =?utf-8?B?ZGlRSk1WMDRPaERXMldLeFZCb0pYMnpIR1hHYUZnNTZpVWRzbUphWDF4TFFS?=
 =?utf-8?B?cjQ4NHlNOVhNNHk5bHdvNHlDYTRJZmpxNzY5TVA3d3JLNzRiMUg1dDB3MFBp?=
 =?utf-8?B?TnBmOUEvdkYrTGlmMVZ4dnpTQm9QTUtOQVNmS1NrbXptT09QUVRnc0E1QzRy?=
 =?utf-8?B?OUlrTmhzdlNvSldyVW1teGtKR0xZQlhvNXVUTkRublFqcEFyWTBOTVF2aEZW?=
 =?utf-8?B?WllrRVB3R09WSDFNcitOTFQwa3dBRFBJYXJ3WkZSTmQ4bEpCR1NYeUxZUDBJ?=
 =?utf-8?B?N0M0eVVUVEU3YmZ6M01vK2pPNTN6UDRhd09BRnRsR0RvVzZhL241ZXJGSVZL?=
 =?utf-8?B?a2ZFaXk0STFwKytBaXJQUTdlZFNuRkFTYTF3NHM2SnJtT3dINEp6WmRldEVK?=
 =?utf-8?B?Z1NyUGg2V0F2ZFFDUFVEcVBVSUxCUllVRnBrSlNTZFBWRzdDbURLYk9GTGt0?=
 =?utf-8?B?Z1VDMW9EY1ZvRHlWNUI1Q3hYTGkxcjRYeXJBOWNUeGdYQTRZajJ3YjNRQWpj?=
 =?utf-8?Q?FvGeoU5iQ2acrAFC+KfCdtU8K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64145d41-6f8c-448f-f90f-08dd65f77dec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:33:00.3910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp8LUpJOr3aG9AKMdu94hPt6L/yXJ82dY/e8CiRNBxlanKjD3V5TcDP+h7yx0l2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
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



On 3/5/2025 8:55 AM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>   allocating a separate engine. This change ensures efficient resource management and
>   avoids the issue of insufficient VM invalidation engines.
> 
> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>   during TLB flush operations. This improves the stability and reliability of the driver,
>   especially in multi-threaded environments.
> 
>  v2: replace the sdma ring check with a function `amdgpu_sdma_is_page_queue`
>  to check if a ring is an SDMA page queue.(Lijo)
> 
>  v3: Add GC version check, only enabled on GC9.4.3/9.4.4/9.5.0
>  v4: Fix code style and add more detailed description (Christian)
>  v5: Remove dependency on vm_inv_eng loop order, explicitly lookup shared inv_eng(Christian/Lijo)
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 31 +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 26 +++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>  3 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4eefa17fa39b..35cc45f4fd88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -571,7 +571,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ring *ring;
>  	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] = {0};
> -	unsigned i;
> +	unsigned i, j;
>  	unsigned vmhub, inv_eng;
>  
>  	/* init the vm inv eng for all vmhubs */
> @@ -602,6 +602,35 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  			return -EINVAL;
>  		}
>  
> +		/* SDMA has a special packet which allows it to use the same
> +		 * invalidation engine for all the rings in one instance.
> +		 * Therefore, we do not allocate a separate VM invalidation engine
> +		 * for SDMA page rings. Instead, they share the VM invalidation
> +		 * engine with the SDMA gfx ring. This change ensures efficient
> +		 * resource management and avoids the issue of insufficient VM
> +		 * invalidation engines.
> +		 */
> +		if (amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
> +			/* Find the shared invalidation engine for this ring */
> +			for (j = 0;  j < i; j++) {

It doesn't need this kind of search

amdgpu_sdma_get_shared_ring(adev, ring)

This can return the ring like

if (adev->sdma.has_page_queue && ring ==
&adev->&adev->sdma.instance[ring->me].ring )
	return &adev->&adev->sdma.instance[ring->me].page;
else
	return NULL;

If there is a shared page queue and inv_eng is not already assigned,
then assign the same engine as for this ring.

Thanks,
Lijo

> +				struct amdgpu_ring *shared_ring = adev->rings[j];
> +				if (shared_ring->me == ring->me && shared_ring != ring) {
> +					if (amdgpu_sdma_is_shared_inv_eng(adev, shared_ring)) {
> +						/* Assign the shared engine to this ring */
> +						ring->vm_inv_eng = shared_ring->vm_inv_eng;
> +						dev_info(adev->dev, "ring %s shares VM invalidation engine %u with ring %s on hub %u\n",
> +							ring->name, ring->vm_inv_eng, shared_ring->name, ring->vm_hub);
> +						break;
> +					}
> +				}
> +			}
> +
> +			/* Skip further allocation if the engine is already assigned */
> +			if (j < i) {
> +				continue;
> +			}
> +		}
> +
>  		ring->vm_inv_eng = inv_eng - 1;
>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 39669f8788a7..f2b8113d5279 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -504,6 +504,30 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  	}
>  }
>  
> +/**
> +* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that shares a VM invalidation engine
> +* @adev: Pointer to the AMDGPU device structure
> +* @ring: Pointer to the ring structure to check
> +*
> +* This function checks if the given ring is an SDMA ring that shares a VM invalidation engine.
> +* It returns true if the ring is such an SDMA ring, false otherwise.
> +*/
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	int i = ring->me;
> +
> +	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
> +		return false;
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +		return (ring == &adev->sdma.instance[i].ring ||
> +			ring == &adev->sdma.instance[i].page);
> +	else
> +		return false;
> +}
> +
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> @@ -545,7 +569,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
>  {
>  	struct sdma_on_reset_funcs *funcs;
>  	int ret = 0;
> -	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
> +	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
>  	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
>  	struct amdgpu_ring *page_ring = &sdma_instance->page;
>  	bool gfx_sched_stopped = false, page_sched_stopped = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 965169320065..1fa2049da6c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>  #endif

