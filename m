Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168F9CA0FF7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B2A10E3FB;
	Tue,  5 Sep 2023 18:47:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0EC10E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB1qq2wwM7rou/ctjZRuDRkwp4OJ4khmLPR3D8zGUfPjxMqWZ5lXSfmDFymtvG7piSYgSSxte/PRdVtdbCqIVigk/r/Db2Vx/AIwZFYNCYgraBJ0Sus91dIin1S6vpuIw0vWPiIj+IBMKpxgRs5AYdvGSVpkBix0VtOiQM1VvFNS1qipLsGg3Nux9l/6f+z/uaPXhUxXHzXmK4aXqu2HduC816nZnSR1iHQfrvtYZ3RsGFr3VsRT52Z2bLBn0zVOU4Rzblpsw8nlRjMggIrEv2LhgE2PJz9FQ/EJoACj9FsXlZjM163G6uRdbBEgn6N5+UfErDzSWGtHhJfAUs3l0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSCJ8Ylg39Qa2MK51KGu9G4+MWXp2OjRbQThrGtwOAg=;
 b=Is6VSWayutXPeIHVHD09+6smbX8FB0YB4xAq5D33kj9RV4C/AoTAdXVt5hxuxX/e4O7YpaGxPCvVAS8991vSm5IyIxphumDt5D45OVrnGe1LGxNw2a/MjOPm+MM5Wcdsc3lAoI36/YE0tCrg61rX87WikEGP9zvonVXRWwHyiJnHV6+Dzjl/+tbI6GpLg112nhot8jHi4lYphhnvv8Cjf3HQtK1dfwMjgWtQfwWeOHinb66kfBjs6vs4k/Smvi6gZdlWY1ZNVtWOntSKQkCeASgNURz4bfVnX1knuh4hs38UoVs/4zuqGj4f2jjomZRTdgUwBw0v2YubWEEvx4PzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSCJ8Ylg39Qa2MK51KGu9G4+MWXp2OjRbQThrGtwOAg=;
 b=XrqYc3QY20VYIrxvdjVb1hP2PWmy7IS5fUPrcyqFuBPnDKTPIuKt/6nTV+IvzkViohLwBmeRzcTWdBKglcs7n1dl5mB2e8Ajssy+v/Bs76EI+RlnjUdSLstPNmTIsRpNaTjjqdAgRQT6O/PMxmq48XCuFigxjo/H1+bApRiONS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:47:39 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:47:39 +0000
Message-ID: <c7ef1a20-46c2-d9ea-22d3-884fa5225258@amd.com>
Date: Tue, 5 Sep 2023 12:47:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/18] drm/amd/display: Skip writeback connector when we
 get amdgpu_dm_connector
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-5-alex.hung@amd.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-5-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a03:505::14) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d32d45-b9d1-4c2e-5f91-08dbae409461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqudLplJQxdj9LwIcP7RfMVpmpMk6c6oQuZXAD8+DLGcUpVP4sQyMO52UG8EeEurq4I63t0XLTWOhqJXvB2lS6MFrns+9OizRpyc1dr84hkOHfy+LKP+8J0zKEAxBtt4DsOWwR6mq8P1LdSNIHbELlvZ/ZtVfUHkZ+jCNRV9k3wx1WgMW3gbxfpOSwibvArGxfpFOzrzY95eYM68KEnFS95CkpZCKzTwAvVh7pxmVNt/MyfczEbSNl/fC1N2Jco3ylzUUN+SfduzVfybrRX032n4RycU0L74CtC72uIYGhZtNlVrZcsn/ztiStJGdGqt2CrrnvawRQUOcrnC9a1WIe2iusozYGh9BsGoThrW1sQTv0py1KMQtYcsSPSL9cgu1iLNRLHp+U/rVYeN3dVUiYUZZIMsISqTTDYp41mIpbRPp5+ejLVPlOS6TnCWhGHWGLPqyHi3u1mv/eTsMbLk6p6UWD/VvgNWaax54lczUHbWHG6NMoEzUYB8TAPTENytNGUF+uz7ITwsreIvk/GxCq/UiCkOuYE5ueHzdLJrgBCLUb8bpUZeEkyGeXYiQBAPrlGxP9TNfJ7c3YwYeK7w1iy3MJ+gR91txGvvQkHjPvrcWfr9BJnIuaj3hzHi2URMwpGPZgp6ViqNifoWy0oMYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(186009)(451199024)(1800799009)(31686004)(36756003)(53546011)(83380400001)(8936002)(31696002)(5660300002)(4326008)(44832011)(8676002)(6506007)(2616005)(6666004)(26005)(86362001)(41300700001)(6512007)(6486002)(478600001)(38100700002)(2906002)(316002)(66476007)(6916009)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FrMEREWmxsaFJ2ZzkwTWZBQ2I4MUdVNHArYUxqTXd1ZUM0MHpRYUxYbHcw?=
 =?utf-8?B?Q3dRODF5Ykk3VHhMY215MDRxN3BqMHVybWlPL3FVL3pJei9PU3VZV2ZYbVMx?=
 =?utf-8?B?Z0dRQ0RSYkVGb3NLdUl4YzQyYkdWVDMyQXgyZWtGZm4zQVFVK2Y0TUVKWEI1?=
 =?utf-8?B?VmI3RFRXU2dWVTRPZm5UQWcxQk5WNVNUMnNtSDdvTm40U0pTalpVblFRazNQ?=
 =?utf-8?B?ejFKNmtmUjEwRHBWcmsyb2w3czVGZEpVT0J2YlRRMGJDb1JZUEhMZlp0enZl?=
 =?utf-8?B?MXZvbjh3enNyOUJHOWkwbUNmbVhVVjhOWGRUUlZzMXJjdFBMc0ZGaEJjREFn?=
 =?utf-8?B?QUgzU3R5OXd0NVNoK1lLamZJK2VUdlRObUplYTU4WEVvYmkySmhlUnlxMGNB?=
 =?utf-8?B?RnhRaXhFb00wWlUvQU5hWG5LZUZuZStRY3hpOWRPZ21Jc2x2aDJtMHl3QVhM?=
 =?utf-8?B?VmNFWmNVTWpwWHJ2cWhCQncwcm8zUDJiZVZZRXgrT005ZUxoV2RGdUtoQnIr?=
 =?utf-8?B?aFJvZVZndWhvek9NUTlGUkFacFlWV203ZUtQdkg5WEVzSzlIVWgzc0xmbHRp?=
 =?utf-8?B?bVBXdkR6MXRkNUpwdWRFb3A2OHlZSndZNFRMR2lUQjV3MGJxT0Fyd0Rrd3VO?=
 =?utf-8?B?Z0E2WWU1UUVKTWlsZ3V1Sk1JeW1aRTEycEtYYit5aWxuTVU2NGk5MXljK256?=
 =?utf-8?B?bzcxWGFZZGRlNldCN3NERU40a0FKTDFiWGc2cHRGSmU3YnRiMUlLRnpUaHFz?=
 =?utf-8?B?TW50V09xaC9JcTFoWHJHYUdjSFpxcUl6bTlha2NBMUpVeGc2VFBkb3VWemJh?=
 =?utf-8?B?T21Ybk9jWFZyZmYzS213MW5Vc1ZpS3lCWEtCayt0THFadjBpYlVEdFl6TWZD?=
 =?utf-8?B?eUw3ZHFPSUVOV2tSY091K3lhYTRVTzVVYUoraVFFYy92MDdFMFRqUzNLRitX?=
 =?utf-8?B?ODNqQ251d2poM29uMGVTaTEzRmlsVDJldllpaFprM1d1dysyNXJXVEpEQ3oz?=
 =?utf-8?B?NlFqUTFnSStvbGlnYlVMYnNBU3lyRktkbnduMzhpWmFzZ2hPUTNGMlVJOFpR?=
 =?utf-8?B?dnpkSjZxeXpMRDB4YU9lMFM5c2JxNUpyKzZoYUg2STZQKzcvcjI5SjZwL1I5?=
 =?utf-8?B?K2xpYXplZkwvZnRVdmFTSEtFTzg5TStnd0JMeVNaaFlVbXVuR1NUN2RRclQz?=
 =?utf-8?B?N2RVUGx6RlFKQ3lwSVZnMU1TdkdiTVJFeWRhKzc1eWxVVHZwa3FqNTllemow?=
 =?utf-8?B?RlBpdEhya1FuMjI4bkNUbUR2SjV6cWp3bS9LVFhUTW9aY3I0U1YxSG5Tc09X?=
 =?utf-8?B?c2EyUWQ1Y0FFbjRuVXF4SmRyR1pMcVdpK29idi84bnM3WG11SVVJUWhFdXhW?=
 =?utf-8?B?bUcwWVQrUHpaWUFnMEU0UjhmUTRtWWU4NStDNGlmc2RNeDVhZmowSkxJVnJh?=
 =?utf-8?B?djMralhFczkycnJaQ0RmaVA4dFFPc2RHVGoxU096R1YvRVVETlF6ZFBuWnlS?=
 =?utf-8?B?ajcwK1phbURDMkpVVWhWL09OMnVOQnh3THJWMVJvT2N4YVprblRqYUZRcjlu?=
 =?utf-8?B?RG9NQUd6d3Y2TW96QlRoVWY0NXVaaitnNGQ1a3V2NGo5TDRvcVArbGttNEg1?=
 =?utf-8?B?NWJlVjJBOVZRWFcvUlBmamd5M3ZYVWM4MTQ3elRyRml4N0tzYklPaDBEQmtl?=
 =?utf-8?B?T3NkRW4xc3dxdEo1WDI5VTRSWm9zbE9SVWdvVldlTVN0T2ZDeHBzLzhPNWlQ?=
 =?utf-8?B?UUlrMURDcFBmdThLWTdSWUdpN1lESmhTSzQ1SDhKMytWSDN3VkJrRDFYS0dB?=
 =?utf-8?B?UUd1VytIdldOSjc4MzFCQUtxeEdmdU53V29aTStWODM1ZGI2YVR1a0hsWWx4?=
 =?utf-8?B?V0pJdi8xendMSnhtVDM5L2JTbGJCWmhwOXVPWE5tcFZrbW1RNGphWk55Y1Y3?=
 =?utf-8?B?aWtvUXBGTFpiVXlFandSNzhSUUZjUDVMWU1raUlKZG5MTmFxRUVaQ1c0d3Yx?=
 =?utf-8?B?amhPNjhvRTJUNlVqZytRMXdPSElRdzAxYmRuRFVSZFhrTjBXQklTMUpwa001?=
 =?utf-8?B?dE5iVWpCdFUyeWk3ZUNKenVrS3hNSGFBODhpWjFuY3RpT2RRemZ2UUJvU09G?=
 =?utf-8?Q?dmWfeWECVeoD5m607tH0HdSkc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d32d45-b9d1-4c2e-5f91-08dbae409461
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:47:39.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyNgIb5sJ/ARQeWO4aWk9xlm78b67PK53bNsKSlJGdqUWSstR3MKL0jG0oR2sXnCHXnqa1AigD0HMjAfPGmXsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2023-08-16 15:26, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [WHY]
> Writeback connectors are based on a different object:
> drm_writeback_connector, and are therefore different from
> amdgpu_dm_connector. We need to be careful to ensure code
> designed for amdgpu_dm_connector doesn't inadvertently try
> to operate on a drm_writeback_connector.
> 
> [HOW]
> Skip them when connector type is DRM_MODE_CONNECTOR_WRITEBACK.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 62 +++++++++++++++++--
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  3 +
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 22 +++++--
>   3 files changed, 76 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 445369afcead..363d91d49a3a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -721,6 +721,10 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
>   
>   	drm_connector_list_iter_begin(dev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> +
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		if (link && aconnector->dc_link == link) {
>   			if (notify->type == DMUB_NOTIFICATION_HPD)
> @@ -945,6 +949,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
>   
>   	drm_connector_list_iter_begin(dev, &conn_iter);
>   	drm_for_each_connector_iter(connector, &conn_iter) {
> +
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		if (aconnector->audio_inst != port)
>   			continue;
> @@ -2270,6 +2278,10 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
>   
>   	drm_connector_list_iter_begin(dev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> +
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		if (aconnector->dc_link->type == dc_connection_mst_branch &&
>   		    aconnector->mst_mgr.aux) {
> @@ -2350,6 +2362,10 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
>   
>   	drm_connector_list_iter_begin(dev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> +
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		if (aconnector->dc_link->type != dc_connection_mst_branch ||
>   		    aconnector->mst_root)
> @@ -2865,6 +2881,10 @@ static int dm_resume(void *handle)
>   	/* Do detection*/
>   	drm_connector_list_iter_begin(ddev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> +
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   
>   		if (!aconnector->dc_link)
> @@ -3416,6 +3436,9 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
>   	list_for_each_entry(connector,
>   			&dev->mode_config.connector_list, head)	{
>   
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		dc_link = aconnector->dc_link;
>   
> @@ -5413,10 +5436,13 @@ static void fill_stream_properties_from_drm_display_mode(
>   {
>   	struct dc_crtc_timing *timing_out = &stream->timing;
>   	const struct drm_display_info *info = &connector->display_info;
> -	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> +	struct amdgpu_dm_connector *aconnector = NULL;
>   	struct hdmi_vendor_infoframe hv_frame;
>   	struct hdmi_avi_infoframe avi_frame;
>   
> +	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
> +		aconnector = to_amdgpu_dm_connector(connector);
> +
>   	memset(&hv_frame, 0, sizeof(hv_frame));
>   	memset(&avi_frame, 0, sizeof(avi_frame));
>   
> @@ -6843,6 +6869,9 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
>   
>   	for_each_new_connector_in_state(state, connector, new_con_state, i) {
>   
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   
>   		if (!aconnector->mst_output_port)
> @@ -8392,6 +8421,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
>   		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
>   			continue;
>   
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   notify:
>   		aconnector = to_amdgpu_dm_connector(connector);
>   
> @@ -8425,6 +8457,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
>   		if (!status)
>   			continue;
>   
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   
>   		mutex_lock(&adev->dm.audio_lock);
> @@ -8686,7 +8721,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
>   		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
> -		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> +		struct amdgpu_dm_connector *aconnector;
> +
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
> +		aconnector = to_amdgpu_dm_connector(connector);
>   
>   		if (!adev->dm.hdcp_workqueue)
>   			continue;
> @@ -9029,10 +9069,15 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
>   void dm_restore_drm_connector_state(struct drm_device *dev,
>   				    struct drm_connector *connector)
>   {
> -	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> +	struct amdgpu_dm_connector *aconnector;
>   	struct amdgpu_crtc *disconnected_acrtc;
>   	struct dm_crtc_state *acrtc_state;
>   
> +	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +		return;
> +
> +	aconnector = to_amdgpu_dm_connector(connector);
> +
>   	if (!aconnector->dc_sink || !connector->state || !connector->encoder)
>   		return;
>   
> @@ -9109,12 +9154,16 @@ static void get_freesync_config_for_crtc(
>   	struct dm_connector_state *new_con_state)
>   {
>   	struct mod_freesync_config config = {0};
> -	struct amdgpu_dm_connector *aconnector =
> -			to_amdgpu_dm_connector(new_con_state->base.connector);
> +	struct amdgpu_dm_connector *aconnector;
>   	struct drm_display_mode *mode = &new_crtc_state->base.mode;
>   	int vrefresh = drm_mode_vrefresh(mode);
>   	bool fs_vid_mode = false;
>   
> +	if (new_con_state->base.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +		return;
> +
> +	aconnector = to_amdgpu_dm_connector(new_con_state->base.connector);
> +
>   	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
>   					vrefresh >= aconnector->min_vfreq &&
>   					vrefresh <= aconnector->max_vfreq;
> @@ -9898,6 +9947,9 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>   		if (conn_state->crtc != crtc)
>   			continue;
>   
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		if (!aconnector->mst_output_port || !aconnector->mst_root)
>   			aconnector = NULL;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> index 52ecfa746b54..f936a35fa9eb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> @@ -326,6 +326,9 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
>   			if (!connector->state || connector->state->crtc != crtc)
>   				continue;
>   
> +			if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +				continue;
> +
>   			aconn = to_amdgpu_dm_connector(connector);
>   			break;
>   		}
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 51467f132c26..58b880acb087 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -894,10 +894,15 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>   
>   	drm_connector_list_iter_begin(dev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> -		struct amdgpu_dm_connector *amdgpu_dm_connector =
> -				to_amdgpu_dm_connector(connector);
> +		struct amdgpu_dm_connector *amdgpu_dm_connector;
> +		const struct dc_link *dc_link;
>   
> -		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
> +		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
> +
> +		dc_link = amdgpu_dm_connector->dc_link;
>   
>   		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
>   			dc_interrupt_set(adev->dm.dc,
> @@ -930,9 +935,14 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
>   
>   	drm_connector_list_iter_begin(dev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> -		struct amdgpu_dm_connector *amdgpu_dm_connector =
> -				to_amdgpu_dm_connector(connector);
> -		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
> +		struct amdgpu_dm_connector *amdgpu_dm_connector;
> +		const struct dc_link *dc_link;
> +
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
> +		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
> +		dc_link = amdgpu_dm_connector->dc_link;
>   
>   		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
>   			dc_interrupt_set(adev->dm.dc,
