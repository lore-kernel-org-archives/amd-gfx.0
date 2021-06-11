Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93529C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 10:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7BA613EE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 10:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7BA613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D3B6E102;
	Fri, 11 Jun 2021 10:40:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA8D6E102
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 10:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHs9GB9nxkgw8nItqgAIEF/I4jLEhJfCOB9j4JQQpDeqT/kb9uUUEidL0+LqYV86BZnfIhtiBCuUoRMQVhB8Bfy+ao2/c8E1cdMcTtDjK+iWzsoetkJpDHk2lA4FfhfImDc99/QZ1aHvZD/ALHZtgG9owxtpuP6ptDmrJvvE7bSYcyC7TRQInkJHUVc5GzMpT+gmXi9sIr+lXDZPMouZEPrg9ejY33AUgXeXjfhCfNwHbyUhFYNYK5sQTymi0sgSUd8WDvArKXN0RCMCsmNa3pAaFYkPDf0p6HCGr6eWBa+lQNaLUUUc5Vhkcp/ZbS8Wd8tkQcnbb2hWlpq0XSn0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0/IXUD/sTL1ZxBtiL1E5eJWJoW1UzAdyh1Qspf97oI=;
 b=UwI6RwtsZByArmh2pOnNROFd+EYZrt8OG0a3mFbYf7ztdsQ6KVa256lagJXLTarKxwx/8wpXnFWRjv1E41BvkS3wvgoqMZt1VyouyOAJX/sk3pvorod9MIpma326Ywe8GvdpRVpFATs7McasbgiUftHPMCRBFvszJXcJ2E10VJIw0cb9+h/e3kR5nGs/GopNA02jk5HyAn8pAuAEtooPY9kK385G6cJl/KROo3KE6cF6NyKVavMUVGFXJ9wsNrklfgJQCw2RhVlt5aVu5XY4zjSAv+VekAy2RCyNJx0snANVJe0rD7eRNsxystV1EY90UTprKlNK+bklMbHG289T7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0/IXUD/sTL1ZxBtiL1E5eJWJoW1UzAdyh1Qspf97oI=;
 b=BFXHuJnfrR8sXZ+1YyShhjbzKt7iJQ7Xna/q+aRzlONHjYHnmZ4NvcKDjQvOZ0aoJwORzhr2xtnF7gOz7XQYPY65qCXA7eFnBE/z0B6D+Ly86T4sPXpCT0Uuv2oy4aCEATfH0v89n3a0qMmzJBx/kxuGu339O0RJevIZbwwin9I=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5028.namprd12.prod.outlook.com (2603:10b6:610:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 10:40:48 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::d532:d815:8c2c:e1bb%6]) with mapi id 15.20.4219.022; Fri, 11 Jun 2021
 10:40:47 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: support ss metrics read on renoir
Thread-Topic: [PATCH] drm/amd/pm: support ss metrics read on renoir
Thread-Index: AQHXXpmTBJWpXRNgUkObUwxkKiFDd6sOnvjg
Date: Fri, 11 Jun 2021 10:40:47 +0000
Message-ID: <CH0PR12MB5348B8864A759C5A03C482A897349@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210610043358.14997-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20210610043358.14997-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-11T10:40:40Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6a5d624a-9572-4428-ba07-8e65d0f7bf93;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.158.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33a7460d-29a6-476c-7dc1-08d92cc55fe7
x-ms-traffictypediagnostic: CH0PR12MB5028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5028415504853184C60FA6A097349@CH0PR12MB5028.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UlIMS9HZbAlVyhHNq+EoqnvU7JT5xfNGr8Wef/epY8IMvRishKlIsJ/KB5eFXLCwd3A7hmbS1HXkMiVjR7HlcE+Ch81efj25DVF+Z1x2B/fqnFy4RhuXv6Bk4s3FTPiQ0ynTbu9vxkTrrkG2/KoAjPQ6Nzm/UJMN1s6vqz64szuJQWBqdRX1eBYu3M8d/rtK875Wr49olnA0ZEYfkysDgItn6dFRSQMQ7lnDol4XvQSLb8LkFttRSrcjS1xX6zj29/VLxBkpwrR41IVRZZ8zlSnI35hW51XQUzzPBFtqS7670vaHof45ZLyDPQRbzdTuJFThoQaLECwQ+GatL9Ir6dMP9FADjFYfkvBNaNvYGN61D9JCi/AP9PfvOO9TFrGX8h8/1uTU1gIhCvnqrgF/NXNoeSeTR46PE4wFOYu4qcbK6WLVkDeS0CluvANMILWjXLrZjFlP10u+Rh5qw3NuVQP9IjI2kDdgRx5tdMZZsc7+bGLGBb9XhbLUWsfS9SMZfihJ8tem9V0KW2g1FQ+nW/wKvtP4hG/lwtddBBekjdgCKNtfHdDxhT3Y/0iUH14qeD/sPx+8YtG/X/NL/DQuBY7HnAqjWhugMULiHCkNWdU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(54906003)(33656002)(52536014)(316002)(66556008)(64756008)(66476007)(66446008)(76116006)(9686003)(8936002)(110136005)(4326008)(5660300002)(66946007)(7696005)(86362001)(2906002)(83380400001)(26005)(478600001)(8676002)(6506007)(53546011)(55016002)(186003)(71200400001)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmc4TWJQSXd5T2E5YXVPR2ZsTnk0QUQ5UEZPSWJTYUtyMDh4VkYvK095eUYw?=
 =?utf-8?B?SndYZCtOTXhMWmp2QjVRL3h5VEVaZmNpMkllZlBWUElkRDQrUVV4aS9uYWJC?=
 =?utf-8?B?TXVDcm9uVWtUc2x5cnRtQnlKaElqYXFqanNKOE42Nm41YzEwRHZGT09MbWs2?=
 =?utf-8?B?YUVIaUNUaEt6bHdRVjRLSmt2OGY3UTh5VWhDdFN6cE12RCtjMUVvUnRWUWoz?=
 =?utf-8?B?b25lR1JnOXlaaysyVC82LzRnaTRCVE1ONEc0d2hsUncyR1ZuMnFSRHhvWFNQ?=
 =?utf-8?B?L1NQdU5VOEVJMlV4WEZaWTVpcWNyZllDbmFhNGZMN1kxREJPdXRvSkFsdkFa?=
 =?utf-8?B?N3U0dmpXeDhlSnVESjVIeHhGRm56MHVJcnVXOUMwL0dQTDV1NkJJaWFrdVlw?=
 =?utf-8?B?RGREa2t2OHQvblZDUzlieVN3cEE3a2xCSysrVHcwOE5jTGNIVWJoQVRPcUtO?=
 =?utf-8?B?UGVsa0Z6VmgwcWVWQVJpaFhXOVFKelBSMGdyL1pyYzlZMVAxNmxBMmxvRDUx?=
 =?utf-8?B?czc0UzdyY3U3MGNOL3J5UThSVW9HcjM3RXMvdk9xOGxYQ21adi9TOTRJYW10?=
 =?utf-8?B?NGhjUENHNnBtWXFNRllHVVhuaXpDTDRBbFQvRFpqSDFrVUpYQXJQSFpNby9T?=
 =?utf-8?B?RmhwMmlxcTNpTVpWMzlieEtIaXRoQjJwblMvR3kvUzdvWk5HWWd0WGVzVlF6?=
 =?utf-8?B?cUJBaGVPRzcwaE54UTdGK3VmeDg0U2tZUURlSWpYZlhBNXU4Tit3a3RvZkR4?=
 =?utf-8?B?a3RkUXh1aUNyemk1N3h0NGFXanhMWHhJS0puZlVaL1ZhTFk2TFk1SlMrcHI1?=
 =?utf-8?B?UWR3YmhtS25UTTlMZjJSNGQxbklYUm81T1d1VXp3dDY1ZzAxcHVhcFhsVGlq?=
 =?utf-8?B?emtlSTlSQ3czSXlsN01PZzFsSnVQZnBQNE1yUndWNEpMRUVSTmNlRlVyNTVq?=
 =?utf-8?B?TXBOSmNYcmY3QmpKY01NWW9oMytpSUJ4Ti9sdHhWaUo4bmRLbVpqNnorTklu?=
 =?utf-8?B?bzRvQ2JkVGN1Y1F3VmczVzliVGx0VUlSYzNNMnlReUFyZ0FDREVJSGtlVGVO?=
 =?utf-8?B?TENScFRSaXh3OGk5UVFjaHgxVDI1NzFOaVdSdjBFQ2xRMDBwTkhzaGtyNjZF?=
 =?utf-8?B?c3AxbVdMZVptNC9uMlpUSVRqajFQMWZJZ3dWMUxveElkRGVra08ycW9ySEhy?=
 =?utf-8?B?TGVYMW95VzViZ2dhZ0hXVEZIaTgvU2tzbU55VXZaVTJSQXFGSlBwL0NxUWg1?=
 =?utf-8?B?SHk5NlpCMzhXTEJrRXlaVFQ0U1ZzQlVnR3c1Ynhibk94cUI5eFR2NkVjcW9m?=
 =?utf-8?B?dTVpSHhONDFGdFpmNjZyK0J4VFUrSTlQOG9neG9BQWV6bmJ5bkRmRmlCSEdl?=
 =?utf-8?B?QlllSFR3VXBLUld6OGpiMjlSRlI3SUNiTFNKdXBWSWZsVk8zbjdSeWo1eTYy?=
 =?utf-8?B?UFF2aURQa2NYSGtEWHFHWDNvc2V3bDdZRW5FM3VPTDhaaUpTbFpLQmFCam9Y?=
 =?utf-8?B?Sm1RaFlTTTMyNE5sZm1aQzFNUTMvTXhhN1FGenU3QkNVdFdaTEh6cGgwQjFH?=
 =?utf-8?B?cFRMSzkwNHRkU0hEdXJqRFZBdG9PdnRpS2tGM25VTmJ5ZjlPNlNScWdtMlZJ?=
 =?utf-8?B?QitERHNscVNraWlUaUtTazlzU1JPZ01iS3dKTFdIbkc3QTZoWTlHQ1M1MXpj?=
 =?utf-8?B?eG9Ua2ZtcE1aQU16NE9qR29TMGRPMDhQUkhsam1FSEdSaHhFNlNVQm1IQTNr?=
 =?utf-8?Q?ygfWRuPteOBYKu8xqbhdP3zLXkowtEtdZI3XApl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a7460d-29a6-476c-7dc1-08d92cc55fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 10:40:47.7248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8G9EPvlUS+FCylypGBJliNp3zEXPNhICNikw6i6A5PlVFpW26coAjuwp0beAWMhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5028
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com> 
Sent: Thursday, June 10, 2021 10:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Subject: [PATCH] drm/amd/pm: support ss metrics read on renoir

add support to read smart shift apu and dgpu power share on renoir.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index ccfcfcf18e4d..9a9c24a6ec35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1180,6 +1180,28 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_VOLTAGE_VDDSOC:
 		*value = metrics->Voltage[1];
 		break;
+	case METRICS_SS_APU_SHARE:
+		/* return the percentage of APU power with respect to APU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if (metrics->StapmOriginalLimit > 0)
+			*value =  (metrics->ApuPower * 100) / metrics->StapmOriginalLimit;
+		else
+			*value = 0;
+		break;
+	case METRICS_SS_DGPU_SHARE:
+		/* return the percentage of dGPU power with respect to dGPU's power limit.
+		 * percentage is reported, this isn't boost value. Smartshift power
+		 * boost/shift is only when the percentage is more than 100.
+		 */
+		if ((metrics->dGpuPower > 0) &&
+		    (metrics->StapmCurrentLimit > metrics->StapmOriginalLimit))
+			*value = (metrics->dGpuPower * 100) /
+				  (metrics->StapmCurrentLimit - metrics->StapmOriginalLimit);
+		else
+			*value = 0;
+		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -1251,6 +1273,18 @@ static int renoir_read_sensor(struct smu_context *smu,
 						  (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_SS_APU_SHARE,
+						  (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_SS_DGPU_SHARE,
+						  (uint32_t *)data);
+		*size = 4;
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
