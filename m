Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFEBC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 09:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7D310E8EC;
	Fri,  8 Aug 2025 09:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U7xCQ8vx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D4A10E8EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 09:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EupGNOlOAO+PRhQmVfB8F9+IxEs82lcUtxmCd0QGaRZ4KEAr+zfVIrFzSo/Nw1tUopOBe26SvF49Hpt4l0SaUQYSI87PW//Z0Zd5p0QESsAyRAquNJ3UyaFYHlNtJhUvNv4V9ibLaksULLn+CbRRXUZx8NJPNT3IVRt4Dj0Jb502fpF7SOH7Xpy0EcADZE+CCUgDmbFsTqcT0x3UbQpRgfMs7gRTqrznMvbIdniSqGr2PGHcpMzUus6cuhW90OYyB+mfR+io/aUjWW57NjNpk/ENy0eYlDOwkenLigGih/NIxxk6SStVex9T3uaDmxrqI2lMjNz4Ny1K6JNUx7Rz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7P8WolUF5gfUdasvFZakBKGgw+1vR19HgOW/M5Euw0=;
 b=h1ObESVVXUbmaGlF052esELgC+vh5o2eV+bripmna6i+9WfbBruB5UgYqvpQ0pbmnNk73C8COyKYel2E52MXQg8EyrNYrs0sFZPcxA8Dv3FbusLWnEs056rWhagyyPj9rGlLwZFu81o0EBpXmvGEJEfMqXWMpVaYUJauhiNORDBygLMlpss7ww0aObdVaaKSykRysSCJJhopeSN1rN59DK5mdss7MgyZeKc29WE9V/hUCVu1NS80/s5YHibTLP9oJARSeSGoHnqteUGYaz+C5Tct0MSp+oT/yyEtZLYzo+PymjjObwraN57LnUdW5YfauPmirSRTjRSP2d8dv5G6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7P8WolUF5gfUdasvFZakBKGgw+1vR19HgOW/M5Euw0=;
 b=U7xCQ8vx/Gy68Qo/ssqN508Y4RcMmt1PX0ZBYK99Us5oLL9ulBezfnXAFJwhI0KtBrZhGvDfXqtQzTC8Gn7D9ZdK42h5o/3UNboTS6fv7uTpoVlp3Am2GTMCet0W8y2Ru76tFQyXUXZC0vHNbR82lav5iBFspK7UW7a/+XCFUfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 09:19:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 09:19:30 +0000
Message-ID: <cdb905c1-97d0-4f96-a1a6-96bc0085ad34@amd.com>
Date: Fri, 8 Aug 2025 11:19:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add to custom amdgpu_drm_release
 drm_dev_enter/exit
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20250807220418.37185-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250807220418.37185-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a30af83-55b1-4ef2-a271-08ddd65cae48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmNvSVdmY0NZb2Z0aWpENXhjSEh0SnBUa1lZR3AxT3l3bEQ5dGh1emNxTldo?=
 =?utf-8?B?NVR0eTkzU0dRUk0zbC9kNWR1UElxRGVKbi96T0dGUGIyaHZhdjN6bnN3TDNC?=
 =?utf-8?B?ZGd2ZXhMZnNqTXhRbER4d3IrZHh6SDROSUN3ZEVZZk5MQkNoK3JkQXRHckYw?=
 =?utf-8?B?SHdnbXlHUlBBRjBGdHFPMEVRMDBRd3hacFhLSm5MK0h2MjV2MzhweG5pZDAx?=
 =?utf-8?B?NHcza2VwN3BCdjUyMEtUemUwbWhUblNsOVU0NEQ3RU01UDhNc001Um43c1dV?=
 =?utf-8?B?UWt6cXZCa1NuWWNvWWdlTndpZkp4VGpacS9UUjlrOU12RGtlRXhCTmpHVHUz?=
 =?utf-8?B?U29GNVV6SkM3UnM0RTB6Y0h3Wlptd0pudlEvY0U1SEVoaEJYZmtGQWtaRHBD?=
 =?utf-8?B?RUhnK01hajJzcFlFdVNWaFRDU0Jqc1Y1dUtrQ04xODJwQmJIMjVkcFArUU4z?=
 =?utf-8?B?ZmxJcm55ak5teUh5RkxTd3FYNkVYRFpJUE5tLzZkLytPMEV6UDFPOTVyeCtt?=
 =?utf-8?B?aFdTNzFBd0ZyNkExYmR6d3cvSjRBbm1Bc3RoTWVkTTJmYit3V200TUtzUHZy?=
 =?utf-8?B?YlJwZmwyVFFtUWx2WjJML0tFL3hlazErRHhST3l6OTY5NmExYzdBZ3pCdHpw?=
 =?utf-8?B?Zkd5TEhncXpQd2NhVlNsYitRd0dsNTFNRURZd3NaVjZzWVlvZE5HdHdDQ09x?=
 =?utf-8?B?N0R0cStabjVUbFFiOXVsSFZURTRsV0szTFZiS1F2ZG9aQ0hJSnFUaXE1Nk13?=
 =?utf-8?B?TWw0WGwrYWlwaG1ISnpMVjR5d21ZYkc2WHcxajIxdm51MEVaclBSWUNhZGZ5?=
 =?utf-8?B?M0dvT08rbzZ2OGpLOHFLUlhaMEtMNXd6bWRjczBtWlBsZTU0WkQvY3lZV0Zn?=
 =?utf-8?B?N0piajlDS0xJQU9vUExjeDBpRW51K2dzUDJ1UWYySm5ORm5RMktQOWNRQmNI?=
 =?utf-8?B?blppdDIycmpGMm0xVXdINTNtV21nUjRyZnNTcDNrTUd5TnpOcTdOMVJnUVRQ?=
 =?utf-8?B?cTZZcFVuT0htYWR5cm1jRkpEOFJDZTJxTFg3YTNjME4wWnN1NURnT2NxRjVw?=
 =?utf-8?B?NitNNU1DWThaaEMvNlpBbWtRZWJ3WVZSek51dlV0bHJMZThxVUpOTG1VRXlI?=
 =?utf-8?B?eHpvM2V4UFpWbWJIOTZURlpTTkdGbUtONWt1VXR1THlFc3l4RmVpd2xjZWFG?=
 =?utf-8?B?L3NDVnkrTHV3WndIYVRNRDNldjdpa0xSTGR1czFlWnlNNnBXZ2oxaXRMTGoz?=
 =?utf-8?B?UnpFb1FEQTU1VXkvWmwyV05GUGRPTnMxdG1SWU5ERWd2SDRoMEZlaDlIRUVY?=
 =?utf-8?B?T3dnQTZBNEQ0S002SUJBaUxGalF5K254SVA1M3JlY1UxTGV2U1hnalNHcWNi?=
 =?utf-8?B?aGxOTm42L2l2OTRJZE4vWS85TkRtTnozK2Erdkl2YkhGdmJMNG1CYXNWV3ZX?=
 =?utf-8?B?RmtjTzFiUDdJcmNCZjJ1M3dwT2Q5TmxsV3ZCRWRmWVNDWEtqTW5uSlp2T2xj?=
 =?utf-8?B?RmlubWNJd1pVNytHc29YS0NFdXcreFBGK21WZWYvbkl6ZXoyUURMalY1L2hK?=
 =?utf-8?B?dDUzR1hoSE9sWVd5MEM1dWZhL0t4V0wvYWo3bHhUQWYvWFJXWmZxaUt2RTZ4?=
 =?utf-8?B?UXhsb21WemdseVVRbkc3SmxmYzRIZDF1ZE9uOW1zKzY5U2d6d0E3RVpZR2hw?=
 =?utf-8?B?cHpCYmxVOTZERTcxcUNYRUhKaXdnMkI0cUd0SS9jN3ZIbW5FZTBwYTVSSzcw?=
 =?utf-8?B?UjNLVTNyQ2ZHSlBxNmpLc21DL0ZLVGdOam80azRrRHgxT2UrSnFOT051SHNW?=
 =?utf-8?B?WHRvTnpwcHBNTC8wQ3dQSHRQZGZHUXZUd0dVdkZVQXJ6T3VnVkJtcCtwVnhx?=
 =?utf-8?B?ckdiaWhrL21JUjlqbEpuZzMxbWZsZTBseDlhRG1GalM3djJVMnVVYkdVMlZx?=
 =?utf-8?Q?x1mDDlCpEAM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3EvWWhhZTZnSzdiY280SDMyVjZJcnVPcWNCczVxcVlEQUZVUzNZUUlGWEMr?=
 =?utf-8?B?eHdIbzd4VkFvNEdtL2VZQktZNjd1OUtZVEgzR3BkUXVPMXJMaHczT1ZuWWd0?=
 =?utf-8?B?ZDl0TWh3NUtVQmhRWUR5OXNJY1NmQi9POFFXb2ZySkx5SmY0L2poVXJLQ0c0?=
 =?utf-8?B?Q091UjFPbGgvOGVqUGpBK2krWE5PV3FjSlJ1NlFjYXZBcEYveTdnYWRQOFU4?=
 =?utf-8?B?V2FkWmM4TDRRMktTZzArNDVuWmNuTThWMVpoUFNuSW9VNTZLK05WNjltaEdH?=
 =?utf-8?B?QW5rYmlPVnhKdVRSbVpjZTljaG93am8yTDFUMDJTLy93ZDRTREx5YXFWS3Fo?=
 =?utf-8?B?eDhzREw5ZWJDOTJFTDRnMjJPaG5BL0s5cXlGVXQ5WUpMUGkyN1V0dWsrYUdj?=
 =?utf-8?B?VnU1WmRWdnlhOFJMRHlzTlNkMlJTQ0dmbWlTYThBUFlXQk9wQVpHbjBVS3VC?=
 =?utf-8?B?eG1TblFOMXdwbE0rV0paNjBZcEY0UUpzRkhWMTBLTU5vNXFuRnU3bUhNTG54?=
 =?utf-8?B?U2dKY1p4RWxRRzFvZGhiT0xCUWNyL01pR1J6VXVaM0RvVXdwY2x0WTFzM2Yw?=
 =?utf-8?B?eHBhS0VYZVZyR2VaQXIwbjlna01MTWRzREtuekJFdGxIbHBZamdIdnlGZU1C?=
 =?utf-8?B?ZjU4T1dCdVRWSkZ3OVBsTlVDUTU1ZHJoTlFtSG9DNE1sMkV2UHpYSHVJWkc4?=
 =?utf-8?B?YXNyV3J1R0svV2lITzZ0WEV4QWZVK2VMZkYySTlOODBaSUJPV25DSUkvVThw?=
 =?utf-8?B?cEdkNU5IWk15SzJ0N3hpbWk1STlRSDlMTnpObEdWWHFYUlJpVEd3REFYeHBp?=
 =?utf-8?B?N1ZXUlVtWmtTdXFiUUFqSHhjckhyQ1hScHR6N3BZQW9YLzhiVWQ0VDRjQTdN?=
 =?utf-8?B?aDIyYXEwTEw2TEZ2Z0pPZmdQNjN4NmFBYjMvSGt5eFRieFFxZXVzZndKZklW?=
 =?utf-8?B?Z1FsaVQzRUwyY0Z0N2M5YlVQcktBYjVrSkhYZ3BTNjVibEFJV0Q1L0pHMUZM?=
 =?utf-8?B?OGRBWGdJd2xHU2FHcHYrMVlId1BVdURETHhnejluMUFVUEZ3UVdMWVB2Wklt?=
 =?utf-8?B?TG9mdW45YkhuNHEydTQ2Z0pjeDg1dzFzYVk4T05RZDlaN3QrNi9oa0Yxdzh0?=
 =?utf-8?B?c1BEck1lRERkN3FzQ0EweHYxY1Q4ZDNybUpQMEFqRlpsS0NISzI5a09qRVpO?=
 =?utf-8?B?VjBHaGhVUUR1d2lGQ2dTWDFQQi85bTRYMit5MGVXS21nMmNuK3RzNElnVy92?=
 =?utf-8?B?aEh5b2F5cUt5WUdHWmx6akExZTFHNWxYMWZ6MDhsL2w4Um9HWDgyemVxRzNZ?=
 =?utf-8?B?cHE5Qk92YmdudkhJZ0xNQllPdXVtVG1hdzM3Q0g2Q29OZmRvVlpFZGo2VG5G?=
 =?utf-8?B?aGtqK0ZERHpPOG5aRk5MeStuWHdqVDdhMHFidm0wR2o5VzBRK1JJSzRLdVNi?=
 =?utf-8?B?SmtUSjRKWWtpcjl4NW0xV243VStTWlJia1FWT2Y0R1ExNDRlU2EvV0dtM3JP?=
 =?utf-8?B?bmpJaWRVbVJ3OStJU2ZabHFMWEN2eVNSQ01EajNXSVRvOXdQRWNKTHZZZ1BO?=
 =?utf-8?B?Nmh3VmJiSWkyenpFMnV6b1pmYzQwbFNBM21ucGR5NzR4NE1TdlRQZmVMQ3Va?=
 =?utf-8?B?K1FHWEJEeHY1NFh6OHlZNEs0Q0FkSUhaeG1ldHRLUXI4em01UGxiekhlaFBV?=
 =?utf-8?B?ZW1IMzI5VTRjZW15VDBlekgwa1dCSzg4VC90bTNlbloxeS9naHRReEVxRUZ4?=
 =?utf-8?B?eW1GNHVkNTBhNkI2eGdIY0hsL25TeGNEVUpqalUrTWZhRktCczJFZHJaM2tU?=
 =?utf-8?B?ZHo1MElnNHhHc0d3N1FmbW5JL0V2UGdFd2xiTURZZ3VSb28yOVNjMFFuUHBw?=
 =?utf-8?B?eU9KTklKL1pyeUJhQ1pZWlF0MHlWWERuQ0lHUldKS25LeG1NMXZuemtqbjAw?=
 =?utf-8?B?THpFTXluNzEyWnF2SGhIZjFTNzlLbytoOCtOZDZINVNNOVZmVVNjM0dSbHJp?=
 =?utf-8?B?Mm1uZmN4eURwUFpQMUZsSk9PVGprelU0YkxrTmpGb2N3bmpuQm1vTCtXMGFr?=
 =?utf-8?B?R2paMGE5dk1DckUvdW1McXcxVW8yOEtaN2duc3kxOG84dmVaSFpLQy8wWGF0?=
 =?utf-8?Q?6E7+kKC6V8f5EP3hq0a9bRbXD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a30af83-55b1-4ef2-a271-08ddd65cae48
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:19:30.8470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+uz84xK4k+KYcgdhjTWtSgsh0YYZDyPiwfTPQKachIopS4tqZaN2xb8m/OsATdG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

On 08.08.25 00:04, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> User queues are disabled before GEM objects are released
> (protecting against user app crashes).
> No races with PCI hot-unplug (because drm_dev_enter prevents cleanup
> if device is being removed).
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ff3a2eaaf55..32caaef522a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2920,11 +2920,14 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  {
>  	struct drm_file *file_priv = filp->private_data;
>  	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct drm_device *dev = file_priv->minor->dev;
> +	int idx;
>  
> -	if (fpriv) {
> +	if (fpriv && drm_dev_enter(dev, &idx)) {
>  		fpriv->evf_mgr.fd_closing = true;
>  		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>  		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> +		drm_dev_exit(idx);
>  	}
>  
>  	return drm_release(inode, filp);

