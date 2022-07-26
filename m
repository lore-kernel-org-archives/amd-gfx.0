Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA398C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5567518AB09;
	Tue, 26 Jul 2022 15:17:38 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C3018A7D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:17:36 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEESh0030536;
 Tue, 26 Jul 2022 15:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=NVVlZZbWnnZfsMzeRCpEbqs1KxfNVJHu/QoUDxctu9I=;
 b=EtRy7lBOavrokeI8nNrNLigknIdnaXPPwm+0aknoRRt4hO8hQAUz3Hon/6/ZKFkRJRz8
 SFLsEByThZhQ0jTYTpceeAxWUUU/UOMaJjQVIu14w3o9rkGswEOWA/7EhO1LXPihGRBe
 8NUik5QUAhq3oWWqhG8dSHGwEPXhypFjP2bEVZ6ABA3KJDqg9bECF3FGJKssHk7oHCNU
 QgejXosVFUbCE9dDksS16X1E1RwoJkgAtGoznPfC30hDaRo5nAqGiblqYZ6O7oLAtckj
 aG+BKY2ACdpUJkdcxD2tpBrlM4s3ABtAAhzFn40U6sAio4ATIRVxl+E/yqIaGySpdBNB PQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hspvrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:17:34 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QDrbwC006262; Tue, 26 Jul 2022 15:17:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh65bmyf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:17:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvRkG9ity9hMqo389z0usxhDt4pHvCWb9HyCyLHNLczAmHXwmNh6CUy3L7eGCDDLnwYZo/49Vgs2vcMTBWp/JqBi6Gnhpkwl+H9kApjv9tfoiCEhwSno5TwE2IeudzAP3JEuL2kAILHsXWyRdZ3+qpJcbL+iLWNNnpZJzmuQiGvLxEfoJmEzT+uS4tVe4ecslsz8S7Q416nmtjCrJLyVpjZEqzkRxPD2+2ddjRbk1k/TEGPQR6zewG+7Bc4b5sg2jIgMCzaaK3KzaPE72FJlXvbna0KkJdMtpA6E8zig1QF9monsMQXxV+4S91n45fIl/igCko4is4UPFOeBOGef0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVVlZZbWnnZfsMzeRCpEbqs1KxfNVJHu/QoUDxctu9I=;
 b=U4iFhj2/yKBbPvbpvFKVw6JnV3vL5Q7Jeuc0K3zcncM7P9ZJ+UemQlrPZCjx8HkFhWM97BjqbMK06zUPTC6FuXrDh+jHSlyHT+5JAMHhzV6380kz6rKzQNCGFIK2e2Kw1dllu9wfKtYOuQh9jj0Lgc6KWhSquscNLLycvQOpYIRBZULhM637lCLMsDr67I49MUbYjvcp4/UY31qu2bVH6AHKT3bJuQommKXUhfOqBSvkXw8mWeA7FPK1Xi4j2mxx2FKqY6zmtkQhcRYQrqlvaSDjC2tpA29AdjPJo4Zm49VM5C6v13MeqRwY6ZMcWnvuU7+LSkXELCO5qSY84SQa9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVVlZZbWnnZfsMzeRCpEbqs1KxfNVJHu/QoUDxctu9I=;
 b=urZAxtYkSPzZ+xwdxHL7TQtkbdQ2bGpqOLNsAAhy0jcZdORadQYTFDao73ZfLIcAGabDKfN5PwrfF2AXFq/2EeJCtbE2JUDHUoKyY4w9NqaYWUuJvRpK2b04R5n4gG3xhUMI1e+EhDRy7xuKkqJ4q3xjfO/Yu7zlAcxIH9FM4r8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1690.namprd10.prod.outlook.com
 (2603:10b6:4:b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 15:17:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:17:31 +0000
Date: Tue, 26 Jul 2022 18:17:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Vijendar.Mukunda@amd.com
Subject: [bug report] drm/amdgpu: create I2S platform devices for Jadeite
 platform
Message-ID: <YuAFgoepMHvkw3CB@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69216ebb-a2ce-449f-aa62-08da6f19f5e4
X-MS-TrafficTypeDiagnostic: DM5PR10MB1690:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHOMcFaWIL3q0D+0vpJsrGlJgPAeD4ikjVcGLf4gwX1gUJorqomPZw4L5yTL6BChcvL/9Teft07P78LCVQaYX/UDwJwENAIFMSr+nVG+q0TUKnp7EHSdxFubnrkWAuNHmI73LhPJlhun+MMO7nhosjSBPLOMOmibfZfhWVHRYm+x6Ex4i7EhZ6AcweXiyQvCesQ3gwQfd0vafYmzWTsml/amEl5kojwjQOI+4ItLGpu0lECxzjO5WuVlwVYjieI103Y/IZ3ZsfKpSnB50uGgZS8vSVLUW1j6CTmrEu/iaO7Tr6NDN1L5sHSJ2WEP/12p4nrImsb5erfyHn6rNrOnIuaYGMfTjVO4uu/w5vd39/DXSMX924UDXKfEGgYQvIz9gqJmewZ5OO/mXYHh1E2l7vvxhRGPGyAiSvCngp2iJaYnl1koaLXcifd5LATZ33eGYnGTFhGmyBHeT5RAQKzw5nbXv8ZGw9hjYk/lmMoHSO7CkqfslYWAW1bISp5Yu6b+azxopBnmezee1D+X4T3n69mf8eXhUf6f2Yx2pDakkQ9KLLIgHJ8WG13QVcUgs/r87/5KRyjOWiDFn8Lkt278ANDtt85jwoqm+hxqKXDZK68efLwwj58SpG//e0/ItK57hM9/nNrAO//hS3rl8pvCCnHeK/k2sNIEm8sBNm1ug+MCpNkpPW9spSlSjNue6fVq2I4xJHd15Kp/XlQQCuKvk9DnADKRRJ2cSEZAQsbXzfpDMlyZrFwSDzuDDnCIAy7lIttJn35sQeSFNM+nd8IPs4g/HxbJu6/x+JqPPOECEaPj4uIai11mPxQZE+pcKDFF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(8676002)(66476007)(4326008)(33716001)(66556008)(66946007)(30864003)(38100700002)(5660300002)(2906002)(8936002)(44832011)(38350700002)(6486002)(26005)(186003)(9686003)(41300700001)(6666004)(86362001)(6512007)(52116002)(478600001)(6506007)(6916009)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o59FjleTUUC+uaIkh/wuo9JOb/XP+e/7JxGx9936FAMUH8X56ZBhNMhSKSnN?=
 =?us-ascii?Q?tDM5CG24m4OjG6R2BGd2LH5VyHmfL+e+wNYe3LZ4h7L2W2Y5qraGz652HE2R?=
 =?us-ascii?Q?oHHyIck0lHwA86lEc65WAY16r5AFs9ErTN8eIHFwq1gnN8msZwVzMeeKDNWC?=
 =?us-ascii?Q?cQsmnjcwrVZTkAMpbZzCCVOz5qp/LZlh+F40Zi9aN6DvykRMh9NTqOmfFxkj?=
 =?us-ascii?Q?N8gxHhuC+cCFqo3skj32do+bTd1SUQMXwuXikocxbZXKQ+FmsgB16IsU1MPK?=
 =?us-ascii?Q?b8S0/SPSOgakzVDD+uJYcWwiPV7PDuGtzRYOwzuElZt1RoAlTeKaA61pG2Qc?=
 =?us-ascii?Q?JCd7CPhO7PHu6iqsCBVAN0ITR6vsrTQ+cWjABds/RyQVQJ6PUPVQ8cEi61wX?=
 =?us-ascii?Q?CDRukRllxkTfCSteyWVcOprB1JffyJ9ExrDydZ/cLFbozZkqNouha8+6fsuF?=
 =?us-ascii?Q?dI6a8+i+01NqNBGoaz7rFNh4hLwWaKcLks+vUFaUD7CKMMK1kjCVqjhw2n/n?=
 =?us-ascii?Q?Eotpx/vUWYP6wb4/eEdjgtGaNqfM1YPas03yw9D7+GZfQpMCw3wdsunEQ7FC?=
 =?us-ascii?Q?XMX2dLXtGHClDQg47bltAvKiVruN1gNfG61zXz/72tW3RAMiUVzyudTWyai7?=
 =?us-ascii?Q?FXCDFB0PINCwWO3hra35Q2D201fb+0YNxjlJ+ZEP7DTjr9MSwVlYYzptZoNg?=
 =?us-ascii?Q?7ryO9v+4m68yFai8FTUFv9C8B+YR5flSxaWYGf0M3SeN6B5yXiaxFYr5QFOa?=
 =?us-ascii?Q?NjBztyATKHbBCkMqM5kXvTVnJw0zn67PR3ZdE/qBffmTtNMWs9vZtyxDBt0Q?=
 =?us-ascii?Q?PLLVkn0HLshVvuiewIJNX1TRWTPfwHOhRr+CZ2a1dKDCkG8R8cJllVQ8TboG?=
 =?us-ascii?Q?tNRlfaOY8XdbXvtPg5KkDXfroxSRuVoD4SnXR5cateBJXYpAPJcY1SpSWGQh?=
 =?us-ascii?Q?JVJoWFG61fNhkO5FCbCOtTRRozbIQKYG9iiLaeyXvRjZiLHtGbuFeIGKy6Vw?=
 =?us-ascii?Q?gl0jcgFOV+YtXKM9XRYWV0ZjXhJDSxlWjUjpF7YtNVzdupZ7eAIsyY+poznL?=
 =?us-ascii?Q?c9TbkUs85uxX4EzhEWpwRhNsw7LLLlbatClaH1po3NLa2Lqe4oWFUVExprc8?=
 =?us-ascii?Q?mFFjL6JSnXqET1euNcKSHAqdyNEZn8OcFHU1pW7+VOYJezJAr9jajUv505e2?=
 =?us-ascii?Q?mOOo/6zNT24EsZz5OXc6/IT/PwHk77w2cYDCmCbXkTaWOoAoH32+OeVw3AEV?=
 =?us-ascii?Q?joOGISXs2VrNqhL986wPC/8Q2cUi37mdrUWm7QLWgJdyx58gN+xnVzbBX0oi?=
 =?us-ascii?Q?ox4Xwh8poT+oh7Wl2rWcjzSj1jd1Gz1KdBCOkvmHc0fkK9iUeKYiq6U/MjG5?=
 =?us-ascii?Q?P9YkIWo/qok7xomgD4qRssLOWFIchHFHvNwBAyc6vdxWz3pEERBjPXPLIFoV?=
 =?us-ascii?Q?CkjFMcwkt7u17LcGc6DZEclcwYbiv+BwuDUwu/VqWaBJTey8gjATSIpy4blC?=
 =?us-ascii?Q?nwIzhtkQCMLdTuOCfNTEcQHVI9asPEDqW+Obdu3cbXmzEob3MZWCqMqMqKgE?=
 =?us-ascii?Q?RRiftZkEGORI4HA0GYETyBCb/jQ55bDRTJWhZ5w206bc23elXQLOxR23/n0H?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69216ebb-a2ce-449f-aa62-08da6f19f5e4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:17:31.9115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzXJWt6iXi9dK79kzTHrfMSuPPnpUugQgd0K5uhwtlQl5Tu1sWtFHOsSkl0lD2ch1GPuPrJ0HW7iErq+RDwluKV2U/+1oapfft2AtISYfEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=971 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260059
X-Proofpoint-ORIG-GUID: BHOgh2aPhx0hB4X_qXdbXHxq5Dozpgaw
X-Proofpoint-GUID: BHOgh2aPhx0hB4X_qXdbXHxq5Dozpgaw
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Vijendar Mukunda,

The patch 4c33e5179ff1: "drm/amdgpu: create I2S platform devices for
Jadeite platform" from Jun 30, 2022, leads to the following Smatch
static checker warning:

    drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:393 acp_hw_init()
    error: buffer overflow 'i2s_pdata' 3 <= 3
    drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:396 acp_hw_init()
    error: buffer overflow 'i2s_pdata' 3 <= 3

drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
    225 static int acp_hw_init(void *handle)
    226 {
    227         int r;
    228         u64 acp_base;
    229         u32 val = 0;
    230         u32 count = 0;
    231         struct i2s_platform_data *i2s_pdata = NULL;
    232 
    233         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
    234 
    235         const struct amdgpu_ip_block *ip_block =
    236                 amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ACP);
    237 
    238         if (!ip_block)
    239                 return -EINVAL;
    240 
    241         r = amd_acp_hw_init(adev->acp.cgs_device,
    242                             ip_block->version->major, ip_block->version->minor);
    243         /* -ENODEV means board uses AZ rather than ACP */
    244         if (r == -ENODEV) {
    245                 amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
    246                 return 0;
    247         } else if (r) {
    248                 return r;
    249         }
    250 
    251         if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
    252                 return -EINVAL;
    253 
    254         acp_base = adev->rmmio_base;
    255         adev->acp.acp_genpd = kzalloc(sizeof(struct acp_pm_domain), GFP_KERNEL);
    256         if (!adev->acp.acp_genpd)
    257                 return -ENOMEM;
    258 
    259         adev->acp.acp_genpd->gpd.name = "ACP_AUDIO";
    260         adev->acp.acp_genpd->gpd.power_off = acp_poweroff;
    261         adev->acp.acp_genpd->gpd.power_on = acp_poweron;
    262         adev->acp.acp_genpd->adev = adev;
    263 
    264         pm_genpd_init(&adev->acp.acp_genpd->gpd, NULL, false);
    265         dmi_check_system(acp_quirk_table);
    266         switch (acp_machine_id) {
    267         case ST_JADEITE:
    268         {
    269                 adev->acp.acp_cell = kcalloc(2, sizeof(struct mfd_cell),
    270                                              GFP_KERNEL);
    271                 if (!adev->acp.acp_cell) {
    272                         r = -ENOMEM;
    273                         goto failure;
    274                 }
    275 
    276                 adev->acp.acp_res = kcalloc(3, sizeof(struct resource), GFP_KERNEL);
    277                 if (!adev->acp.acp_res) {
    278                         r = -ENOMEM;
    279                         goto failure;
    280                 }
    281 
    282                 i2s_pdata = kcalloc(1, sizeof(struct i2s_platform_data), GFP_KERNEL);
    283                 if (!i2s_pdata) {
    284                         r = -ENOMEM;
    285                         goto failure;
    286                 }
    287 
    288                 i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
    289                                       DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
    290                 i2s_pdata[0].cap = DWC_I2S_PLAY | DWC_I2S_RECORD;
    291                 i2s_pdata[0].snd_rates = SNDRV_PCM_RATE_8000_96000;
    292                 i2s_pdata[0].i2s_reg_comp1 = ACP_I2S_COMP1_CAP_REG_OFFSET;
    293                 i2s_pdata[0].i2s_reg_comp2 = ACP_I2S_COMP2_CAP_REG_OFFSET;
    294 
    295                 adev->acp.acp_res[0].name = "acp2x_dma";
    296                 adev->acp.acp_res[0].flags = IORESOURCE_MEM;
    297                 adev->acp.acp_res[0].start = acp_base;
    298                 adev->acp.acp_res[0].end = acp_base + ACP_DMA_REGS_END;
    299 
    300                 adev->acp.acp_res[1].name = "acp2x_dw_i2s_play_cap";
    301                 adev->acp.acp_res[1].flags = IORESOURCE_MEM;
    302                 adev->acp.acp_res[1].start = acp_base + ACP_I2S_CAP_REGS_START;
    303                 adev->acp.acp_res[1].end = acp_base + ACP_I2S_CAP_REGS_END;
    304 
    305                 adev->acp.acp_res[2].name = "acp2x_dma_irq";
    306                 adev->acp.acp_res[2].flags = IORESOURCE_IRQ;
    307                 adev->acp.acp_res[2].start = amdgpu_irq_create_mapping(adev, 162);
    308                 adev->acp.acp_res[2].end = adev->acp.acp_res[2].start;
    309 
    310                 adev->acp.acp_cell[0].name = "acp_audio_dma";
    311                 adev->acp.acp_cell[0].num_resources = 3;
    312                 adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
    313                 adev->acp.acp_cell[0].platform_data = &adev->asic_type;
    314                 adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
    315 
    316                 adev->acp.acp_cell[1].name = "designware-i2s";
    317                 adev->acp.acp_cell[1].num_resources = 1;
    318                 adev->acp.acp_cell[1].resources = &adev->acp.acp_res[1];
    319                 adev->acp.acp_cell[1].platform_data = &i2s_pdata[0];
    320                 adev->acp.acp_cell[1].pdata_size = sizeof(struct i2s_platform_data);
    321                 r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell, 2);
    322                 if (r)
    323                         goto failure;
    324                 r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
    325                                           acp_genpd_add_device);
    326                 if (r)
    327                         goto failure;
    328                 break;
    329         }
    330         default:
    331                 adev->acp.acp_cell = kcalloc(ACP_DEVS, sizeof(struct mfd_cell),
    332                                              GFP_KERNEL);
    333 
    334                 if (!adev->acp.acp_cell) {
    335                         r = -ENOMEM;
    336                         goto failure;
    337                 }
    338 
    339                 adev->acp.acp_res = kcalloc(5, sizeof(struct resource), GFP_KERNEL);
    340                 if (!adev->acp.acp_res) {
    341                         r = -ENOMEM;
    342                         goto failure;
    343                 }
    344 
    345                 i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
                                            ^
3 elements

    346                 if (!i2s_pdata) {
    347                         r = -ENOMEM;
    348                         goto failure;
    349                 }
    350 
    351                 switch (adev->asic_type) {
    352                 case CHIP_STONEY:
    353                         i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
    354                                 DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
    355                         break;
    356                 default:
    357                         i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
    358                 }
    359                 i2s_pdata[0].cap = DWC_I2S_PLAY;
    360                 i2s_pdata[0].snd_rates = SNDRV_PCM_RATE_8000_96000;
    361                 i2s_pdata[0].i2s_reg_comp1 = ACP_I2S_COMP1_PLAY_REG_OFFSET;
    362                 i2s_pdata[0].i2s_reg_comp2 = ACP_I2S_COMP2_PLAY_REG_OFFSET;
    363                 switch (adev->asic_type) {
    364                 case CHIP_STONEY:
    365                         i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
    366                                 DW_I2S_QUIRK_COMP_PARAM1 |
    367                                 DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
    368                         break;
    369                 default:
    370                         i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
    371                                 DW_I2S_QUIRK_COMP_PARAM1;
    372                 }
    373 
    374                 i2s_pdata[1].cap = DWC_I2S_RECORD;
    375                 i2s_pdata[1].snd_rates = SNDRV_PCM_RATE_8000_96000;
    376                 i2s_pdata[1].i2s_reg_comp1 = ACP_I2S_COMP1_CAP_REG_OFFSET;
    377                 i2s_pdata[1].i2s_reg_comp2 = ACP_I2S_COMP2_CAP_REG_OFFSET;
    378 
    379                 i2s_pdata[2].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
    380                 switch (adev->asic_type) {
    381                 case CHIP_STONEY:
    382                         i2s_pdata[2].quirks |= DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
    383                         break;
    384                 default:
    385                         break;
    386                 }
    387 
    388                 i2s_pdata[2].cap = DWC_I2S_PLAY | DWC_I2S_RECORD;
    389                 i2s_pdata[2].snd_rates = SNDRV_PCM_RATE_8000_96000;
    390                 i2s_pdata[2].i2s_reg_comp1 = ACP_BT_COMP1_REG_OFFSET;
    391                 i2s_pdata[2].i2s_reg_comp2 = ACP_BT_COMP2_REG_OFFSET;
    392 
--> 393                 i2s_pdata[3].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
                        ^^^^^^^^^^^^

    394                 switch (adev->asic_type) {
    395                 case CHIP_STONEY:
    396                         i2s_pdata[3].quirks |= DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
                                ^^^^^^^^^^^^

Out of boundses.

    397                         break;
    398                 default:
    399                         break;
    400                 }
    401                 adev->acp.acp_res[0].name = "acp2x_dma";
    402                 adev->acp.acp_res[0].flags = IORESOURCE_MEM;
    403                 adev->acp.acp_res[0].start = acp_base;
    404                 adev->acp.acp_res[0].end = acp_base + ACP_DMA_REGS_END;
    405 
    406                 adev->acp.acp_res[1].name = "acp2x_dw_i2s_play";
    407                 adev->acp.acp_res[1].flags = IORESOURCE_MEM;
    408                 adev->acp.acp_res[1].start = acp_base + ACP_I2S_PLAY_REGS_START;
    409                 adev->acp.acp_res[1].end = acp_base + ACP_I2S_PLAY_REGS_END;
    410 
    411                 adev->acp.acp_res[2].name = "acp2x_dw_i2s_cap";
    412                 adev->acp.acp_res[2].flags = IORESOURCE_MEM;
    413                 adev->acp.acp_res[2].start = acp_base + ACP_I2S_CAP_REGS_START;
    414                 adev->acp.acp_res[2].end = acp_base + ACP_I2S_CAP_REGS_END;
    415 
    416                 adev->acp.acp_res[3].name = "acp2x_dw_bt_i2s_play_cap";
    417                 adev->acp.acp_res[3].flags = IORESOURCE_MEM;
    418                 adev->acp.acp_res[3].start = acp_base + ACP_BT_PLAY_REGS_START;
    419                 adev->acp.acp_res[3].end = acp_base + ACP_BT_PLAY_REGS_END;
    420 
    421                 adev->acp.acp_res[4].name = "acp2x_dma_irq";
    422                 adev->acp.acp_res[4].flags = IORESOURCE_IRQ;
    423                 adev->acp.acp_res[4].start = amdgpu_irq_create_mapping(adev, 162);
    424                 adev->acp.acp_res[4].end = adev->acp.acp_res[4].start;
    425 
    426                 adev->acp.acp_cell[0].name = "acp_audio_dma";
    427                 adev->acp.acp_cell[0].num_resources = 5;
    428                 adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
    429                 adev->acp.acp_cell[0].platform_data = &adev->asic_type;
    430                 adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
    431 
    432                 adev->acp.acp_cell[1].name = "designware-i2s";
    433                 adev->acp.acp_cell[1].num_resources = 1;
    434                 adev->acp.acp_cell[1].resources = &adev->acp.acp_res[1];
    435                 adev->acp.acp_cell[1].platform_data = &i2s_pdata[0];
    436                 adev->acp.acp_cell[1].pdata_size = sizeof(struct i2s_platform_data);
    437 
    438                 adev->acp.acp_cell[2].name = "designware-i2s";
    439                 adev->acp.acp_cell[2].num_resources = 1;
    440                 adev->acp.acp_cell[2].resources = &adev->acp.acp_res[2];
    441                 adev->acp.acp_cell[2].platform_data = &i2s_pdata[1];
    442                 adev->acp.acp_cell[2].pdata_size = sizeof(struct i2s_platform_data);
    443 
    444                 adev->acp.acp_cell[3].name = "designware-i2s";
    445                 adev->acp.acp_cell[3].num_resources = 1;
    446                 adev->acp.acp_cell[3].resources = &adev->acp.acp_res[3];
    447                 adev->acp.acp_cell[3].platform_data = &i2s_pdata[2];
    448                 adev->acp.acp_cell[3].pdata_size = sizeof(struct i2s_platform_data);
    449 
    450                 r = mfd_add_hotplug_devices(adev->acp.parent, adev->acp.acp_cell, ACP_DEVS);
    451                 if (r)
    452                         goto failure;
    453 
    454                 r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
    455                                           acp_genpd_add_device);
    456                 if (r)
    457                         goto failure;
    458         }
    459 
    460         /* Assert Soft reset of ACP */
    461         val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
    462 
    463         val |= ACP_SOFT_RESET__SoftResetAud_MASK;
    464         cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
    465 
    466         count = ACP_SOFT_RESET_DONE_TIME_OUT_VALUE;
    467         while (true) {
    468                 val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
    469                 if (ACP_SOFT_RESET__SoftResetAudDone_MASK ==
    470                     (val & ACP_SOFT_RESET__SoftResetAudDone_MASK))
    471                         break;
    472                 if (--count == 0) {
    473                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
    474                         r = -ETIMEDOUT;
    475                         goto failure;
    476                 }
    477                 udelay(100);
    478         }
    479         /* Enable clock to ACP and wait until the clock is enabled */
    480         val = cgs_read_register(adev->acp.cgs_device, mmACP_CONTROL);
    481         val = val | ACP_CONTROL__ClkEn_MASK;
    482         cgs_write_register(adev->acp.cgs_device, mmACP_CONTROL, val);
    483 
    484         count = ACP_CLOCK_EN_TIME_OUT_VALUE;
    485 
    486         while (true) {
    487                 val = cgs_read_register(adev->acp.cgs_device, mmACP_STATUS);
    488                 if (val & (u32) 0x1)
    489                         break;
    490                 if (--count == 0) {
    491                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
    492                         r = -ETIMEDOUT;
    493                         goto failure;
    494                 }
    495                 udelay(100);
    496         }
    497         /* Deassert the SOFT RESET flags */
    498         val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
    499         val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
    500         cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
    501         return 0;
    502 
    503 failure:
    504         kfree(i2s_pdata);
    505         kfree(adev->acp.acp_res);
    506         kfree(adev->acp.acp_cell);
    507         kfree(adev->acp.acp_genpd);
    508         return r;
    509 }

regards,
dan carpenter
