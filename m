Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB97DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 10:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E17613AC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 10:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A9E17613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42ED16E9F1;
	Tue, 16 Nov 2021 10:40:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851A86E958
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 10:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGsM3uvUyv9FDhVvsmwF9MFd/Snw0Lbi99MYz1NkLU5wRUN48lZMoRLT3OmWfVJICGrmglgzFDPfCvslGRs0N3dZxuygWAcInIQtpyCN/zMSONHoMMpPDqPenYjDTXBySGWpSpCMddCvH5nmpHt8+WItZTzmUuAaFY5QxFxKI3cHqrQLdU1K8L+nUQeVqvKAVco4l48Z96IW3MRT4cqNP/uZawlwyagQ24dDyW9QdAQUAvVAdD/UXpPcKvtOqUUNvMNrdc2nHWDfyAAQaJcvQXtI9+TvV8E75Wc0Uakg+nSsL/mbAKq8JYbmThg+zKMFesah2jKZnZgRD9+onVwu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndC58mX/LTeNwPv5QCUT+RWXbqnUHC2dTmL3drnKEtw=;
 b=LmVwVIHqZpqp49wrAjc5qlm3z3AFK7IPgJjZ6WWH4EJCIw0BKo9Tr0bt7mVoWW34ptY4nPAIUkEoBCYrDYkQos1Y/kAKZ0Fqn/q8uacS5U9u/cfl6q3mO/dvFBQt4hX08sunEZ06PNXYt6YJV4Wn+PfarXsposgphFoF6ZnIHIsq/1QrPESmO/sZ0UngMUHbaWfDYQoWFJnnW0TEiZDqXvdR92iK1/1mNQsIKdeFL+8GbHdovKhdKA+a54S+j/1/dT7bG51Gyggsfk5h4wLzSanmmNS/u8iuoFAQdphyLd9oAEhEh2Ij1QEtFoP1HbSfr3KneBoTP0PONG2zaqNRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndC58mX/LTeNwPv5QCUT+RWXbqnUHC2dTmL3drnKEtw=;
 b=AL/rvzJ1fJtFIDc2ZMUuqlV/nQK7Mb/ZSIlMcNMwGXpc7Kt4odsu9IoheyMKi7eDIL1kmWIRO1nDtGKpES3nq1qzUF0fU9FIAzeDqLNFtsaJ6UttV3R9joveMHiyy7YnekaAV47Gykx9aSCTLNCme+QFqAeZy+NfKFNg8BygYjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 10:40:52 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 10:40:52 +0000
Message-ID: <952fb07c-6215-5485-6ac1-a00c1429ba3c@amd.com>
Date: Tue, 16 Nov 2021 16:10:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, john.clements@amd.com, stanley.yang@amd.com,
 equan@amd.com, KevinYang.Wang@amd.com
References: <20211116102855.3775-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211116102855.3775-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 10:40:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 518e9582-8d82-4544-14d0-08d9a8ed8f6d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:
X-Microsoft-Antispam-PRVS: <DM5PR12MB258450011F75FC1F8C79049597999@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGPsm6L0k8WaxYV7GMdK9Xz14D+cWexGOP2cev3xk46tBZXi9N1XhtOi29E1IXwWM27jyJGodkk0XOJCarSR0Pxu3FU2US7R+3nf0myoVhcRGG5KoCpVUQ9Gjz49o4TYZ6lP8RjZ62x0qeoi88ntEw6R++mfnEPzT1JU3CpZXucJTTCf0yMyGWMYI2/bJ62+MaJv/z/25yeKuTWSV9J9pcoNMIJyvDthQr3BrnVkcYTQe+RfXh0TsVHKSZUGmHM7nLCnXH1/qs6yN4bCEQFcYYJe5GZIZze0HhVKLo+kXKAqYFMAGfOu6KeU/OAUEvchUhkwJT4gJzukSSg0lUu9tDUpePlrRY4ZnqP2whc61BQo9Xq4HI/eh/DWcMRpPgPsQjOSIGzDrJVhkZIyzwAzOgSNLNj5EGgk991PEW5e+S7VnPo8YHy8w2N6EZUBk+a4mB/QMbF3A7zHCkaBcl14+FDJ85K2GjreyaY3qV4GT1y9YdPflTc8CBLgSmCo0/UGFIHamONVCDpxciBG0Rth16jYSd6UgtC5HMS+iC8ryVY+Amq/2J+JqNH4oaL7m/RLqb59SaCdGeTsM0pzPfzFVWfDifTbM8jOUqq+T6tizd/Tc9BmusWn7nbe1koOSemP6W5c2VPE+CZVNU0y3hN1mvc/0N23N0LI4hsx1ktE5TtqvYSruRpBpzYL2ucso4sRZfs8qXAesp0uQQQLxYkaDSl39KEFvwVYzZWePKRxBdrcBEGbibN0Oc6AnLKCHawi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(2616005)(83380400001)(31696002)(956004)(26005)(6666004)(6486002)(8936002)(36756003)(316002)(16576012)(8676002)(66476007)(66556008)(38100700002)(66946007)(6636002)(53546011)(186003)(31686004)(508600001)(5660300002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njc0Ukp5RDV0NUZhdU05em05OGZwRll6Z3RTVTU3YURhTGRVWER1VDlhUFhp?=
 =?utf-8?B?eG16TGd3UVZZYnJlRXdlbEhHbU5RVVBBVDBTTEVZZDhodThXNTAvUmdIczEy?=
 =?utf-8?B?dVEzR3dJT1BOV3MyVlhJWE11ZEZtQUYvcUJlaFhUVzhaeFBtMkV0SWhpSTMy?=
 =?utf-8?B?TTc3a0dzeWxrMStHRFA5TS9rMElSb2ZPR0lYNXJkQnVxOWkwK2c0QnV0bGNX?=
 =?utf-8?B?N1l0b3RnM1pTajZidFZnYTZJbk9BcmV1b3VyOUxCa284V2lVREdqbWxYUkRJ?=
 =?utf-8?B?c1Q2QXhKeGVZd3BDQllodXhwZjBTdDNlV0RyeEF5Nk1xell0d0FlZzZXUFBI?=
 =?utf-8?B?eTkvRTJ3KzNuRzR1c004d1BYSGFiNk5PT0ZSM093RFFYZ01YbkdVbnEyNlRo?=
 =?utf-8?B?K3ZFcUtEdGVvTkhoYVUzNjY3bHlTTHNKRnNjZngwaUFKajlJUVJScXZlZUly?=
 =?utf-8?B?OWQ4Wnk0NDRPdTc4SmxjcHFaQU16cldHYnZYUXMvUGdJY1k0RHBvSDhrRVp3?=
 =?utf-8?B?SC9ZMHhqT1M4ODFOdzdVY2Nic2NsSndMMm0yNEdUemZ3SnZYaWlkL0FEWGVS?=
 =?utf-8?B?ZEFtQ2dqSE5ja2hiZmpWWkorYTlBaVg5c3lqRE1XTVJwbnlaWGFGeWlaeUF5?=
 =?utf-8?B?NWE1V2wrTXRpa0tVWFNJb21nWE1Sb1JwejAyaVF1emFEL3BUTlVVTThWeW5N?=
 =?utf-8?B?dkFuM0lqdUVSR0wxOFFDbSsyRzBiZXFEUDBCSkJOZ3pzNERuV0VPMWFxMStm?=
 =?utf-8?B?UmlkempvREk5NHZwYW9ZNERHeHN3Y3I3cTFGQTZWb2M4amprMDZFVjdMM2M0?=
 =?utf-8?B?K1lCR1BERml1cXJtb0NtTDlZZ1FFanBjZzdselhwTkJNTE02cHd0aGlpZUNI?=
 =?utf-8?B?Vnl0K3Rvb2x2TDJIM3dkVUMySVRqZVNrYmZwMEtkK09hRkVjQWFjRHdyeThC?=
 =?utf-8?B?WXViQU5WVnFxOVR2KzhvK05XNjNPTVlPdit6VTh1N1pkUTk5K2dXQmtSTGN0?=
 =?utf-8?B?TEkyMTdvMWdyRndKbU9MK0pqYWcrWmNvSGZxd3QyZS90a3hjeEJyS0ExbkdL?=
 =?utf-8?B?WnZOcEN2M1hoalBPNjAyU3pWZmhiYk4rNWhIZDU5bEh4WGRUZDJxQkdOZXFK?=
 =?utf-8?B?dEdtTXA1dnNKbEJ3a0U3czF2eC9QZW9wOUYyMktTTnBSRjF0RDlwTXFwNDRJ?=
 =?utf-8?B?UmQyUFVpRjRwM1V2cFdhN2N4MDRhdlVKeXNNTmNpRDdxTjIrQUxiOFBkZTNu?=
 =?utf-8?B?NlF6bTVlSFJOaDlEajc2dzg1YzdLM0g4ZWl1M2E2L0daV3BETTJNM3ZZKzRB?=
 =?utf-8?B?R0ZvOXRrY3pIbWR4bUh3Uy9VUVdyTkR0eWM2VW1pblIxbVk5RlRXSU5XQ3dy?=
 =?utf-8?B?eTZJc2hiK3VXSjRzQkM0N3kzT0JYRk1ZU2g2R1VmK3JvRnViaThkdWlBTUNJ?=
 =?utf-8?B?dkV6Qk9qcVovQU14aW5rcm1neEQweWduSXo0YVRSRm5FbVBJTHNuMXk5QklR?=
 =?utf-8?B?eHYwS0xGZmJzNXJXeVc1NlN2YUZQUmQ3ejEyOGo0RVgvVGJPYmg2T1lYYXJs?=
 =?utf-8?B?Vyt6TlNreTJnS2tpb08wT2xxOG1xbzhvT0ZWTXhZK085T2Z0RzlQdEdid0pP?=
 =?utf-8?B?TjB6SjNpSDlnZUxHelJtbDFNVDU5enc3OEtwb0VaU2tPNy9zaHBRZmJDdkU1?=
 =?utf-8?B?K0pGYU1ZM2tvdEpocFFucFVpaGgzRld2bjVFUFVzUnNsZWQ2cWtoVmRGYVIy?=
 =?utf-8?B?RFY2Snh4SEUyZUtQTTJ1YXFNL3JscU1qbEI1NU5XRVo2SmVrVG9QbmVzTG40?=
 =?utf-8?B?RHcyeHRtRzdPTkhKQUlQMzdNWlU1ZTJkQjhweHFWbm9MWlpnY2QvTnFrWVlT?=
 =?utf-8?B?YjRhMW1xakc3OTc0S0dQcjZjU2ljallXVXk0ODB1Mm9nZ0JHR0tlMVpZUllU?=
 =?utf-8?B?YnplcVNHOE9Bc3RPbWc2R0hLbkpzb1pwY0tTQ2g1OFFWVFJnQ1IyME1ITVFp?=
 =?utf-8?B?aUZ4SkQyWDhmNW5UUkRUb1d2RlQrTXh5VVZ2SXhObFFCdTJvQW93OGQ3Q3I3?=
 =?utf-8?B?TFhEVU5mbjN0aTJtSkg4bTFsK2RIdjNtRDB0aEZjR1dNVmxRdCtUMXh6L1Y3?=
 =?utf-8?Q?i+Cs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518e9582-8d82-4544-14d0-08d9a8ed8f6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 10:40:52.0329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aIDf/YBgS7EBD5wtRfqcn2x46Bizle6nzPZnbFnItDnBtbawkIgKp2C4+EpCF6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
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



On 11/16/2021 3:58 PM, Tao Zhou wrote:
> If gpu reset is triggered by ras fatal error, tell it to smu in mode-1
> reset message.
> 
> v2: move mode-1 reset function to aldebaran_ppt.c since it's aldebaran
> specific currently.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |  3 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 36 ++++++++++++++++++-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 -----------
>   3 files changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> index e5d3b0d1a032..bbc608c990b0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -29,6 +29,8 @@
>   #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
>   #define SMU13_DRIVER_IF_VERSION_ALDE 0x07
>   
> +#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
> +
>   /* MP Apertures */
>   #define MP0_Public			0x03800000
>   #define MP0_SRAM			0x03900000
> @@ -216,7 +218,6 @@ int smu_v13_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
>   int smu_v13_0_baco_enter(struct smu_context *smu);
>   int smu_v13_0_baco_exit(struct smu_context *smu);
>   
> -int smu_v13_0_mode1_reset(struct smu_context *smu);
>   int smu_v13_0_mode2_reset(struct smu_context *smu);
>   
>   int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 59a7d276541d..e50d4491aa96 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1765,6 +1765,40 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
>   	return sizeof(struct gpu_metrics_v1_3);
>   }
>   
> +static int aldebaran_mode1_reset(struct smu_context *smu)
> +{
> +	u32 smu_version, fatal_err, param;
> +	int ret = 0;
> +	struct amdgpu_device *adev = smu->adev;
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +
> +	fatal_err = 0;
> +	param = SMU_RESET_MODE_1;
> +
> +	/*
> +	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
> +	*/
> +	smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +	if (smu_version < 0x00440700)
> +		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
> +	else {
> +		/* fatal error triggered by ras, PMFW supports the flag
> +		   from 68.44.0 */
> +		if ((smu_version >= 0x00442c00) && ras &&
> +		    atomic_read(&ras->in_recovery))
> +			fatal_err = 1;
> +
> +		param |= (fatal_err << 16);
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +					SMU_MSG_GfxDeviceDriverReset, param, NULL);
> +	}
> +
> +	if (!ret)
> +		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> +
> +	return ret;
> +}
> +
>   static int aldebaran_mode2_reset(struct smu_context *smu)
>   {
>   	u32 smu_version;
> @@ -1925,7 +1959,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
>   	.get_gpu_metrics = aldebaran_get_gpu_metrics,
>   	.mode1_reset_is_support = aldebaran_is_mode1_reset_supported,
>   	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
> -	.mode1_reset = smu_v13_0_mode1_reset,
> +	.mode1_reset = aldebaran_mode1_reset,
>   	.set_mp1_state = aldebaran_set_mp1_state,
>   	.mode2_reset = aldebaran_mode2_reset,
>   	.wait_for_event = smu_v13_0_wait_for_event,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 35145db6eedf..4d96099a9bb1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -60,8 +60,6 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
>   
>   #define SMU13_VOLTAGE_SCALE 4
>   
> -#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
> -
>   #define LINK_WIDTH_MAX				6
>   #define LINK_SPEED_MAX				3
>   
> @@ -1424,25 +1422,6 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu)
>   	return ret;
>   }
>   
> -int smu_v13_0_mode1_reset(struct smu_context *smu)
> -{
> -	u32 smu_version;
> -	int ret = 0;
> -	/*
> -	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
> -	*/
> -	smu_cmn_get_smc_version(smu, NULL, &smu_version);
> -	if (smu_version < 0x00440700)
> -		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
> -	else
> -		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_1, NULL);
> -
> -	if (!ret)
> -		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> -
> -	return ret;
> -}
> -
>   static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
>   					     uint64_t event_arg)
>   {
> 
