Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158A4C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 06:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78856023F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 06:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C78856023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6365189F6E;
	Tue,  3 Aug 2021 06:30:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD7289F6E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 06:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFvSGcKo8s/vXQld85qmDQ92yUMf73ynXARt5RlFjPinTHwA1KbuK2a4BKXcE7b4IDGjc+J+ChNjbXm7azMUf/Xc2lH71SCy4RvrxEk99nQCNAF8EzddOUl64cxJrnz2yek7VvRoaKQsb/Wl/M6xZqp/kz8X/enoE2Gh6JhMUsv28AzuZ/CteaZ3mfY8OGXOjx7Gos6avUt/6HHporqGeW8bNHldWcD6EnaMYzGIhjDx31bie4xuS5YevcVTmTLbF6f/ibCgVrV/tCD+ltheh105WAytBszfPHS+eeQffi6eoY1FXeK/BdcdyEdJaaauN0CGP26XDr/IXySFFB5u7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41s0B1lE5lzPyEkPL2rBFVTtxFRGgrcDXWloZXDAHzk=;
 b=nquL3E8No2cJ4QnghtzZ6NMFN20PRmLtSxWRUEE4tLwIP1M7hBIC/Gn+nzoLK+2JVFUg9/sIaN1pxnypnV324dnr5eJan0+9TsK/EpWcXZAkvKA0BWkzEKQET2VltaqLbjbPdAFXTmS6OjP9h6xLG+XFCOkUCGnbaehAcdh7o/lxb3HuRugz5cXoNMXqZjaKw18fP1ImuN8hBO3nZMBw9IDvTNDZJRBq+NDuC49xAQD2ondynOGpqaL6e+2ua3kXOCaHcbCpXy4o7xlh67e+mxqZmuSsI+fyHudh6uuquAXRc+DSXna3lq6b54QwduamdEGeo4a8Wxs55887H4BmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41s0B1lE5lzPyEkPL2rBFVTtxFRGgrcDXWloZXDAHzk=;
 b=Ng+NWI+9MOQerPH+v/nLRoghvWGsw5MgRieLmcNyzQed0d4IgMOHd368u3iJvUaN3uPMfHHQ7Q0IvBNDEjHt6pw00N84IWayjXPHdRNARvjztsZ161xqFVc7OClKq+wFm9IohAC2HuwTxJh4HHlSEKdmHRUVO4mVhhcpxEJkqsw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 06:30:03 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 06:30:03 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf
To: "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Clements, John" <John.Clements@amd.com>
References: <DM6PR12MB46495DFBA7AA7E20614B7CC591F09@DM6PR12MB4649.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <9c4fe075-d02b-cb5d-3965-d78e5b937540@amd.com>
Date: Tue, 3 Aug 2021 11:59:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DM6PR12MB46495DFBA7AA7E20614B7CC591F09@DM6PR12MB4649.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::23) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Tue, 3 Aug 2021 06:30:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c88170b-5b74-47e3-5a64-08d95648203b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51591F4203525CE27E2264CD97F09@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4J2M6ygyk9kECOksNMlMo9mhLYPd0IScyx8fuEb8Mpx25kIgANZLFRx1XJ8v1rH7h3CL67/t1ItEUu08Vxev+MS8JAItnii83IWopPj1fwe+Ba7wc12g45pb82tAUde//QynvsUqzyUch/XrPM8Aj5bwt0Cz9w90GhwwJfgxCiS6cI5s0Lc5O9JGiQ9QRiDEEj6utLwUXdPTfKd/TtidakBd0G/JHeDD7eai7i6oD2/frKENV3xHC5oN+mArkeXDBTm8FgAH5sSzqCWZHIMe4va2UhsifJzKeNAG3DnPwJBzVD0hUjABWJYZqHgfZ7p85FAouh50OurGBcS1NevPzBxcCW3GtlaWWHE9KZsGuL+LwWBlAhctjJBa0WWtCsZWvIwn1tXCZ8QftjAr9xmk18MK+8EMVGgVhe1/tpALCyERY7KB8POlmfCA0mViMW09Wpwp0aoQG+S3yzC24gTbQruoNZ3YXN8+mgpP8kQ0fNPU6E45DB+YSL+NF7EkDu/11FO3ElpTDxOI0JEsIcZNZnUF6Xgo/3ySfs/nz/85h+csp20LAp7KE7dGGBOqLTeOpL9Rdd+y+e58QwjcXS5lIdHW2BdvpK9nzH0ACRtYnWZ4Hc4kM4nzcddzZBXTjAMXSzqhhrIBljOvFnBio+desqCfalSR1pQSegEnMvejxBWccJQRvRO8AuwyXAZriitT0aPBDOgI8BXiSZHj5S/k/j/IgBNa8ACu3kpk1thYX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(38100700002)(53546011)(2906002)(16576012)(956004)(2616005)(316002)(6486002)(30864003)(31686004)(5660300002)(478600001)(110136005)(4326008)(8676002)(8936002)(66556008)(66476007)(186003)(66946007)(86362001)(31696002)(83380400001)(26005)(6666004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?a8TcNCputrIT/jgA5iGJCcC/9VSAmLdoa5Z1u3u+ItKC9DuaWN8eNbQx?=
 =?Windows-1252?Q?WIt5Qr1+MNmDKANd29Fw6YwSt56KSpf4O85VJhtcRj0tdITQPEyZ12bb?=
 =?Windows-1252?Q?jYRRko5mXxaeHt3qTIfUtoJbhMLG478yHZJlR0F8nHXbLXOIP7g1PAmW?=
 =?Windows-1252?Q?1vadeWpE/BqXj1exveRkmZ2aU5yD1YgjQuT2kok6Y570Dzl867rig3sI?=
 =?Windows-1252?Q?V+fKk9sPO+4yIQKpU7uNeBm0t1s5ImhSfF5Ku2jKtSxQfjoF+ntPcxvt?=
 =?Windows-1252?Q?ps7y6JYForOMEY/jpao/87SEgQaFVq8F91jReMq5L4hnmB5pFfKGjh14?=
 =?Windows-1252?Q?bGwV62x4Y7l+YZbldTmK1tQa8pN6Lgv5d24yt0Rpie6y+DTPgwcBbP75?=
 =?Windows-1252?Q?eeQLz52xZ0EkNzApTM8MVlbWZUCBuILri9SwChQikwbYKhVAtHYJ0HID?=
 =?Windows-1252?Q?Ix6xFQlW1fZUTpfHtx/Nqlg3JaTJRXfa6r/tHLp74zAsaRsF35ofgK7A?=
 =?Windows-1252?Q?r59XOv2MeLptVSonrlrI0OnPSRX5Q5cg3LJeHSyOlEaXLR9yMsq6ZYya?=
 =?Windows-1252?Q?BcgV+zZQ2c6ZzgcootQg4sLDPq9fM1V8lGD8eHt927lebHK3BYYJM0Og?=
 =?Windows-1252?Q?LOfSZK/8+/WR2twjLhXNacZkxDPK6gaVjnbWQojuDXG9E6XBAzlSCbnN?=
 =?Windows-1252?Q?yvrFMGcggDmYuz5llL1X5bUh3WGcRNh4MDAJIsYRpMcWtPhPkv1My3Ol?=
 =?Windows-1252?Q?+xKzDuaHcUqpZskV4hSWswY7Xq7KPClvL/pzqdBgevEHSkNGCG3xyNNS?=
 =?Windows-1252?Q?lNdwF+z4Q5K9q/quVbI/1An60q/pp1IdVOqOhPpzAiM8CdMesqkJkPHP?=
 =?Windows-1252?Q?kAEkGPC2ddidJ59MUoPkpm9pRQcQd+SuWOjcozLyfWNAUGMYnh/lo+rf?=
 =?Windows-1252?Q?rLW10SYDbTkEnQm6jicVelJrFsv0NBSql8TrE40BC7o9bdpqnRWkgcnW?=
 =?Windows-1252?Q?6jXVVEnODz074VzVw/MyS7LvHIis3uV1n2+DqlPGYjKOCZAqzqZC7m4d?=
 =?Windows-1252?Q?TbiPQRHOBnh4lxWu5mR2k+NcEo9PJQ2d8pykNxCY7zjg30k2Qn5O+Kxf?=
 =?Windows-1252?Q?+snUlBtMH6BmFtJh1ueR5LOuGU/saWY/dTgUyZmL+5a4fUUibEdmJbw0?=
 =?Windows-1252?Q?rQSdMyUdDMS3sZ9tpQUauAcygp9BaLbAfKDJ0aPIzaF16wS54i5EVlp8?=
 =?Windows-1252?Q?mH6JGiOL/MrMGoCZx5KBUVbV9UJcLNGUn5hiTYhrfGBLgCNJkYDjDf5p?=
 =?Windows-1252?Q?PDzTNvHwV81u7U54/RXOhEgKsgbH0lSzDrYrrtXjQHx6Uioau103iXCE?=
 =?Windows-1252?Q?1Ix3thKLl6/6MjbY58JwbyTBfBxdlqWzhMyJreN1Xp/zcBlPo0FEW/gU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c88170b-5b74-47e3-5a64-08d95648203b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 06:30:03.3048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixoCTwawuE0ugVkDS4tvTprO7oRfdly7VVgHsZnvfOZD0M/Bz+2gwjf19usHczgH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
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

Command buffer in psp context means different command buffers cannot be 
prepared in parallel. Any case of submitting commands for different TAs 
in parallel - ex: for RAS and some other TA?

Thanks,
Lijo

On 8/3/2021 8:35 AM, Li, Candice wrote:
> [Public]
> 
> 
> Signed-off-by: Candice Li candice.li@amd.com <mailto:candice.li@amd.com>
> 
> ---
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 253 ++++++++----------------
> 
> 1 file changed, 78 insertions(+), 175 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> 
> index ed731144ca7f..9c18558e3bc0 100644
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> 
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> 
> @@ -253,6 +253,12 @@ static int psp_sw_init(void *handle)
> 
>               struct psp_runtime_boot_cfg_entry boot_cfg_entry;
> 
>               struct psp_memory_training_context *mem_training_ctx = 
> &psp->mem_train_ctx;
> 
> +            psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), 
> GFP_KERNEL);
> 
> +            if (!psp->cmd) {
> 
> +                           DRM_ERROR("Failed to allocate memory to 
> command buffer!\n");
> 
> +                           ret = -ENOMEM;
> 
> +            }
> 
> +
> 
>               if (!amdgpu_sriov_vf(adev)) {
> 
>                              ret = psp_init_microcode(psp);
> 
>                              if (ret) {
> 
> @@ -315,25 +321,30 @@ static int psp_sw_init(void *handle)
> 
> static int psp_sw_fini(void *handle)
> 
> {
> 
>               struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> +            struct psp_context *psp = &adev->psp;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
> -             psp_memory_training_fini(&adev->psp);
> 
> -             if (adev->psp.sos_fw) {
> 
> -                           release_firmware(adev->psp.sos_fw);
> 
> -                           adev->psp.sos_fw = NULL;
> 
> +            psp_memory_training_fini(psp);
> 
> +            if (psp->sos_fw) {
> 
> +                           release_firmware(psp->sos_fw);
> 
> +                           psp->sos_fw = NULL;
> 
>               }
> 
> -             if (adev->psp.asd_fw) {
> 
> -                           release_firmware(adev->psp.asd_fw);
> 
> +            if (psp->asd_fw) {
> 
> +                           release_firmware(psp->asd_fw);
> 
>                              adev->psp.asd_fw = NULL;
> 
>               }
> 
> -             if (adev->psp.ta_fw) {
> 
> -                           release_firmware(adev->psp.ta_fw);
> 
> -                           adev->psp.ta_fw = NULL;
> 
> +            if (psp->ta_fw) {
> 
> +                           release_firmware(psp->ta_fw);
> 
> +                           psp->ta_fw = NULL;
> 
>               }
> 
>                if (adev->asic_type == CHIP_NAVI10 ||
> 
>                   adev->asic_type == CHIP_SIENNA_CICHLID)
> 
>                              psp_sysfs_fini(adev);
> 
> +            kfree(cmd);
> 
> +            cmd = NULL;
> 
> +
> 
>               return 0;
> 
> }
> 
> @@ -491,6 +502,8 @@ static void psp_prep_tmr_cmd_buf(struct psp_context 
> *psp,
> 
>               uint32_t size = amdgpu_bo_size(tmr_bo);
> 
>               uint64_t tmr_pa = amdgpu_gmc_vram_pa(adev, tmr_bo);
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
> 
>               else
> 
> @@ -506,6 +519,8 @@ static void psp_prep_tmr_cmd_buf(struct psp_context 
> *psp,
> 
> static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd,
> 
>                                                                 uint64_t 
> pri_buf_mc, uint32_t size)
> 
> {
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               cmd->cmd_id = GFX_CMD_ID_LOAD_TOC;
> 
>               cmd->cmd.cmd_load_toc.toc_phy_addr_lo = 
> lower_32_bits(pri_buf_mc);
> 
>               cmd->cmd.cmd_load_toc.toc_phy_addr_hi = 
> upper_32_bits(pri_buf_mc);
> 
> @@ -517,11 +532,8 @@ static int psp_load_toc(struct psp_context *psp,
> 
>                                            uint32_t *tmr_size)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
>               /* Copy toc to psp firmware private buffer */
> 
>               psp_copy_fw(psp, psp->toc.start_addr, psp->toc.size_bytes);
> 
> @@ -531,7 +543,7 @@ static int psp_load_toc(struct psp_context *psp,
> 
>                                                           
>   psp->fence_buf_mc_addr);
> 
>               if (!ret)
> 
>                              *tmr_size = psp->cmd_buf_mem->resp.tmr_size;
> 
> -             kfree(cmd);
> 
> +
> 
>               return ret;
> 
> }
> 
> @@ -588,7 +600,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
> 
> static int psp_tmr_load(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                /* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set 
> up TMR.
> 
>                * Already set up by host driver.
> 
> @@ -596,10 +608,6 @@ static int psp_tmr_load(struct psp_context *psp)
> 
>               if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
> 
>               DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
> 
>                               amdgpu_bo_size(psp->tmr_bo), 
> psp->tmr_mc_addr);
> 
> @@ -607,14 +615,14 @@ static int psp_tmr_load(struct psp_context *psp)
> 
>               ret = psp_cmd_submit_buf(psp, NULL, cmd,
> 
>                                                           
>   psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
>   static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
> 
> -                                                                       
> struct psp_gfx_cmd_resp *cmd)
> 
> +                                                               struct 
> psp_gfx_cmd_resp *cmd)
> 
> {
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              cmd->cmd_id = GFX_CMD_ID_DESTROY_VMR;
> 
>               else
> 
> @@ -624,11 +632,7 @@ static void psp_prep_tmr_unload_cmd_buf(struct 
> psp_context *psp,
> 
> static int psp_tmr_unload(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> -
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                psp_prep_tmr_unload_cmd_buf(psp, cmd);
> 
>               DRM_INFO("free PSP TMR buffer\n");
> 
> @@ -636,8 +640,6 @@ static int psp_tmr_unload(struct psp_context *psp)
> 
>               ret = psp_cmd_submit_buf(psp, NULL, cmd,
> 
>                                                           
>   psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> @@ -662,7 +664,9 @@ int psp_get_fw_attestation_records_addr(struct 
> psp_context *psp,
> 
>                                                                         
> uint64_t *output_ptr)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
> +
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
>                if (!output_ptr)
> 
>                              return -EINVAL;
> 
> @@ -670,10 +674,6 @@ int psp_get_fw_attestation_records_addr(struct 
> psp_context *psp,
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               cmd->cmd_id = GFX_CMD_ID_GET_FW_ATTESTATION;
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
> 
> @@ -684,29 +684,26 @@ int psp_get_fw_attestation_records_addr(struct 
> psp_context *psp,
> 
>                                            
>        ((uint64_t)cmd->resp.uresp.fwar_db_info.fwar_db_addr_hi << 32);
> 
>               }
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
>   static int psp_boot_config_get(struct amdgpu_device *adev, uint32_t 
> *boot_cfg)
> 
> {
> 
>               struct psp_context *psp = &adev->psp;
> 
> -             struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>               int ret;
> 
> +            memset(psp->cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               if (amdgpu_sriov_vf(adev))
> 
>                              return 0;
> 
> -             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> -
> 
> -             cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
> 
> -             cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_GET;
> 
> +            psp->cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
> 
> +            psp->cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_GET;
> 
> -             ret = psp_cmd_submit_buf(psp, NULL, cmd, 
> psp->fence_buf_mc_addr);
> 
> +            ret = psp_cmd_submit_buf(psp, NULL, psp->cmd, 
> psp->fence_buf_mc_addr);
> 
>               if (!ret) {
> 
>                              *boot_cfg =
> 
> -                                          
> (cmd->resp.uresp.boot_cfg.boot_cfg & BOOT_CONFIG_GECC) ? 1 : 0;
> 
> +                                         
> (psp->cmd->resp.uresp.boot_cfg.boot_cfg & BOOT_CONFIG_GECC) ? 1 : 0;
> 
>               }
> 
>                return ret;
> 
> @@ -715,19 +712,18 @@ static int psp_boot_config_get(struct 
> amdgpu_device *adev, uint32_t *boot_cfg)
> 
> static int psp_boot_config_set(struct amdgpu_device *adev, uint32_t 
> boot_cfg)
> 
> {
> 
>               struct psp_context *psp = &adev->psp;
> 
> -             struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
> +
> 
> +            memset(psp->cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
>                if (amdgpu_sriov_vf(adev))
> 
>                              return 0;
> 
> -             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> -
> 
> -             cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
> 
> -             cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_SET;
> 
> -             cmd->cmd.boot_cfg.boot_config = boot_cfg;
> 
> -             cmd->cmd.boot_cfg.boot_config_valid = boot_cfg;
> 
> +            psp->cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
> 
> +            psp->cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_SET;
> 
> +            psp->cmd->cmd.boot_cfg.boot_config = boot_cfg;
> 
> +            psp->cmd->cmd.boot_cfg.boot_config_valid = boot_cfg;
> 
> -             return psp_cmd_submit_buf(psp, NULL, cmd, 
> psp->fence_buf_mc_addr);
> 
> +            return psp_cmd_submit_buf(psp, NULL, psp->cmd, 
> psp->fence_buf_mc_addr);
> 
> }
> 
>   static int psp_rl_load(struct amdgpu_device *adev)
> 
> @@ -735,14 +731,14 @@ static int psp_rl_load(struct amdgpu_device *adev)
> 
>               struct psp_context *psp = &adev->psp;
> 
>               struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               if (!is_psp_fw_valid(psp->rl))
> 
>                              return 0;
> 
>                memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> 
>               memcpy(psp->fw_pri_buf, psp->rl.start_addr, 
> psp->rl.size_bytes);
> 
> -             memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> -
> 
>               cmd->cmd_id = GFX_CMD_ID_LOAD_IP_FW;
> 
>               cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo = 
> lower_32_bits(psp->fw_pri_mc_addr);
> 
>               cmd->cmd.cmd_load_ip_fw.fw_phy_addr_hi = 
> upper_32_bits(psp->fw_pri_mc_addr);
> 
> @@ -755,6 +751,8 @@ static int psp_rl_load(struct amdgpu_device *adev)
> 
> static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
> 
>                                                           uint64_t 
> asd_mc, uint32_t size)
> 
> {
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               cmd->cmd_id = GFX_CMD_ID_LOAD_ASD;
> 
>               cmd->cmd.cmd_load_ta.app_phy_addr_lo = lower_32_bits(asd_mc);
> 
>               cmd->cmd.cmd_load_ta.app_phy_addr_hi = upper_32_bits(asd_mc);
> 
> @@ -768,7 +766,7 @@ static void psp_prep_asd_load_cmd_buf(struct 
> psp_gfx_cmd_resp *cmd,
> 
> static int psp_asd_load(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                /* If PSP version doesn't match ASD version, asd loading 
> will be failed.
> 
>                * add workaround to bypass it for sriov now.
> 
> @@ -777,10 +775,6 @@ static int psp_asd_load(struct psp_context *psp)
> 
>               if (amdgpu_sriov_vf(psp->adev) || !psp->asd_ucode_size)
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_copy_fw(psp, psp->asd_start_addr, psp->asd_ucode_size);
> 
>                psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
> 
> @@ -793,14 +787,14 @@ static int psp_asd_load(struct psp_context *psp)
> 
>                              psp->asd_context.session_id = 
> cmd->resp.session_id;
> 
>               }
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
>   static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_cmd_resp *cmd,
> 
>                                                           
>         uint32_t session_id)
> 
> {
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               cmd->cmd_id = GFX_CMD_ID_UNLOAD_TA;
> 
>               cmd->cmd.cmd_unload_ta.session_id = session_id;
> 
> }
> 
> @@ -808,7 +802,7 @@ static void psp_prep_ta_unload_cmd_buf(struct 
> psp_gfx_cmd_resp *cmd,
> 
> static int psp_asd_unload(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                if (amdgpu_sriov_vf(psp->adev))
> 
>                              return 0;
> 
> @@ -816,10 +810,6 @@ static int psp_asd_unload(struct psp_context *psp)
> 
>               if (!psp->asd_context.asd_initialized)
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_prep_ta_unload_cmd_buf(cmd, psp->asd_context.session_id);
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
> 
> @@ -827,14 +817,14 @@ static int psp_asd_unload(struct psp_context *psp)
> 
>               if (!ret)
> 
>                              psp->asd_context.asd_initialized = false;
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
>   static void psp_prep_reg_prog_cmd_buf(struct psp_gfx_cmd_resp *cmd,
> 
>                              uint32_t id, uint32_t value)
> 
> {
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               cmd->cmd_id = GFX_CMD_ID_PROG_REG;
> 
>               cmd->cmd.cmd_setup_reg_prog.reg_value = value;
> 
>               cmd->cmd.cmd_setup_reg_prog.reg_id = id;
> 
> @@ -843,22 +833,17 @@ static void psp_prep_reg_prog_cmd_buf(struct 
> psp_gfx_cmd_resp *cmd,
> 
> int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
> 
>                              uint32_t value)
> 
> {
> 
> -             struct psp_gfx_cmd_resp *cmd = NULL;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>               int ret = 0;
> 
>                if (reg >= PSP_REG_LAST)
> 
>                              return -EINVAL;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_prep_reg_prog_cmd_buf(cmd, reg, value);
> 
>               ret = psp_cmd_submit_buf(psp, NULL, cmd, 
> psp->fence_buf_mc_addr);
> 
>               if (ret)
> 
>                              DRM_ERROR("PSP failed to program reg id 
> %d", reg);
> 
> -             kfree(cmd);
> 
>               return ret;
> 
> }
> 
> @@ -868,6 +853,8 @@ static void psp_prep_ta_load_cmd_buf(struct 
> psp_gfx_cmd_resp *cmd,
> 
>                                                                uint64_t 
> ta_shared_mc,
> 
>                                                                uint32_t 
> ta_shared_size)
> 
> {
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               cmd->cmd_id                                               
> = GFX_CMD_ID_LOAD_TA;
> 
>               cmd->cmd.cmd_load_ta.app_phy_addr_lo          = 
> lower_32_bits(ta_bin_mc);
> 
>               cmd->cmd.cmd_load_ta.app_phy_addr_hi          = 
> upper_32_bits(ta_bin_mc);
> 
> @@ -899,6 +886,8 @@ static void psp_prep_ta_invoke_cmd_buf(struct 
> psp_gfx_cmd_resp *cmd,
> 
>                                                           
>         uint32_t ta_cmd_id,
> 
>                                                           
>         uint32_t session_id)
> 
> {
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
> +
> 
>               cmd->cmd_id                                               
> = GFX_CMD_ID_INVOKE_CMD;
> 
>               cmd->cmd.cmd_invoke_cmd.session_id = session_id;
> 
>               cmd->cmd.cmd_invoke_cmd.ta_cmd_id = ta_cmd_id;
> 
> @@ -909,35 +898,25 @@ static int psp_ta_invoke(struct psp_context *psp,
> 
>                                uint32_t session_id)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> -
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                psp_prep_ta_invoke_cmd_buf(cmd, ta_cmd_id, session_id);
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
> 
>                                                           
>   psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
>   static int psp_xgmi_load(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                /*
> 
>                * TODO: bypass the loading in sriov for now
> 
>                */
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_copy_fw(psp, psp->ta_xgmi_start_addr, 
> psp->ta_xgmi_ucode_size);
> 
>                psp_prep_ta_load_cmd_buf(cmd,
> 
> @@ -954,15 +933,13 @@ static int psp_xgmi_load(struct psp_context *psp)
> 
>                              psp->xgmi_context.session_id = 
> cmd->resp.session_id;
> 
>               }
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
>   static int psp_xgmi_unload(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>               struct amdgpu_device *adev = psp->adev;
> 
>                /* XGMI TA unload currently is not supported on 
> Arcturus/Aldebaran A+A */
> 
> @@ -974,17 +951,11 @@ static int psp_xgmi_unload(struct psp_context *psp)
> 
>                * TODO: bypass the unloading in sriov for now
> 
>                */
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_prep_ta_unload_cmd_buf(cmd, psp->xgmi_context.session_id);
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
> 
>                                                           
>   psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> @@ -1204,7 +1175,7 @@ static int psp_ras_init_shared_buf(struct 
> psp_context *psp)
> 
> static int psp_ras_load(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>               struct ta_ras_shared_memory *ras_cmd;
> 
>                /*
> 
> @@ -1213,10 +1184,6 @@ static int psp_ras_load(struct psp_context *psp)
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_copy_fw(psp, psp->ta_ras_start_addr, 
> psp->ta_ras_ucode_size);
> 
>                ras_cmd = (struct ta_ras_shared_memory 
> *)psp->ras.ras_shared_buf;
> 
> @@ -1247,15 +1214,13 @@ static int psp_ras_load(struct psp_context *psp)
> 
>               if (ret || ras_cmd->ras_status)
> 
>                              amdgpu_ras_fini(psp->adev);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
>   static int psp_ras_unload(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                /*
> 
>                * TODO: bypass the unloading in sriov for now
> 
> @@ -1263,17 +1228,11 @@ static int psp_ras_unload(struct psp_context *psp)
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_prep_ta_unload_cmd_buf(cmd, psp->ras.session_id);
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
> 
>                                            psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> @@ -1514,7 +1473,7 @@ static int psp_hdcp_init_shared_buf(struct 
> psp_context *psp)
> 
> static int psp_hdcp_load(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                /*
> 
>                * TODO: bypass the loading in sriov for now
> 
> @@ -1522,10 +1481,6 @@ static int psp_hdcp_load(struct psp_context *psp)
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_copy_fw(psp, psp->ta_hdcp_start_addr,
> 
>                                  psp->ta_hdcp_ucode_size);
> 
> @@ -1543,8 +1498,6 @@ static int psp_hdcp_load(struct psp_context *psp)
> 
>                              mutex_init(&psp->hdcp_context.mutex);
> 
>               }
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> static int psp_hdcp_initialize(struct psp_context *psp)
> 
> @@ -1579,7 +1532,7 @@ static int psp_hdcp_initialize(struct psp_context 
> *psp)
> 
> static int psp_hdcp_unload(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                /*
> 
>                * TODO: bypass the unloading in sriov for now
> 
> @@ -1587,16 +1540,10 @@ static int psp_hdcp_unload(struct psp_context *psp)
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_prep_ta_unload_cmd_buf(cmd, psp->hdcp_context.session_id);
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd, 
> psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> @@ -1665,7 +1612,7 @@ static int psp_dtm_init_shared_buf(struct 
> psp_context *psp)
> 
> static int psp_dtm_load(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                /*
> 
>                * TODO: bypass the loading in sriov for now
> 
> @@ -1673,10 +1620,6 @@ static int psp_dtm_load(struct psp_context *psp)
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_copy_fw(psp, psp->ta_dtm_start_addr, 
> psp->ta_dtm_ucode_size);
> 
>                psp_prep_ta_load_cmd_buf(cmd,
> 
> @@ -1693,8 +1636,6 @@ static int psp_dtm_load(struct psp_context *psp)
> 
>                              mutex_init(&psp->dtm_context.mutex);
> 
>               }
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> @@ -1730,7 +1671,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
> 
> static int psp_dtm_unload(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                /*
> 
>                * TODO: bypass the unloading in sriov for now
> 
> @@ -1738,16 +1679,10 @@ static int psp_dtm_unload(struct psp_context *psp)
> 
>               if (amdgpu_sriov_vf(psp->adev))
> 
>                              return 0;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               psp_prep_ta_unload_cmd_buf(cmd, psp->dtm_context.session_id);
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd, 
> psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> @@ -1816,11 +1751,7 @@ static int psp_rap_init_shared_buf(struct 
> psp_context *psp)
> 
> static int psp_rap_load(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> -
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                psp_copy_fw(psp, psp->ta_rap_start_addr, 
> psp->ta_rap_ucode_size);
> 
> @@ -1838,26 +1769,18 @@ static int psp_rap_load(struct psp_context *psp)
> 
>                              mutex_init(&psp->rap_context.mutex);
> 
>               }
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
>   static int psp_rap_unload(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> -
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                psp_prep_ta_unload_cmd_buf(cmd, psp->rap_context.session_id);
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd, 
> psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> @@ -1982,11 +1905,7 @@ static int 
> psp_securedisplay_init_shared_buf(struct psp_context *psp)
> 
> static int psp_securedisplay_load(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> -
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> 
>               memcpy(psp->fw_pri_buf, psp->ta_securedisplay_start_addr, 
> psp->ta_securedisplay_ucode_size);
> 
> @@ -2007,25 +1926,18 @@ static int psp_securedisplay_load(struct 
> psp_context *psp)
> 
>               mutex_init(&psp->securedisplay_context.mutex);
> 
>   failed:
> 
> -             kfree(cmd);
> 
>               return ret;
> 
> }
> 
>   static int psp_securedisplay_unload(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> -
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
>                psp_prep_ta_unload_cmd_buf(cmd, 
> psp->securedisplay_context.session_id);
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd, 
> psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> -
> 
>               return ret;
> 
> }
> 
> @@ -2552,10 +2464,6 @@ static int psp_load_fw(struct amdgpu_device *adev)
> 
>                              goto skip_memalloc;
> 
>               }
> 
> -             psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), 
> GFP_KERNEL);
> 
> -             if (!psp->cmd)
> 
> -                           return -ENOMEM;
> 
> -
> 
>               if (amdgpu_sriov_vf(adev)) {
> 
>                              ret = amdgpu_bo_create_kernel(adev, 
> PSP_1_MEG, PSP_1_MEG,
> 
>                                                                         
>                AMDGPU_GEM_DOMAIN_VRAM,
> 
> @@ -2709,9 +2617,6 @@ static int psp_hw_fini(void *handle)
> 
>               amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> 
>                                                  (void 
> **)&psp->cmd_buf_mem);
> 
> -             kfree(psp->cmd);
> 
> -             psp->cmd = NULL;
> 
> -
> 
>               return 0;
> 
> }
> 
> @@ -2875,17 +2780,15 @@ int psp_gpu_reset(struct amdgpu_device *adev)
> 
> int psp_rlc_autoload_start(struct psp_context *psp)
> 
> {
> 
>               int ret;
> 
> -             struct psp_gfx_cmd_resp *cmd;
> 
> +            struct psp_gfx_cmd_resp *cmd = psp->cmd;
> 
> -             cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
> 
> -             if (!cmd)
> 
> -                           return -ENOMEM;
> 
> +            memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
> 
>                cmd->cmd_id = GFX_CMD_ID_AUTOLOAD_RLC;
> 
>                ret = psp_cmd_submit_buf(psp, NULL, cmd,
> 
>                                                           
>   psp->fence_buf_mc_addr);
> 
> -             kfree(cmd);
> 
> +
> 
>               return ret;
> 
> }
> 
> -- 
> 
> 2.17.1
> 
> Thanks,
> 
> Candice
> 
