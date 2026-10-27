Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62B7606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yjVxuMO9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439CA10E2FE;
	Tue, 27 Oct 2026 21:06:47 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1196310E2FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 21:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3kfxoRtLGLY1GWLcAlwBdMy1s2o4g1TjbOZZgv59s4FGYD8mll0ofH/UBs1F3Fgs3wkfobjwbx/XezY33yKs+EHCEV4P8iwdcEArPsRkTvMVmYjZqnUDO64KdA2RrpHqH7HJCxcz+6BmkOEgRwZGJ9hSExmKgfydhH3gjfOfGoEwacf4l5Ct7tJwnsyyyfQhZARJ+eP7Y0Z1RgEQvSYq9StZ767fsExw8N2IHv2wAcaqlus6fRYgfwWdOpZaPx2IIv4+Riwvu4/duY9GJ0ojA2qJPdKj92HnnOqy2ZFJBgz0Y72XiPIvSw2OjN3ZUmboaODjFoz61zjzzuDpyjebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JObAkKR4xKnPdYCeDWRx1xWA7wZt0v3YqfXAVNBykb8=;
 b=CtbcDzYLYvdlGPfs0atnZZ8Bv/E7DrYeoZ9ZdiXndCtJXNitYjcSz/DoGu95hLjeoQ77h4NzNjZjAsWHDUY36we55jj+EWKYpIVyC8BJUU7tg9g9xaS9aEs/6dPkBqFyVJPM1lfzL+j8iRoa0TrKux/oURKE/8q/yVib7Flu0j2TMAInZ++cF1KLDxxVLDN2mCoagvnqvQK3VaO9vqnohULxhAIWZsle7lF2p15D5krs7hZGDHY5qdkNZ7Vgh2uP5VPYEFuISbA4UgzzuMiNINKx8spkoW94oyO7YCcOzhp+5+FZv/jsEBrSeED5pK80Ef3nQfnxOCuqFr4hnu0C/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JObAkKR4xKnPdYCeDWRx1xWA7wZt0v3YqfXAVNBykb8=;
 b=yjVxuMO9RtAJkEdT7PafzX39ZNWaMvhWOaatw3Ugttq84m8a8htUsbgCVQc1d6libafJtF7Ym53Iqm/TVXVHFE4H4fP8XvNgtzvD2wc4fMrOaefuqIm5MfxaQhwrG0GRgB2vVZ0vmV7gwh642DgtFgGumxvM5FbSGlSI4u6UhYc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS4PR12MB9772.namprd12.prod.outlook.com
 (2603:10b6:8:2a6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:06:39 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:06:38 +0000
Content-Type: multipart/alternative;
 boundary="------------RQrVi6Epc0ULnLPkkhKi4pP0"
Message-ID: <0d61c4d6-a150-46f5-9d8c-302dd8ee45ae@amd.com>
Date: Tue, 27 Oct 2026 17:06:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 7/8] drm/amdgpu: Reject config updates in UALink
 loopback mode
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-8-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027195913.1794477-8-mukul.joshi@amd.com>
X-ClientProxiedBy: YT4PR01CA0380.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::18) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a8c326-d759-4a9a-fae9-08df346e313c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261026121527099003|4143699003|11063799006|56012099006|261022113327099003|261021135927099003|261021121427099003|261021123027099003|261022105027099003|261022115727099003|261022075727099003|261021130227099003|261009223027099003|10067099003|8096899003|18002099003|22082099003|6133799003|261026140227099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: F1EfFvO+ishv2I4oVkMIbsiBHq7ysEOMdYJpI8Oru8rWwrxodTVlhNoh/VuCKAMlrJzhYXiyR/moDyoH4FrqM7XE58Gxks8VzOdhaQigY35xYaY8tVhp8vCzAiTMHWVY/tkGqsMHixM+LEHGvZn6VD7H1UzsdY74M4N7EjtUro+FsgrFvlNPajmDhLjwSJqNXCrUBhvF9xtFZ8ilxfvHbpFuJLgZggsi3oocHONK6tNu+/8pEDayFRe4CBKE5IURyQKYr9gZ7vt8j5LJEVeFnZz6kI4sgKMXVtYgobEVuSZmXK4mnewrgnrdpy9gy3uNIKvseHIrBKdVkMbWb2NLY4HgzSuMCJVsB6p+Fq5N338qAaAdhtjSsDUoHNNGGwq0pgJylWpKa/8PpN2s0FU0ieu/BgJLM+hCv1iRwrWscK0q8HSCaup48fxNC0w4C0IjT8TALV/aOyaotif2M7B8YHQvR4NnVB5nuQNwkFtydvwo/qsxAkE1KRN/W/z6p51zQeNYixQNcqdbQu43+nY9NzzqKCmykwtD1H1PSMdw8b1l8tVpHLtjAbAiwZs7hu1FaYRYs6S4jhTZGcQZ5pLtT9W8tB8+FOGPBt5Ofr/AOOciMEY34TGd+wGG8zRcds7txEcdQVWS/2bbyWAv5FLe07fl7IqVWDlJz/K45e+stjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026121527099003)(4143699003)(11063799006)(56012099006)(261022113327099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021130227099003)(261009223027099003)(10067099003)(8096899003)(18002099003)(22082099003)(6133799003)(261026140227099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVljTWY2RUNUOEVEZzVnN01mbFBRUVlUWjZoL2gyNk9qMitucEh3T1lyUXpP?=
 =?utf-8?B?OExmNVRmSk9xeDRXZnZNajI0aE9id0VaQy8rOEdHYXlpWlY5Kzg5RTBvZzBI?=
 =?utf-8?B?alVCbWdiaDR2andOTzFxQy9uenpVNk9oL1UrTldhZ00zdjRqTjhpMHozc1ov?=
 =?utf-8?B?S0JDeE1LYXdFeU4xdTV2V0pkektmY1NmdEtjQXdaSTBHempsdmx5YUF5MjBY?=
 =?utf-8?B?L1M1MmVnN0k5L1VUQy9uN0toeTFhNE9UY05zajhLN0FRalpTVVlEN1BUQ1J1?=
 =?utf-8?B?MEtQUWQyczdZbXRXNkkwMTF5akxndTZ6Z0RmVWhaRUlHQmQzdWlaMk1wZDFG?=
 =?utf-8?B?RWEvd1VjcjZkM0YvQzZMcHpBT0dUTjdBTm15U3NNazFhMDBiL3MyMDJscmx3?=
 =?utf-8?B?ZElLd1h6Sko3QzJwQVpLMzAvdUNLeis0NGVJdTAwOHdpSjgzL2l4YUxIMFhu?=
 =?utf-8?B?U09mclhrVi9MSDY2Rml1N2R1TWliaWlkdm5OazM1VHNEcHp6cmFCejQ3SE5x?=
 =?utf-8?B?NTJ2RU5yRUpLUFAxcHNBNUlTREx4cWtBS2dZNzRHbjBhcnpiU0NxRWU0V3NQ?=
 =?utf-8?B?aU9wZ3JzbFM5WFhSb1JROU9jUFRGR3hHUjhlUnNYQVNiMnQrVUJaMkpBSVhY?=
 =?utf-8?B?RGw2MUJiSlRGREdsZEpYQ0VpR1AydDdYWWlKajh3cDEvN1pkR3VXd0UrRmNQ?=
 =?utf-8?B?eldrSTA5Z2xCM3N0c05SWjd6d00ybnpiVFZyNGtDUG84QWM4ZGNkRlhKdVNs?=
 =?utf-8?B?QVo5WkdZeU53ekVSN1doQTlrUE9HeVp4WVVZT1JjMDVnSnBjM3NiamhkNkpT?=
 =?utf-8?B?VzlVOFI5V1pXemlTRlZKRjlDcHpTWWZ3UU5kZnZjQjdIcUVYZ25jbUo2RkNC?=
 =?utf-8?B?N0ZzZGRXRmpGT3p5MDBSV09JY0lOUHVGUWpKMWZYRm5DY0ZDaVlOSE9JRHRj?=
 =?utf-8?B?cElQNklJeGJpbGtGS1FCd0xSajFmOGY5cEEwNU81cjErWGg4dENya2FqYWN3?=
 =?utf-8?B?dGxNNVJkOFNzYk54cytYd2dKVkZtNVVCZ2JQWmFPYjdKdkxKQlVCcWVram13?=
 =?utf-8?B?T3ZwdFByWXlNNkx0MUhUelkwejFGMHBnWGZoQ0VhRlEvdGErWGpldEpWejRT?=
 =?utf-8?B?c2tTMkZkY2szMDd2RzYxTXVnalpwaFEyZHVyVGE3anBYQnZCdWpXODJDRVo2?=
 =?utf-8?B?VnNIQXA1WFd4ZlkyejlhMTE3L2xYaTV3c0t0aURINUVBcEZNMm1ySnBCczZv?=
 =?utf-8?B?UjNzVFp6RGJIMGVFMFQ3NnNhYTN6Wkg0WDVqT0g0cDBQbnNyTklUUjJ1Y1d4?=
 =?utf-8?B?YzBIS25qZ0h1ekVMUXBzMm54SnFyL0hCSmhHVzlxWURhNFR1N28wbXAxbXVE?=
 =?utf-8?B?ZGRXTEh5bnM3UkJhbWtTd1BpSm56QU9GQld3VzNXcGhyZ280cHR3aGtGenZk?=
 =?utf-8?B?VUJHS0ZSejNuSy9PR3ovUEFRa2RJd0gxOEVFdmxrbmdvblZSRGFzbXJGd1VX?=
 =?utf-8?B?RW1lNXl1NWpsckx3SUlPYUs5dFFBR0xLVXl1VFV3K0xZZUN6RFd4WE90UHJ4?=
 =?utf-8?B?WWJoQzJDeVlzZXd2RUozMzg3L0x5UDNqWUUyM0NEWGhlWHFEdVpnMGRPNnBS?=
 =?utf-8?B?ellHY0d2Sml0VTNENWJHNFBUcGw3a3BUNExWVS9UWUYyMW13Y01QSVoxS2Yw?=
 =?utf-8?B?MkZXcTN3Yi9VTVhoN3NKWHJGcUZaQVlnZGEwb0x4WE1WbTBoSXU4cWVkcGEx?=
 =?utf-8?B?akhlRU5qR2RaUWNHVUdHdGwwVGFSeWQzckloZW53YktpaEg0UGtHN09iRnNN?=
 =?utf-8?B?YldmQnBSeFlZU1NIZWRad3dpQUtNMEt0STlOcFZNSHRrd1I1ZC9QeU9SN3Zu?=
 =?utf-8?B?WFZTOFoxTlJMb0UzVSt3cjl6UGo0NFNpbDBZSHNGVlJBWGlUY1BGTDQvS0hq?=
 =?utf-8?B?ZWxPVGtTcG81WTZFMmVNMVZ3bEVpZVRROVdRc29SQXlRSDFuODVJa0YxM0t0?=
 =?utf-8?B?QXBtRW4wQkFXSTM2eUxRZVpRcFRsai92eTdpVnhYR1BmNFQvRzRVUGJic1g1?=
 =?utf-8?B?S3JBcmI1M3VuRFcwbXRmUkNrV2MrOXdsNXhiUWFOM2F2bHFJNm5CVkNLYzlG?=
 =?utf-8?B?cFlQRG9NRmM0WWExdGJvMlpYd2FCK3VlemFqcGswYjdYZ2VUSkx6SnF6c3Uy?=
 =?utf-8?B?WG1Ga21mdUxmSTA5bi95RjYyRytVSzVxTjJDMDRMNzNSZGJ0Y2VpOGpyWlJn?=
 =?utf-8?B?eGUxWW5tVnFGQmdHK1dXUjNHWFN5Mk40ekZNYklHZ00wNXpwTi9URTlMWS9o?=
 =?utf-8?B?bHIyL2lXUDFhOGIvRGJzczV5TXZmZUt0OHh0TW16RGlvQ3VocXJxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a8c326-d759-4a9a-fae9-08df346e313c
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:06:38.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyzaJMoi755KZnM4pisXX5oGPtHvcvwIGfzQf5FwVHkA+c2PYxfVad/qFPaDlay6aVpFpnif+efQZo38KHrVuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------RQrVi6Epc0ULnLPkkhKi4pP0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-10-27 15:54, Mukul Joshi wrote:
> In loopback mode the driver synthesizes the pPod/vPod configuration,
> since there is no user-space agent to configure the pod. Keep anything
> else from overwriting it:
>
> - Ignore PSP config update interrupts. Re-querying the configuration
>    from PSP would replace the synthesized one. Still send the completion
>    so PSP is not left waiting.
>
> - Don't create the pPod setup, vPod config and station config sysfs
>    nodes, so the configuration can't be committed from user space. The
>    setup, config and stations directories are still created, empty, as
>    they are when the config sysfs nodes are compiled out.
>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
> v1->v2:
> - Do not create the config directory in sysfs under loopback mode.(Lijo)
>   
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 49 ++++++++++++----------
>   1 file changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 14b9c05a0f0f..1c2203ff175d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -486,6 +486,18 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
>   			PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, status);
>   	}
>   
> +	/* The loopback pod configuration is synthesized by the driver, so
> +	 * re-querying it from PSP would overwrite it.
> +	 */
> +	if (adev->ualink.loopback.enabled) {
> +		dev_warn(adev->dev,
> +			 "UALINK: config update ignored in loopback mode\n");
> +		return psp_ual_send_completion(&adev->psp,
> +					       adev->ualink.psp_if_ver,
> +					       PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID,
> +					       0);
> +	}
> +
>   	prev_state = adev->ualink.info->accel_state;
>   	prev_vpod_id = adev->ualink.info->vpod.id;
>   
> @@ -1779,7 +1791,7 @@ static int ualink_kobj_add(struct kobject *kobj, struct kobject *parent,
>   	int r;
>   
>   	r = kobject_add(kobj, parent, "%s", name);
> -	if (r)
> +	if (r || !attrs)
>   		return r;
>   	r = sysfs_create_files(kobj, attrs);
>   	if (r)
> @@ -1794,48 +1806,43 @@ static void amdgpu_ualink_xcp_sysfs_fini(struct amdgpu_device *adev);
>   int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_info *info = adev->ualink.info;
> +	const struct attribute **setup_attrs = NULL;
> +	const struct attribute **config_attrs = NULL;
> +	const struct attribute **station_attrs = NULL;
>   	int r;
>   
>   	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE)
>   		return 0;
>   
> +#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
> +	/* The loopback pod configuration is synthesized by the driver. */
> +	if (!adev->ualink.loopback.enabled) {
> +		setup_attrs = ualink_ppod_setup_attrs;
> +		config_attrs = ualink_vpod_config_attrs;
> +		station_attrs = ualink_station_config_attrs;
> +	}
> +#endif
> +
>   	/* ualink parent node */
>   	r = ualink_kobj_add(&info->kobj, &adev->dev->kobj, "ualink",
>   			    ualink_info_attrs);
>   	if (r)
>   		goto err;
>   
> -#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS

I'd prefer to keep this #ifdef and a clean separation so we only ever 
call ualink_kobj_add for the subdirectories when DEPRECATED_CONFIG_SYSFS 
is enabled. I don't want the deprecated APIs to be exposed accidentally 
by some future change.

Maybe you can leverage the #else branch for loopback. Something like this:

#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
	if (!adev->ualink.loopback.enabled) {
	        r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj, "setup",
         	                    ualink_ppod_setup_attrs);
	        if (r)
         	        goto err_info;

	        r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj, "config",
         	                    ualink_vpod_config_attrs);
	        if (r)
         	        goto err_setup;

	        r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
         	                    "stations", ualink_station_config_attrs);
	        if (r)
         	        goto err_config;
	} else
#endif
	{
	        r = kobject_add(&adev->ualink.setup->kobj, &info->kobj, "%s",
         	                "setup");
	        if (r)
         	        goto err_info;

	        r = kobject_add(&adev->ualink.config->kobj, &info->kobj, "%s",
         	                "config");
	        if (r)
         	        goto err_setup;

	        r = kobject_add(&adev->ualink.stations->kobj, &info->kobj, "%s",
         	                "stations");
	        if (r)
         	        goto err_config;
	}

Regards,
   Felix

>   	r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj, "setup",
> -			    ualink_ppod_setup_attrs);
> +			    setup_attrs);
>   	if (r)
>   		goto err_info;
>   
>   	r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj, "config",
> -			    ualink_vpod_config_attrs);
> +			    config_attrs);
>   	if (r)
>   		goto err_setup;
>   
>   	r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
> -			    "stations", ualink_station_config_attrs);
> -	if (r)
> -		goto err_config;
> -#else
> -	r = kobject_add(&adev->ualink.setup->kobj, &info->kobj, "%s",
> -			"setup");
> -	if (r)
> -		goto err_info;
> -
> -	r = kobject_add(&adev->ualink.config->kobj, &info->kobj, "%s",
> -			"config");
> -	if (r)
> -		goto err_setup;
> -
> -	r = kobject_add(&adev->ualink.stations->kobj, &info->kobj, "%s",
> -			"stations");
> +			    "stations", station_attrs);
>   	if (r)
>   		goto err_config;
> -#endif
>   
>   	amdgpu_ualink_xcp_sysfs_init(adev);
>   	adev->ualink.sysfs_init = true;
--------------RQrVi6Epc0ULnLPkkhKi4pP0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-10-27 15:54, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261027195913.1794477-8-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">In loopback mode the driver synthesizes the pPod/vPod configuration,
since there is no user-space agent to configure the pod. Keep anything
else from overwriting it:

- Ignore PSP config update interrupts. Re-querying the configuration
  from PSP would replace the synthesized one. Still send the completion
  so PSP is not left waiting.

- Don't create the pPod setup, vPod config and station config sysfs
  nodes, so the configuration can't be committed from user space. The
  setup, config and stations directories are still created, empty, as
  they are when the config sysfs nodes are compiled out.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
v1-&gt;v2:
- Do not create the config directory in sysfs under loopback mode.(Lijo)
 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 49 ++++++++++++----------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 14b9c05a0f0f..1c2203ff175d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -486,6 +486,18 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
 			PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, status);
 	}
 
+	/* The loopback pod configuration is synthesized by the driver, so
+	 * re-querying it from PSP would overwrite it.
+	 */
+	if (adev-&gt;ualink.loopback.enabled) {
+		dev_warn(adev-&gt;dev,
+			 &quot;UALINK: config update ignored in loopback mode\n&quot;);
+		return psp_ual_send_completion(&amp;adev-&gt;psp,
+					       adev-&gt;ualink.psp_if_ver,
+					       PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID,
+					       0);
+	}
+
 	prev_state = adev-&gt;ualink.info-&gt;accel_state;
 	prev_vpod_id = adev-&gt;ualink.info-&gt;vpod.id;
 
@@ -1779,7 +1791,7 @@ static int ualink_kobj_add(struct kobject *kobj, struct kobject *parent,
 	int r;
 
 	r = kobject_add(kobj, parent, &quot;%s&quot;, name);
-	if (r)
+	if (r || !attrs)
 		return r;
 	r = sysfs_create_files(kobj, attrs);
 	if (r)
@@ -1794,48 +1806,43 @@ static void amdgpu_ualink_xcp_sysfs_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_info *info = adev-&gt;ualink.info;
+	const struct attribute **setup_attrs = NULL;
+	const struct attribute **config_attrs = NULL;
+	const struct attribute **station_attrs = NULL;
 	int r;
 
 	if (adev-&gt;ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE)
 		return 0;
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+	/* The loopback pod configuration is synthesized by the driver. */
+	if (!adev-&gt;ualink.loopback.enabled) {
+		setup_attrs = ualink_ppod_setup_attrs;
+		config_attrs = ualink_vpod_config_attrs;
+		station_attrs = ualink_station_config_attrs;
+	}
+#endif
+
 	/* ualink parent node */
 	r = ualink_kobj_add(&amp;info-&gt;kobj, &amp;adev-&gt;dev-&gt;kobj, &quot;ualink&quot;,
 			    ualink_info_attrs);
 	if (r)
 		goto err;
 
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS</pre>
    </blockquote>
    <p>I'd prefer to keep this #ifdef and a clean separation so we only
      ever call ualink_kobj_add for the subdirectories when
      DEPRECATED_CONFIG_SYSFS is enabled. I don't want the deprecated
      APIs to be exposed accidentally by some future change.</p>
    <p>Maybe you can leverage the #else branch for loopback. Something
      like this:</p>
    <pre>#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
	if (!adev-&gt;ualink.loopback.enabled) {
	        r = ualink_kobj_add(&amp;adev-&gt;ualink.setup-&gt;kobj, &amp;info-&gt;kobj, &quot;setup&quot;,
        	                    ualink_ppod_setup_attrs);
	        if (r)
        	        goto err_info;

	        r = ualink_kobj_add(&amp;adev-&gt;ualink.config-&gt;kobj, &amp;info-&gt;kobj, &quot;config&quot;,
        	                    ualink_vpod_config_attrs);
	        if (r)
        	        goto err_setup;

	        r = ualink_kobj_add(&amp;adev-&gt;ualink.stations-&gt;kobj, &amp;info-&gt;kobj,
        	                    &quot;stations&quot;, ualink_station_config_attrs);
	        if (r)
        	        goto err_config;
	} else
#endif
	{
	        r = kobject_add(&amp;adev-&gt;ualink.setup-&gt;kobj, &amp;info-&gt;kobj, &quot;%s&quot;,
        	                &quot;setup&quot;);
	        if (r)
        	        goto err_info;

	        r = kobject_add(&amp;adev-&gt;ualink.config-&gt;kobj, &amp;info-&gt;kobj, &quot;%s&quot;,
        	                &quot;config&quot;);
	        if (r)
        	        goto err_setup;

	        r = kobject_add(&amp;adev-&gt;ualink.stations-&gt;kobj, &amp;info-&gt;kobj, &quot;%s&quot;,
        	                &quot;stations&quot;);
	        if (r)
        	        goto err_config;
	}</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <pre>
</pre>
    <blockquote type="cite" cite="mid:20261027195913.1794477-8-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	r = ualink_kobj_add(&amp;adev-&gt;ualink.setup-&gt;kobj, &amp;info-&gt;kobj, &quot;setup&quot;,
-			    ualink_ppod_setup_attrs);
+			    setup_attrs);
 	if (r)
 		goto err_info;
 
 	r = ualink_kobj_add(&amp;adev-&gt;ualink.config-&gt;kobj, &amp;info-&gt;kobj, &quot;config&quot;,
-			    ualink_vpod_config_attrs);
+			    config_attrs);
 	if (r)
 		goto err_setup;
 
 	r = ualink_kobj_add(&amp;adev-&gt;ualink.stations-&gt;kobj, &amp;info-&gt;kobj,
-			    &quot;stations&quot;, ualink_station_config_attrs);
-	if (r)
-		goto err_config;
-#else
-	r = kobject_add(&amp;adev-&gt;ualink.setup-&gt;kobj, &amp;info-&gt;kobj, &quot;%s&quot;,
-			&quot;setup&quot;);
-	if (r)
-		goto err_info;
-
-	r = kobject_add(&amp;adev-&gt;ualink.config-&gt;kobj, &amp;info-&gt;kobj, &quot;%s&quot;,
-			&quot;config&quot;);
-	if (r)
-		goto err_setup;
-
-	r = kobject_add(&amp;adev-&gt;ualink.stations-&gt;kobj, &amp;info-&gt;kobj, &quot;%s&quot;,
-			&quot;stations&quot;);
+			    &quot;stations&quot;, station_attrs);
 	if (r)
 		goto err_config;
-#endif
 
 	amdgpu_ualink_xcp_sysfs_init(adev);
 	adev-&gt;ualink.sysfs_init = true;
</pre>
    </blockquote>
  </body>
</html>

--------------RQrVi6Epc0ULnLPkkhKi4pP0--
