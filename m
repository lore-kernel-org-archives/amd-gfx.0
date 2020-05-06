Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389A0C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 08:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C089206D5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 08:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AAzeSnOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C089206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0D26E836;
	Wed,  6 May 2020 08:48:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7DA6E833
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 08:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJWFKGecGs8kMBnOcvbo+Bib/wdCdPa5s39VKlzcOXrNV18b3V1Bs1zSCJNjCFTGUdsD7VhG8utVykBy/E0te458dgDW7q0eKHFRE1s/OyMp8uWVGDQ1by9523qDr6Bxni2NMY4Wl/oDm1+DPJWqKlRjO5kGkE0hOtADZCYFeqZQ2pCHj96JCA00LQVTuzjLT/UJz1G8S8dpi9QMTqcF91hKH12Pkf0KgoUF6uMz3sFz1IpqLu/nsQiqSVUKhKAM7rxgp7aZvT27eZ2+Z2nu0muNwG+Go+NaSkyIg+2AgSId4wxnDlEex4T6SPbSX3fx7OVUIomVdtVLDpeVSc3G8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j34nqMp0DemsASH99mw+RE2D2gmRYa8olXSBkRHnd3s=;
 b=WiTZXmxVhvtxk76pzjH0c6d3B9NdUK1YMDj9nWl+2g3Lv6q+DNliKMDuoRHiqs5uIG2g2D7QoZpBNmSVuZg8s/3K+yKJouhDo/1XYi1vmkyJSSse9UKelQUDVsy/QuXLeDNaOETzzpW9Qm5FGaA7nUXHVTeXHeCa7uko+NpTvbXohsppyCEbTSq7WR2cDMoHhLQwJu3qw4H1jEkNVJKu4XebYoHCR6+v/i/6S58uEHD4acpBFxX5kDIYO/yZeU07Y+zMeKSmc0GfHcr+kSshNE67j/1IrJFnLz2sruwXDZzD61THEkum25GtvyYFamkC3rI/s0Z4dgU4vtgDn/jJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j34nqMp0DemsASH99mw+RE2D2gmRYa8olXSBkRHnd3s=;
 b=AAzeSnOCLwTZmYuvcw/lWf6sY8Kms7EVmy4QGlPi8ruY4OzYMZZQIazyka3MdB+48mDxX3oihTqhpKh7eAUnYJR1t3N4lZANke0zVlpjD/ptC29GJ22MYK9x8N5DLBVPXjzY46xq/ZLzX8O5/BPEpDIcnO7O6l31qUmCTrfK2OI=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Wed, 6 May
 2020 08:48:16 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8%7]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 08:48:16 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: switch to common xgmi ta helpers
Thread-Topic: [PATCH 1/4] drm/amdgpu: switch to common xgmi ta helpers
Thread-Index: AQHWI3EaJMgZN3MSqkCsSWPtHn1Z46iavJaAgAACnGA=
Date: Wed, 6 May 2020 08:48:16 +0000
Message-ID: <MN2PR12MB4032BF30AFEF338771C92786FBA40@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <20200506063923.22772-1-Hawking.Zhang@amd.com>
 <MN2PR12MB2893368F3960A09A37701752B0A40@MN2PR12MB2893.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB2893368F3960A09A37701752B0A40@MN2PR12MB2893.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-06T08:38:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ae3c3c27-bd2f-4abe-88e1-0000b3488a4d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-06T08:48:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 02daaebe-32c9-4099-8f0b-000050a123aa
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c14d9ac0-9819-4744-b715-08d7f19a3809
x-ms-traffictypediagnostic: MN2PR12MB3951:|MN2PR12MB3951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3951B5576C63A1A49A16CBF1FBA40@MN2PR12MB3951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+utGg06ZbyK5bPntvrgYqdbGfCwLKaPtPic+Q+mWWlPAXEP476t0IlryHOxy2KCIR43XbHD6RtDl6yDcdnIS97YB5SBRiwfDk8RbUHik+/sUhW+rCgNUm8gS4nkX7xgWp2q/Nqqv2F2VRT4Ju85AHUAwb9MkQmajRrCP/fVgqxl6A1nOJtwG1VaHyCg5I/3p1IyImXbTlFlmchg2/oeY0Zd6ufSGlawD61IYIulIroZ7zdNo6G1Czs5GevIhCMMbVhbUbZGWDlQ1Dx3hKreFgvM0zuhlYIsC9TNh/oUmnhq2HxQ4OemZapBXxNKj42GKn4nBGND0K56H23liTAwQ6GCRmuSiWxct6w+BrxIAhHEC+F2eo37J9AZfnYpSMV3KM5x8Zbl0LjhCY1OGuBpm7ATfig95bHPFGm7J+os28R3yrNMPui9rQmwKPTI1rU6MIpDI1Bb4kiw4138AQA9WPu/EApAcstzTPjlpnNgRV/u7Lu/TQ5n9fs5WY5YR3zEi4Rp6yOICPM53YxX73ZZeX6TLa/7WaChjh+aeKS5Vn4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(33430700001)(86362001)(8936002)(8676002)(6506007)(30864003)(53546011)(186003)(26005)(33440700001)(33656002)(7696005)(316002)(5660300002)(52536014)(6636002)(110136005)(66476007)(2906002)(76116006)(4326008)(66556008)(478600001)(71200400001)(66946007)(9686003)(55016002)(66446008)(64756008)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7kxJ51WJUcaDtW+oodixePDFsnocQHO8t7kWV7HZ3tnI2DNj+z1H4NxmMYvqwDHP2O0X4N4Tn+ts+lWMyJ3xBi3C5K3AtN0/J0oWiXKzL/bSDeuUIUSooJfOSAzhujAdXidVSRqH24RtazFbOq64v9HZBU55PGFSzJGdQnGqC1W51SFt1NZkn/SYcP3rrRg1LxldkSD330BvqC4mUUtDd7R2x9eBYUXsE9SzUZcEIxjzWNyuzaTKHfKWGStq5bKiXCQYHho91AtBYOGvfeaXvjxBrQa4P/oqud5iC1wVb8yCMecFxrBInnbDhoK5SxqWpsNC/hS+Bz8xaNpAhB1lc+EB5UE0UK+/Q5rFs6Y6siXw4rdRkrPrCGeAWQx+FDrfXETNA1zfhdrPGaERRP4LHwntBfrD99TLqO9TSji4qGHbmbF4QUPNyIPJwBI0mVp9HMkCeM5FUetVyDDkRohz6z/qu/Xp+ypap1SPxrJuVxlMeG+X53kvfhBK54UXZGZZw8H6S33ezURYnl2EWPsX/XnDurKC+cyZg6bP6iFiXZAEhZczyFaSdr78ENlX/5Kcqz3u0fGIl3i2rrlFYFxqhKZ+S7ceTKkFBhi4djLFK3DvrJk5H2Bld5X8WwHacjXG1G6Sw/u1vZfe0xf8pCd2CwnzVLO/6OVXxcpHlRoV3LIWdWxPutlzmrEFqyHop7yMYf7s62PweTDR1oD5wqdkxIk2svR+jAXxg7jUa30HP5D+IWNZPWKIoUfK/rI9jfzZEjw7LaWqctOf5Sn5+qZyIbr8oYAUpJong7ewDG7ASXo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14d9ac0-9819-4744-b715-08d7f19a3809
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 08:48:16.1883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEhpOjrZyXnAn8Q/Af8YXBEvjF6p6RFfZQilT52Z95RX88TnyfjC+WruDjyNArl84BhQwBXhJ9DhY2B79FWEpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Wednesday, May 6, 2020 4:39 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: switch to common xgmi ta helpers

[AMD Public Use]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: 2020年5月6日 14:39
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; 
> Gao, Likun <Likun.Gao@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; 
> Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: switch to common xgmi ta helpers
> 
> get_hive_id/get_node_id/get_topology_info/set_topology_info
> are common xgmi command supported by TA for all the ASICs that support 
> xgmi link. They should be implemented as common helper functions to 
> avoid duplicated code per IP generation
> 
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 115
> ++++++++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  24 +++---- 
> drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 121 
> --------------------------------
>  3 files changed, 123 insertions(+), 137 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index f061ad6..bb5b510 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -664,6 +664,121 @@ int psp_xgmi_initialize(struct psp_context *psp)
>  	return ret;
>  }
> 
> +int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id) {
> +	struct ta_xgmi_shared_memory *xgmi_cmd;
> +	int ret;
> +
> +	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp-
> >xgmi_context.xgmi_shared_buf;
> +	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
> +
> +	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_HIVE_ID;
> +
> +	/* Invoke xgmi ta to get hive id */
> +	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
> +	if (ret)
> +		return ret;
> +
> +	*hive_id = xgmi_cmd->xgmi_out_message.get_hive_id.hive_id;
> +
> +	return 0;
> +}
> +
> +int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id) {
> +	struct ta_xgmi_shared_memory *xgmi_cmd;
> +	int ret;
> +
> +	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp-
> >xgmi_context.xgmi_shared_buf;
> +	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
> +
> +	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_NODE_ID;
> +
> +	/* Invoke xgmi ta to get the node id */
> +	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
> +	if (ret)
> +		return ret;
> +
> +	*node_id = xgmi_cmd->xgmi_out_message.get_node_id.node_id;
> +
> +	return 0;
> +}
> +
> +int psp_xgmi_get_topology_info(struct psp_context *psp,
> +			       int number_devices,
> +			       struct psp_xgmi_topology_info *topology) {
> +	struct ta_xgmi_shared_memory *xgmi_cmd;
> +	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
> +	struct ta_xgmi_cmd_get_topology_info_output
> *topology_info_output;
> +	int i;
> +	int ret;
> +
> +	if (!topology || topology->num_nodes >
> TA_XGMI__MAX_CONNECTED_NODES)
> +		return -EINVAL;
> +
> +	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp-
> >xgmi_context.xgmi_shared_buf;
> +	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
> +
> +	/* Fill in the shared memory with topology information as input */
> +	topology_info_input = &xgmi_cmd-
> >xgmi_in_message.get_topology_info;
> +	xgmi_cmd->cmd_id =
> TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO;
> +	topology_info_input->num_nodes = number_devices;
> +
> +	for (i = 0; i < topology_info_input->num_nodes; i++) {
> +		topology_info_input->nodes[i].node_id = topology-
> >nodes[i].node_id;
> +		topology_info_input->nodes[i].num_hops = topology-
> >nodes[i].num_hops;
> +		topology_info_input->nodes[i].is_sharing_enabled =
> topology->nodes[i].is_sharing_enabled;
> +		topology_info_input->nodes[i].sdma_engine = topology-
> >nodes[i].sdma_engine;
> +	}
> +
> +	/* Invoke xgmi ta to get the topology information */
> +	ret = psp_xgmi_invoke(psp,
> TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO);
> +	if (ret)
> +		return ret;
> +
> +	/* Read the output topology information from the shared memory */
> +	topology_info_output = &xgmi_cmd-
> >xgmi_out_message.get_topology_info;
> +	topology->num_nodes = xgmi_cmd-
> >xgmi_out_message.get_topology_info.num_nodes;
> +	for (i = 0; i < topology->num_nodes; i++) {
> +		topology->nodes[i].node_id = topology_info_output-
> >nodes[i].node_id;
> +		topology->nodes[i].num_hops = topology_info_output-
> >nodes[i].num_hops;
> +		topology->nodes[i].is_sharing_enabled =
> topology_info_output->nodes[i].is_sharing_enabled;
> +		topology->nodes[i].sdma_engine = topology_info_output-
> >nodes[i].sdma_engine;
> +	}
> +
> +	return 0;
> +}
> +
> +int psp_xgmi_set_topology_info(struct psp_context *psp,
> +			       int number_devices,
> +			       struct psp_xgmi_topology_info *topology) {
> +	struct ta_xgmi_shared_memory *xgmi_cmd;
> +	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
> +	int i;
> +
> +	if (!topology || topology->num_nodes >
> TA_XGMI__MAX_CONNECTED_NODES)
> +		return -EINVAL;
> +
> +	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp-
> >xgmi_context.xgmi_shared_buf;
> +	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
> +
> +	topology_info_input = &xgmi_cmd-
> >xgmi_in_message.get_topology_info;
> +	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__SET_TOPOLOGY_INFO;
> +	topology_info_input->num_nodes = number_devices;
> +
> +	for (i = 0; i < topology_info_input->num_nodes; i++) {
> +		topology_info_input->nodes[i].node_id = topology-
> >nodes[i].node_id;
> +		topology_info_input->nodes[i].num_hops = topology-
> >nodes[i].num_hops;
> +		topology_info_input->nodes[i].is_sharing_enabled = 1;
> +		topology_info_input->nodes[i].sdma_engine = topology-
> >nodes[i].sdma_engine;
> +	}
> +
> +	/* Invoke xgmi ta to set topology information */
> +	return psp_xgmi_invoke(psp,
> TA_COMMAND_XGMI__SET_TOPOLOGY_INFO);
> +}
> +
>  // ras begin
>  static int psp_ras_init_shared_buf(struct psp_context *psp)  { diff 
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 7fcd63d..263bd8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -95,12 +95,6 @@ struct psp_funcs
>  			    enum psp_ring_type ring_type);
>  	bool (*smu_reload_quirk)(struct psp_context *psp);
>  	int (*mode1_reset)(struct psp_context *psp);
> -	int (*xgmi_get_node_id)(struct psp_context *psp, uint64_t *node_id);
> -	int (*xgmi_get_hive_id)(struct psp_context *psp, uint64_t *hive_id);
> -	int (*xgmi_get_topology_info)(struct psp_context *psp, int
> number_devices,
> -				      struct psp_xgmi_topology_info *topology);
> -	int (*xgmi_set_topology_info)(struct psp_context *psp, int
> number_devices,
> -				      struct psp_xgmi_topology_info *topology);
>  	int (*ras_trigger_error)(struct psp_context *psp,
>  			struct ta_ras_trigger_error_input *info);
>  	int (*ras_cure_posion)(struct psp_context *psp, uint64_t *mode_ptr); 
> @@ -316,16 +310,6 @@ struct amdgpu_psp_funcs {
>  		((psp)->funcs->smu_reload_quirk ? (psp)->funcs-
> >smu_reload_quirk((psp)) : false)  #define psp_mode1_reset(psp) \
>  		((psp)->funcs->mode1_reset ? (psp)->funcs-
> >mode1_reset((psp)) : false) -#define psp_xgmi_get_node_id(psp, 
> >node_id) \
> -		((psp)->funcs->xgmi_get_node_id ? (psp)->funcs-
> >xgmi_get_node_id((psp), (node_id)) : -EINVAL)
> -#define psp_xgmi_get_hive_id(psp, hive_id) \
> -		((psp)->funcs->xgmi_get_hive_id ? (psp)->funcs-
> >xgmi_get_hive_id((psp), (hive_id)) : -EINVAL)
> -#define psp_xgmi_get_topology_info(psp, num_device, topology) \
> -		((psp)->funcs->xgmi_get_topology_info ? \
> -		(psp)->funcs->xgmi_get_topology_info((psp), (num_device),
> (topology)) : -EINVAL)
> -#define psp_xgmi_set_topology_info(psp, num_device, topology) \
> -		((psp)->funcs->xgmi_set_topology_info ?	 \
> -		(psp)->funcs->xgmi_set_topology_info((psp), (num_device),
> (topology)) : -EINVAL)
>  #define psp_rlc_autoload(psp) \
>  		((psp)->funcs->rlc_autoload_start ? (psp)->funcs-
> >rlc_autoload_start((psp)) : 0)  #define psp_mem_training_init(psp) \ 
> >@@ -
> 369,6 +353,14 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, 
> int inst_idx,  int psp_xgmi_initialize(struct psp_context *psp);  int 
> psp_xgmi_terminate(struct psp_context *psp);  int 
> psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
> +int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id); 
> +int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id); 
> +int psp_xgmi_get_topology_info(struct psp_context *psp,
> +			       int number_devices,
> +			       struct psp_xgmi_topology_info *topology); int 
> +psp_xgmi_set_topology_info(struct psp_context *psp,
> +			       int number_devices,
> +			       struct psp_xgmi_topology_info *topology);
> 
>  int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);  int 
> psp_ras_enable_features(struct psp_context *psp, diff --git 
> a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 97c80f1..4f6c0df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -524,123 +524,6 @@ static int psp_v11_0_mode1_reset(struct 
> psp_context *psp)
>  	return 0;
>  }
> 
> -/* TODO: Fill in follow functions once PSP firmware interface for 
> XGMI is ready.
> - * For now, return success and hack the hive_id so high level code 
> can
> - * start testing
> - */
> -static int psp_v11_0_xgmi_get_topology_info(struct psp_context *psp,
> -	int number_devices, struct psp_xgmi_topology_info *topology)
> -{
> -	struct ta_xgmi_shared_memory *xgmi_cmd;
> -	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
> -	struct ta_xgmi_cmd_get_topology_info_output
> *topology_info_output;
> -	int i;
> -	int ret;
> -
> -	if (!topology || topology->num_nodes >
> TA_XGMI__MAX_CONNECTED_NODES)
> -		return -EINVAL;
> -
> -	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp-
> >xgmi_context.xgmi_shared_buf;
> -	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
> -
> -	/* Fill in the shared memory with topology information as input */
> -	topology_info_input = &xgmi_cmd-
> >xgmi_in_message.get_topology_info;
> -	xgmi_cmd->cmd_id =
> TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO;
> -	topology_info_input->num_nodes = number_devices;
> -
> -	for (i = 0; i < topology_info_input->num_nodes; i++) {
> -		topology_info_input->nodes[i].node_id = topology-
> >nodes[i].node_id;
> -		topology_info_input->nodes[i].num_hops = topology-
> >nodes[i].num_hops;
> -		topology_info_input->nodes[i].is_sharing_enabled =
> topology->nodes[i].is_sharing_enabled;
> -		topology_info_input->nodes[i].sdma_engine = topology-
> >nodes[i].sdma_engine;
> -	}
> -
> -	/* Invoke xgmi ta to get the topology information */
> -	ret = psp_xgmi_invoke(psp,
> TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO);
> -	if (ret)
> -		return ret;
> -
> -	/* Read the output topology information from the shared memory */
> -	topology_info_output = &xgmi_cmd-
> >xgmi_out_message.get_topology_info;
> -	topology->num_nodes = xgmi_cmd-
> >xgmi_out_message.get_topology_info.num_nodes;
> -	for (i = 0; i < topology->num_nodes; i++) {
> -		topology->nodes[i].node_id = topology_info_output-
> >nodes[i].node_id;
> -		topology->nodes[i].num_hops = topology_info_output-
> >nodes[i].num_hops;
> -		topology->nodes[i].is_sharing_enabled =
> topology_info_output->nodes[i].is_sharing_enabled;
> -		topology->nodes[i].sdma_engine = topology_info_output-
> >nodes[i].sdma_engine;
> -	}
> -
> -	return 0;
> -}
> -
> -static int psp_v11_0_xgmi_set_topology_info(struct psp_context *psp,
> -	int number_devices, struct psp_xgmi_topology_info *topology)
> -{
> -	struct ta_xgmi_shared_memory *xgmi_cmd;
> -	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
> -	int i;
> -
> -	if (!topology || topology->num_nodes >
> TA_XGMI__MAX_CONNECTED_NODES)
> -		return -EINVAL;
> -
> -	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp-
> >xgmi_context.xgmi_shared_buf;
> -	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
> -
> -	topology_info_input = &xgmi_cmd-
> >xgmi_in_message.get_topology_info;
> -	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__SET_TOPOLOGY_INFO;
> -	topology_info_input->num_nodes = number_devices;
> -
> -	for (i = 0; i < topology_info_input->num_nodes; i++) {
> -		topology_info_input->nodes[i].node_id = topology-
> >nodes[i].node_id;
> -		topology_info_input->nodes[i].num_hops = topology-
> >nodes[i].num_hops;
> -		topology_info_input->nodes[i].is_sharing_enabled = 1;
> -		topology_info_input->nodes[i].sdma_engine = topology-
> >nodes[i].sdma_engine;
> -	}
> -
> -	/* Invoke xgmi ta to set topology information */
> -	return psp_xgmi_invoke(psp,
> TA_COMMAND_XGMI__SET_TOPOLOGY_INFO);
> -}
> -
> -static int psp_v11_0_xgmi_get_hive_id(struct psp_context *psp, 
> uint64_t
> *hive_id) -{
> -	struct ta_xgmi_shared_memory *xgmi_cmd;
> -	int ret;
> -
> -	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp-
> >xgmi_context.xgmi_shared_buf;
> -	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
> -
> -	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_HIVE_ID;
> -
> -	/* Invoke xgmi ta to get hive id */
> -	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
> -	if (ret)
> -		return ret;
> -
> -	*hive_id = xgmi_cmd->xgmi_out_message.get_hive_id.hive_id;
> -
> -	return 0;
> -}
> -
> -static int psp_v11_0_xgmi_get_node_id(struct psp_context *psp, 
> uint64_t
> *node_id) -{
> -	struct ta_xgmi_shared_memory *xgmi_cmd;
> -	int ret;
> -
> -	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp-
> >xgmi_context.xgmi_shared_buf;
> -	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
> -
> -	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_NODE_ID;
> -
> -	/* Invoke xgmi ta to get the node id */
> -	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
> -	if (ret)
> -		return ret;
> -
> -	*node_id = xgmi_cmd->xgmi_out_message.get_node_id.node_id;
> -
> -	return 0;
> -}
> -
>  static int psp_v11_0_ras_trigger_error(struct psp_context *psp,
>  		struct ta_ras_trigger_error_input *info)  { @@ -995,10 +878,6 @@ 
> static const struct psp_funcs psp_v11_0_funcs = {
>  	.ring_stop = psp_v11_0_ring_stop,
>  	.ring_destroy = psp_v11_0_ring_destroy,
>  	.mode1_reset = psp_v11_0_mode1_reset,
> -	.xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
> -	.xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
> -	.xgmi_get_hive_id = psp_v11_0_xgmi_get_hive_id,
> -	.xgmi_get_node_id = psp_v11_0_xgmi_get_node_id,
>  	.ras_trigger_error = psp_v11_0_ras_trigger_error,
>  	.ras_cure_posion = psp_v11_0_ras_cure_posion,
>  	.rlc_autoload_start = psp_v11_0_rlc_autoload_start,
> --
> 2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
