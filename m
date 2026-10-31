Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05303606A31A
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Oct 2026 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jxCEg+er
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739DE10E901;
	Sat, 31 Oct 2026 01:51:34 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012029.outbound.protection.outlook.com
 [40.93.195.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14FE10E901
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2026 01:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2luS/0qKGYwTaI9psdLRjEN+s+5AVN2fcNJjDM3IvUIKA//AuXt1JBJcwH2olJquLnv4+Fijz0DILXYIMz240mYEaJIAyWp8gRHgzNuQ26EHmZkbaIw2QVVnOOSmvf4rAGep8pgGD8SZ0fa0fVkrRYfwizshDFwSjZQWiev4aS4UhD4/9Dfzc5rMM2xYWudbDxhVgQLV2juLpXiz6BWBeATQngMkTiRhkJIRvhPqZa7IhKm58cfL7iEupi4+TKXQs7rXyLFYjp3T/jeLZvslFtzJNWDODgetksSGPxmfc9Z+MqI/cSCkXchUkelEa2DLKtDVGychgVzwSk1A8+MVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3W7rxLIknfjlc36YOfr3T4Wf8QmxIPywSNj9pfZ2RI=;
 b=Q6Gi6iddhC5ibHniercWtoIkuJfZ6YJVmEpTV5HVtX+44v2X4r4gEvRAwXrt/xR+XLZ3DND1Wi1WrKWe5Nykcr9OhwDz1TkDzGmyw3FSQKt8xVUkx7s7N+OGe4vtVXGNSg/9SgZbWezoSZsIaTyU9TeHUo2tA+det/rsCrnd6tM73o9IzUUIAsfPv2APIYqVI1M//xmmv6o9FSJjtcyseLXt1kkyEGAWaP37AFExZIfdhFqM/ALY1oZNn1vdHIPlUarMC7MBZvGJDzm2I/CnugOLlToGqJx5M+Qu2k/6h6HNA1DSqXQ/zb6QDHNsK/ZVEGfQV4VKM34uP8ObCBinEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3W7rxLIknfjlc36YOfr3T4Wf8QmxIPywSNj9pfZ2RI=;
 b=jxCEg+erTE4bNrhQplXqDlv60nDa5Zzn69jOtWHN04yDL/TRDJwuxLcOhW8/AaIz2l46/XUJ3EoQUFA33e+DOTVpih29dZ30yzUBFVN/JWC/+znH+lcGWT3946sW9/OZhr8oFumMPr/1UPXZU2tUR+/VPIW4tAOLMkSbfd2hG00=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by SJ0PR12MB6990.namprd12.prod.outlook.com
 (2603:10b6:a03:449::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Sat, 31 Oct
 2026 01:51:24 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 01:51:23 +0000
Message-ID: <9bf13eb6-6b56-48dc-a812-cc8574baed2b@amd.com>
Date: Fri, 30 Oct 2026 19:51:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: signal PQ EOTF in FreeSync infopacket
 for DP HDR
To: Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: Xaver Hugl <xaver.hugl@kde.org>, Krunoslav Kovac
 <krunoslav.kovac@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20261021123020.53928-1-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261021123020.53928-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:303:6a::26) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9e8f7e-207c-4f0e-bd9f-08df36f177b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|5023799004|11063799006|261028144727099003|10067099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|56012099006|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: MAa1Lfu4gU4FOzSsMrL+BYU+xk5w6ZTwUHJYm53dBeXCd/+psw1R3KSb1v4FjVexJIVzd+hyeyWEhxJA6s6Cmg/+cmIOIIS9K1ZrPZymM5CY9RAk2kZqV/pNJxhCzoDTJ9s8WTaOuUgOHtXvOEieJD3gcUA7hvn7p0SsTBT7rReLJx88by7LhJyPhXDRNvH3KUEYHUkFtS9i+VNJWoOVjiqOyIcvCd1CcjgwF2loy25oVBSwul96eupob50pcKslHHtort8/xO+CRBlWxgqYTwvr+JpqeuvIS9YuSR/xnw8OeTewIv1TYh9Pd8MQKpaBObA6+sEB/sZL3zWXHwHvmNMQq2Yg+qr6nQSfVNjpvapGsFWQWPF82v/pBznmdZEcWh31iQeDWevlrVi+O0ferFGTK6mq2wfHe+RidaN6BVWSwg5ORLGuHAGs/cBvojDhly/aVND0tv7HCaC+xVC+opOarU28b/G6etKcCGlCo3Lpi7BvuNQE56iOM7xYxdPhdfSNystgJuM0kh59+5L2Gqfa3vqOYqL3MZ6TjpAw5wewsoyP39YSIXNqFhFBD91w4I909qXzqkVltlf4AuW7XCocfryUl2gZo/4hkjmxdWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(5023799004)(11063799006)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdzdzJnQS9LQnE1VnBJTnpISWVJZkd6Q0puNjRRcVFJV1FNSG9pUDFDQjRi?=
 =?utf-8?B?R1RQQ3BUUGhhclVtQ0htdDYvU3ovQjFGbU9nVU9zbW1Uc0ZnWlc1d2Z2YWJh?=
 =?utf-8?B?ZkVYZVJwQTZTN3Avdm54cFBYcWc5TVVENFVoMUErdTY5Z0VCRVBrSUM5UWRC?=
 =?utf-8?B?ZFVyMmNFcnZVQ1hJdGpiS0lhdHFBeWFjRDI4Mng5WGVMR1ZSM2ZjU0UycHBj?=
 =?utf-8?B?QlBwa2JaUjVSbk4wR0xyYnFocE52R0ExbnBmSWNTTTgxSDBsemVSOW1tWWd6?=
 =?utf-8?B?MFNVTlJkdGN0YXFnUGRxeTVYei9RZ2hlNHlDdktYNkFsUld5R0lBTUhWL3lV?=
 =?utf-8?B?WERzK3BJSG9vOVBmeTlIb2hqc2k1MWM3ZkxuV215THg1MXVoakZrQWVlVEhP?=
 =?utf-8?B?RFB5UExvNk54NUJHYTU5b1lLOEovYlppOUYybjc3ZHMzTlpjQm84RFh4RWtC?=
 =?utf-8?B?dVRXemR6a0xoN2UvTm40dlo1NjVjV0d4ZUVNWFU3eGtpUlYrcjNuOWhuL3Ny?=
 =?utf-8?B?VGRjN1htbjZnQzhwWHJvYnNjWER2cEJRZTMzaE9rRHp2TXM3blRxRjFYU1Vi?=
 =?utf-8?B?dmFVUGJhRmdIVzFXUjd1R3ZnVXE3MU5QczVXSUdKbFloNUxmdVRkL1JJakVu?=
 =?utf-8?B?TlMyOTVGeG9OVGtiSUZoaFE1MEZ2Q2FXUzhEemN3SDREQVJmUytnOE4xSGIr?=
 =?utf-8?B?bmNTeEdtWWc2dTFPTXJiUVA2bTJoOXkwczhFV1doelpKUkR4UHdFaHJIcXFm?=
 =?utf-8?B?ME9RUnJrNDlYVzNJekFXUWROTDdDaHZWc0lOT3h2cHJoV2dWU2xySFVrOCtu?=
 =?utf-8?B?dnlXa0V6QTRZSWxua0lhYlBqbk1rek9lanF6SWJ4ZVJTZnZoOWNBV0QyV0hN?=
 =?utf-8?B?Qm1DM1F4TXY4K2creGE4R2h4S2p3aXR0UkFDbWhGR0YwbFYrUUw0YmlJYlhS?=
 =?utf-8?B?Y0xFOE5NQlZKbUVjZStiOHA3V3luWjMxMTBUREw3WlB4ZE8vdHRFZ205Szdy?=
 =?utf-8?B?Ri85eHJhYTFHclQyQ0M1UFR4QzFrNDZySHcyZmVpWXBSTk5tZWxkQ2VlZmp2?=
 =?utf-8?B?aVc5SVkvbjVOelhRVUhQOUkwd09NNDZkQ20yQ2t4QXBCVzB4TDE4ci9jakV1?=
 =?utf-8?B?T21rMWVYaG1ONXRMSUZlU0NiQW9BcEtYTmh1U0ZKQUEyVDRkMVdvdzd6anhu?=
 =?utf-8?B?ZDNXanZBd0hKVFh2Zm5pdFYzNjljYnljQ2pIK2JycUJvNG9ZejNVNjFaN3NZ?=
 =?utf-8?B?akpIZmRpQzl5YlM1TExnTEtNS0RYOHZiMkt3TUF4a3NTNGgva0h4d1p4VnlY?=
 =?utf-8?B?VGZhdllmVHBPWGY5dm11Rmp0NVM3d1IvcUJBWjhmRnI2YXVoWjJoMjBsRHhO?=
 =?utf-8?B?bnJDMlo5emVhN05icVhjc3dtMS9HeXR1QTJDOW4yMWwyMVhaZVNJNkF4b1hh?=
 =?utf-8?B?U2dsRkh5S0Nla0RJMWVjamxmTDRKS2pBNTE0elNiSGEwaVRhandiYU5abnZj?=
 =?utf-8?B?SWYyRmxSaVUzWEcwdHlqVURSTHlGQTN5bDBWOGFyQjF0T1NqMUYrbFhNNGly?=
 =?utf-8?B?Tm9tblVhMjUraG82WVU4bThsSXFvUExjRVdwL1RlcmxZbmJLdzVXNFF4dU1m?=
 =?utf-8?B?VzNuUFNnenFyRXcyZ0JDM1FDMnE3bVVZMG5iTCtsTkdWVU5vYUF5VEM3WmV6?=
 =?utf-8?B?Skg5MU82Q0FzeHoyM0NRSVExVDIvNUl0UDAyMjhmcW9NU3huL24vL1IrQ0oy?=
 =?utf-8?B?NFFKazE5T2V4MXVvMDRnbUNLMUhWcUdaWWNIeEN0WWxOSk9RcTcvV0ZKQXpt?=
 =?utf-8?B?ZU9hdEVNZ0NuVWVZeGFqcUJ3T3ZwaFFlWlhiWnc4c0tWY1ZwY2hyTWQrWi8x?=
 =?utf-8?B?TGpjOWtNZjZGdTZBVGNGNWV1RzgzS2J3cTBPTi9ZWWdBVlB4TndsYWZWNVVz?=
 =?utf-8?B?WGZRdTdMZ2hLcXJ1VHBmbVNGZjZ6M09nRzFubmhFQXNtUng4SEJ3aG45L05j?=
 =?utf-8?B?RU94ZFZ3cU9FWTNlOGRzVjRQcTdsQzN5MzZ4WG83YjVrWG41ZC84K3N5U05l?=
 =?utf-8?B?Wmh4ajluYjV5bnErOUNGZGpFTWhzaVpWMURvQkVXRXpEOGV5dTB0TlFLZFdn?=
 =?utf-8?B?MUJiNklRVTkxd01KM0p5ZmN4NytPc2lnN0JkbXpLdi9FdWYzMlZiUjJSWHpJ?=
 =?utf-8?B?ZlU3UFdSRXNiOEppQ2pSOFQxbVQrSXNQY2d5RjRJT2p3aGtFRks3UlovckR4?=
 =?utf-8?B?bmVnMVBpcSt4d2dGbkZGcC9HWFZ2eVExRFJKNHAyS0VzcEo0ZFZ4YkNyR0xL?=
 =?utf-8?Q?2szWtXBJIyzZ7SaGrK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9e8f7e-207c-4f0e-bd9f-08df36f177b3
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 01:51:23.4174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXLYg8yqONChykV/OJPRULZ8pSClA2IGEcGSsY+h2K4u+PqfgOXPrZAmqN5P/FARH3Aes7epDRIXTeS8EIvs+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/21/26 06:29, Melissa Wen wrote:
> Commit c2791297013e ("drm/amd/display: Add color bit info to freesync
> infoframe") created the app_tf interface for FreeSync HDR and commit
> c21a764a98cb ("drm/amd/display: Send PQ bit in AMD VSIF") used it to set
> PB9 bit 5 (PQ EOTF) in v2/v3 AMD Freesync infopacket. However, Linux
> never made use of this interface: DM ignores what userspace sets
> regarding HDR and always passes TRANSFER_FUNC_UNKNOWN as app_tf, so the
> PQ bit is never set in the infopacket received by the eDP panel.
> 
> Check the EOTF in the HDR static metadata and set the PQ bit in Freesync
> infopacket for DP accordingly. This fixes gray-washed HDR on KDE/GNOME
> on Framework 13 Pro AI 9 HX 370 (DCN 3.5) and may fix similar issues on
> other VRR-capable panels that advertise Replay in its AMD VSDB.
> 
> It doesn't affect color/EOTF bits on infopackets for SDR and native
> HDMI.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/3200
> Reported-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index ab9cfbce8d73..322106d1cce7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -165,6 +165,18 @@ void amdgpu_dm_get_freesync_config_for_crtc(
>   }
>   EXPORT_IF_KUNIT(amdgpu_dm_get_freesync_config_for_crtc);
>   
> +#define DP_HDR_SDP_EOTF_IDX 2
> +
> +static bool dm_dp_in_hdr_mode(const struct dc_stream_state *stream)
> +{
> +	const struct dc_info_packet *hdr = &stream->hdr_static_metadata;
> +
> +	if (!dc_is_dp_signal(stream->signal) || !hdr->valid)
> +		return false;
> +
> +	return hdr->sb[DP_HDR_SDP_EOTF_IDX] == HDMI_EOTF_SMPTE_ST2084;
> +}
> +
>   void amdgpu_dm_update_freesync_state_on_stream(
>   	struct amdgpu_display_manager *dm,
>   	struct dm_crtc_state *new_crtc_state,
> @@ -181,6 +193,7 @@ void amdgpu_dm_update_freesync_state_on_stream(
>   	bool pack_sdp_v1_3 = false;
>   	struct amdgpu_dm_connector *aconn;
>   	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
> +	enum color_transfer_func app_tf;
>   
>   	if (!new_stream)
>   		return;
> @@ -232,12 +245,16 @@ void amdgpu_dm_update_freesync_state_on_stream(
>   					&new_stream->adaptive_sync_infopacket);
>   	}
>   
> +	app_tf =  dm_dp_in_hdr_mode(new_stream) ?
> +		  TRANSFER_FUNC_PQ2084 :
> +		  TRANSFER_FUNC_UNKNOWN;
> +
>   	mod_freesync_build_vrr_infopacket(
>   		dm->freesync_module,
>   		new_stream,
>   		&vrr_params,
>   		packet_type,
> -		TRANSFER_FUNC_UNKNOWN,
> +		app_tf,
>   		&vrr_infopacket,
>   		pack_sdp_v1_3);
>   

