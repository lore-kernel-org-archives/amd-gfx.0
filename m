Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC46C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 01:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FE910E3C8;
	Tue, 31 Oct 2023 01:43:04 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E4F810E3C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 01:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwhOb5BnZ1IaF64Tn9NLYlfpIemlsj6IcmyQ8DKDG+8qZKQMWKN4aP6my4XlTKIOZrRprWeZAaw3le/ARGxJRkzFrqatUzi50WwXOol7l8NLC0TDrCoIb9G+zUHNt4HUhShJtccsNZRnapDWCBmz0nG0lUdFWaZEiReVREZIb17gw7s0Y9xlIKq+2mF3s8Z6bOKei9EzPG716wr7x/eXi2wLZ0rbKEQupDnuo1QcYYoJ/rqJI9OMcun3AUr371aLd7j6iuEd8z6kUcnradVkisJmuzUzgSaCVJP472YHmhmJu3mHt/BsLXpwJZKfe4imQUnGRJmglJhzgoL4C5xVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LrSQvjXAe8xFC77QOpJs8PnWYGSW4cxFU/dJg3WTbQ=;
 b=oQ3gclVFuAlby13TB4zJjdv4owGJ90axdeCc5TG54bbPJRgJOu12xhqcwqWIcHkxI5lnSlDQb08tcSxnewE07HZTcgC0Y548rJvs6MxrehQ/zD+cOYAUFMeI3DK3roAa9iup+JSfdkCsahi6ftvkwKSe6siCOB7mAmWfbL610+xIKkpNWuRA4u35l+KGVeuUlDjcuIASmn3xgFgvJYYZ+9pA+4CI4Qm4BDAgLm5JKQeRJjOWs78tbaMqJJGz1r9CJf2Z1pfH3gKcsnKdDql6gQpTusyaLL1VW+1BJt5RC9VvFvindDolIYCYlyOe+5wSp+CQrZCHEXD5ytfzFJ4IDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LrSQvjXAe8xFC77QOpJs8PnWYGSW4cxFU/dJg3WTbQ=;
 b=xFVE4eSvQhbbkE5NRUCRcdWzeCqh+ZQnB5wCGULV8gqUbKxSBZxC492qUkjnrWdK6jMZoc7ydsLuKUNPbsroCuv2lV0uQsmcSYNKSEJCj6XsIf6I62Vr+TRXSSgboQgF/ziBrTL9Y4QDezFdfx/8k42juUUcFn7XnIATRzUBpeg=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 01:43:00 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 01:42:59 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/swsmu: update smu v14_0_0 driver if and
 metrics table
Thread-Topic: [PATCH v2] drm/amd/swsmu: update smu v14_0_0 driver if and
 metrics table
Thread-Index: AQHaCx+p83sGtp+RaEuzVzXhZUdJPLBjIL7g
Date: Tue, 31 Oct 2023 01:42:59 +0000
Message-ID: <CY5PR12MB6369D82F6A3129240A20BF9FC1A0A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231030105519.1961123-1-li.ma@amd.com>
In-Reply-To: <20231030105519.1961123-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=276e8018-a20f-49d3-9242-2fca3d882e4c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T01:42:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM6PR12MB4202:EE_
x-ms-office365-filtering-correlation-id: 1186af53-a09e-42b8-659b-08dbd9b2b6e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4rFlt2H2venDUApgS6t1kWWtCMhUuT/7rfTHaV+oRUQcry1onFe3oipHNbJdPFCFP29FcwqrJaplPL8kmXhvgW/ENom7UxyVvnYL42AHGt8jP++MiE1f5cc4OmrcuorLgTybKFDFrqEOm97CNGgP7AFEsmXP6WQ7l0zjNp46HQryW7jRi8RKMImsMlskQt+JieujwoSBoQH4lgm5Jt8zn/7ekK8ARDChfp2oQnnJbHd1Fvp24EUvFkDCLcSbNFnBHShQluRSf4SyrBwOvtR12cUAKwNZh/D3ImAPn+5i20ku3FNn1n3ffRZREp3Gxpj14/NbbWHLj5nj+Mv9aLHm/sBhWCRLx3py2ma4dnVoosYdnO9WysEjSHAEMOfK60K9sJoeqVue04L3Y+lrmEX5REk/9b61Yuh0UHnpwCRizlkqOFRzA32w67H6Et+dQdM3eCRi4g405TRA8hJPrZ40R1IOQjK5TYBe5Ue0eqiHov3HyTBVW4QYQFoW1YFMjkQwVOx+SliFiWZgwv+xmKVxR6c6emsf9lbjQhTBiPvGMsxxSR8Y3dT24ylplOcI8GfS7ShfMm+th7WAj0WsRLjtjZq++Lz24qsbRyrf03O/izp/g0Yj9j9p8idJ4QbQXIZ/+KRTqQOWQnX0dQdkZoOo5PQ/ZA1xAUxVROWlvl9ImhjItap9kbRxj+OGacizBYc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(15650500001)(41300700001)(30864003)(2906002)(86362001)(5660300002)(316002)(66946007)(76116006)(54906003)(66556008)(64756008)(66446008)(66476007)(110136005)(4326008)(8676002)(8936002)(52536014)(38070700009)(33656002)(38100700002)(478600001)(55016003)(53546011)(7696005)(6506007)(122000001)(9686003)(71200400001)(26005)(83380400001)(21314003)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t7RCnNXlUtQsNaOhnHsgiuMKhoBWtVepW57Ou9UdI0eqeKLN/c4HjxgX8mCm?=
 =?us-ascii?Q?aWdvi9BUBC14Yff1BCn2xq9DxTdaSj+slVyzEH0y2j/QPmAJZ8Kh0d72z9/F?=
 =?us-ascii?Q?Wmjy/yMu8aRW0eWosDoozD9pz08EfSppauKhP1/dg2V0AxwgSly2NZu8xvRb?=
 =?us-ascii?Q?2G3+8Fq81sNuFGgLuk0iiz/mMswZbU1EW0FLA98QDKEWQ6hNdEc/mb4QtbI4?=
 =?us-ascii?Q?IFqkYt5SjUKXjOruk6+AqzSrmALnNYEYnWuvudDpGjTzzVF7l+rNK3ijXSXI?=
 =?us-ascii?Q?V5chZ1rzk/CO0exLKriHVrwtWpiH6+DAUDq9mT03GHDjfwduWnzZ8fOrV/vu?=
 =?us-ascii?Q?tvCMCG0i9gcKW6k0EM7zlNpyi+3HRehsVPpWDwMevFNGNM198PHp3edHeXR4?=
 =?us-ascii?Q?gU4osX0EAMOzPFrPsM3ipyilPi3kY95TnmOV8UYP7zH4ThZddtK05RJyG4Le?=
 =?us-ascii?Q?TnDiHMd9YtNyS+yFj0nOcLznQy6p9NOLpfPF5blKfX6GjVpYmclT2R1h0z8q?=
 =?us-ascii?Q?Q98TsQi3pQMPIcD9dEskffi1lRb/yllF7xdXDGOdZK4T5MdLbSS+8KRlYXcM?=
 =?us-ascii?Q?sz+dT2xdPArM3RN48QCv1B9ttL7Wz5107ssvRGfVxa0cS2Q7qegZPArKMdEJ?=
 =?us-ascii?Q?NPNNcO11k7lu/Q6d+ti44qN/3fzVjuhe+bKbol9FYpiWBTNB904PZVGMzAzS?=
 =?us-ascii?Q?MK2GT6vsD9Nz1/ZBLenLGwsQw2N05gQeHL7Lh1i9k962xYnh9omLSw0NXJLP?=
 =?us-ascii?Q?nEOxIf+HWnu3mcjie2tmIJSvPBXv4lcMTlUBCFFjRnAxSzmCJ/NKwvuuRHuu?=
 =?us-ascii?Q?q1XGWITGq3GBtHfqfXnnyJwORNou18pm7rBqUbCaf63YcErpK8/95YugaKxU?=
 =?us-ascii?Q?DolK1c5pDg03Pua2+Tko7G71uLTjT+qSFRcKR+UaASHZZ57bsXqKdjpUqNpj?=
 =?us-ascii?Q?Fxb1zItjvKvb8iVfc2P5nZSU71kuBTwxEIaOSzRCW4JFggoBFLBBpZwIB8me?=
 =?us-ascii?Q?AGGflwQuV4vAoCdyRMB00Y3pt9evDuNV1ActZ1SLlNKu91DgpsVaDfi9S0ce?=
 =?us-ascii?Q?55LlxzRpBHQywKcgm7SHLAVLbA7rcUy/lyZFaSvOPgkwzAzpK6cYbnqv5Fcc?=
 =?us-ascii?Q?UTiQCxng/xtHQ7MIfccuYD4MNemEHzTvNJH0waHv6bi5RFA/dPPYevL27H3Z?=
 =?us-ascii?Q?9+IDIdsTMjOFzElw7+fjRvdEzn2uDM8EoR6+DH46ZlhxVQs1wBqVrQBiJaI5?=
 =?us-ascii?Q?bf2Han2VhM+o8yyut+Ft3/tIOMgZaP70QJNAnV7KQZjFGQoYOB3yTC6IYhqZ?=
 =?us-ascii?Q?m0ObCYjVcxIO/ec9e4vvsX7+OJsDODZOxUVz7qlZ5vx2sLl6CzArs2mfvV2e?=
 =?us-ascii?Q?+0y/EIrv7ahwCV0wqaNaLlpgAA33qrXuT7j1So2D+1Ky6LnlZeNol5FiMQu4?=
 =?us-ascii?Q?9/CjtBEIaFN+w1Nll0Lwp9h8lYuIF5vC4XRvhTR4tqqGbNLwimRnCdEoOD52?=
 =?us-ascii?Q?pcLNxA963tvDcWHKee7TG+RiVEuRR0sBW1oqsEXzm9cxE01TMKxOWZoGxV5Y?=
 =?us-ascii?Q?fbh7mvF/f8HAnihDxG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1186af53-a09e-42b8-659b-08dbd9b2b6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 01:42:59.8470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNp2wMM1av/tpZiA20uVVEkrsHsnhYEyOYg0aKAAFsT61GPFIZGu4QruyCToAtP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please drop v1: xxx line in comment.

W/ that fixed, this patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Li Ma
Sent: Monday, October 30, 2023 6:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Ma, Li <Li.Ma@amd.com>;=
 Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH v2] drm/amd/swsmu: update smu v14_0_0 driver if and metrics=
 table

Update driver if headers and metrics table in smu v14_0_0 after smu fw prom=
otion. And drop the legacy metrics table.
v1:
update header files
v2:
drop legacy metrics table and add warning of checking pmfw version.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  30 +-
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     | 120 +++-----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   2 +
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 260 +++---------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   3 +
 5 files changed, 97 insertions(+), 318 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 3201808c2dd8..cd3c40a86029 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1080,33 +1080,35 @@ struct gpu_metrics_v3_0 {
        uint16_t                        average_ipu_activity[8];
        /* time filtered per-core C0 residency % [0-100]*/
        uint16_t                        average_core_c0_activity[16];
-       /* time filtered DRAM read bandwidth [GB/sec] */
+       /* time filtered DRAM read bandwidth [MB/sec] */
        uint16_t                        average_dram_reads;
-       /* time filtered DRAM write bandwidth [GB/sec] */
+       /* time filtered DRAM write bandwidth [MB/sec] */
        uint16_t                        average_dram_writes;

        /* Driver attached timestamp (in ns) */
        uint64_t                        system_clock_counter;

        /* Power/Energy */
-       /* average dGPU + APU power on A + A platform */
+       /* time filtered power used for PPT/STAPM [APU+dGPU] [mW] */
        uint32_t                        average_socket_power;
-       /* average IPU power [W] */
+       /* time filtered IPU power [mW] */
        uint16_t                        average_ipu_power;
-       /* average APU power [W] */
+       /* time filtered APU power [mW] */
        uint32_t                        average_apu_power;
-       /* average dGPU power [W] */
+       /* time filtered GFX power [mW] */
+       uint32_t                        average_gfx_power;
+       /* time filtered dGPU power [mW] */
        uint32_t                        average_dgpu_power;
-       /* sum of core power across all cores in the socket [W] */
-       uint32_t                        average_core_power;
-       /* calculated core power [W] */
-       uint16_t                        core_power[16];
-       /* maximum IRM defined STAPM power limit [W] */
+       /* time filtered sum of core power across all cores in the socket [=
mW] */
+       uint32_t                        average_all_core_power;
+       /* calculated core power [mW] */
+       uint16_t                        average_core_power[16];
+       /* maximum IRM defined STAPM power limit [mW] */
        uint16_t                        stapm_power_limit;
-       /* time filtered STAPM power limit [W] */
+       /* time filtered STAPM power limit [mW] */
        uint16_t                        current_stapm_power_limit;

-       /* Average clocks */
+       /* time filtered clocks [MHz] */
        uint16_t                        average_gfxclk_frequency;
        uint16_t                        average_socclk_frequency;
        uint16_t                        average_vpeclk_frequency;
@@ -1115,7 +1117,7 @@ struct gpu_metrics_v3_0 {
        uint16_t                        average_vclk_frequency;

        /* Current clocks */
-       /* target core frequency */
+       /* target core frequency [MHz] */
        uint16_t                        current_coreclk[16];
        /* CCLK frequency limit enforced on classic cores [MHz] */
        uint16_t                        current_core_maxfreq;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index b483c8e096e7..22f88842a7fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -150,97 +150,39 @@ typedef struct {
 } DpmClocks_t;

 typedef struct {
-  uint16_t CoreFrequency[16];           //Target core frequency [MHz]
-  uint16_t CorePower[16];               //CAC calculated core power [W] [Q=
8.8]
-  uint16_t CoreTemperature[16];         //TSEN measured core temperature [=
C] [Q8.8]
-  uint16_t GfxTemperature;              //TSEN measured GFX temperature [C=
] [Q8.8]
-  uint16_t SocTemperature;              //TSEN measured SOC temperature [C=
] [Q8.8]
-  uint16_t StapmOpnLimit;               //Maximum IRM defined STAPM power =
limit [W] [Q8.8]
-  uint16_t StapmCurrentLimit;           //Time filtered STAPM power limit =
[W] [Q8.8]
-  uint16_t InfrastructureCpuMaxFreq;    //CCLK frequency limit enforced on=
 classic cores [MHz]
-  uint16_t InfrastructureGfxMaxFreq;    //GFXCLK frequency limit enforced =
on GFX [MHz]
-  uint16_t SkinTemp;                    //Maximum skin temperature reporte=
d by APU and HS2 chassis sensors [C] [Q8.8]
-  uint16_t AverageGfxclkFrequency;      //Time filtered target GFXCLK freq=
uency [MHz]
-  uint16_t AverageFclkFrequency;        //Time filtered target FCLK freque=
ncy [MHz]
-  uint16_t AverageGfxActivity;          //Time filtered GFX busy % [0-100]=
 [Q8.8]
-  uint16_t AverageSocclkFrequency;      //Time filtered target SOCCLK freq=
uency [MHz]
-  uint16_t AverageVclkFrequency;        //Time filtered target VCLK freque=
ncy [MHz]
-  uint16_t AverageVcnActivity;          //Time filtered VCN busy % [0-100]=
 [Q8.8]
-  uint16_t AverageVpeclkFrequency;      //Time filtered target VPECLK freq=
uency [MHz]
-  uint16_t AverageIpuclkFrequency;      //Time filtered target IPUCLK freq=
uency [MHz]
-  uint16_t AverageIpuBusy[8];           //Time filtered IPU per-column bus=
y % [0-100] [Q8.8]
-  uint16_t AverageDRAMReads;            //Time filtered DRAM read bandwidt=
h [GB/sec] [Q8.8]
-  uint16_t AverageDRAMWrites;           //Time filtered DRAM write bandwid=
th [GB/sec] [Q8.8]
-  uint16_t AverageCoreC0Residency[16];  //Time filtered per-core C0 reside=
ncy % [0-100] [Q8.8]
-  uint16_t IpuPower;                    //Time filtered IPU power [W] [Q8.=
8]
-  uint32_t ApuPower;                    //Time filtered APU power [W] [Q24=
.8]
-  uint32_t dGpuPower;                   //Time filtered dGPU power [W] [Q2=
4.8]
-  uint32_t AverageSocketPower;          //Time filtered power used for PPT=
/STAPM [APU+dGPU] [W] [Q24.8]
-  uint32_t AverageCorePower;            //Time filtered sum of core power =
across all cores in the socket [W] [Q24.8]
-  uint32_t FilterAlphaValue;            //Metrics table alpha filter time =
constant [us]
-  uint32_t MetricsCounter;              //Counter that is incremented on e=
very metrics table update [PM_TIMER cycles]
+  uint16_t CoreFrequency[16];        //Target core frequency [MHz]
+  uint16_t CorePower[16];            //CAC calculated core power [mW]
+  uint16_t CoreTemperature[16];      //TSEN measured core temperature [cen=
ti-C]
+  uint16_t GfxTemperature;           //TSEN measured GFX temperature [cent=
i-C]
+  uint16_t SocTemperature;           //TSEN measured SOC temperature [cent=
i-C]
+  uint16_t StapmOpnLimit;            //Maximum IRM defined STAPM power lim=
it [mW]
+  uint16_t StapmCurrentLimit;        //Time filtered STAPM power limit [mW=
]
+  uint16_t InfrastructureCpuMaxFreq; //CCLK frequency limit enforced on
+ classic cores [MHz]  uint16_t InfrastructureGfxMaxFreq; //GFXCLK frequenc=
y limit enforced on GFX [MHz]
+  uint16_t SkinTemp;                 //Maximum skin temperature reported b=
y APU and HS2 chassis sensors [centi-C]
+  uint16_t GfxclkFrequency;          //Time filtered target GFXCLK frequen=
cy [MHz]
+  uint16_t FclkFrequency;            //Time filtered target FCLK frequency=
 [MHz]
+  uint16_t GfxActivity;              //Time filtered GFX busy % [0-100]
+  uint16_t SocclkFrequency;          //Time filtered target SOCCLK frequen=
cy [MHz]
+  uint16_t VclkFrequency;            //Time filtered target VCLK frequency=
 [MHz]
+  uint16_t VcnActivity;              //Time filtered VCN busy % [0-100]
+  uint16_t VpeclkFrequency;          //Time filtered target VPECLK frequen=
cy [MHz]
+  uint16_t IpuclkFrequency;          //Time filtered target IPUCLK frequen=
cy [MHz]
+  uint16_t IpuBusy[8];               //Time filtered IPU per-column busy %=
 [0-100]
+  uint16_t DRAMReads;                //Time filtered DRAM read bandwidth [=
MB/sec]
+  uint16_t DRAMWrites;               //Time filtered DRAM write bandwidth =
[MB/sec]
+  uint16_t CoreC0Residency[16];      //Time filtered per-core C0 residency=
 % [0-100]
+  uint16_t IpuPower;                 //Time filtered IPU power [mW]
+  uint32_t ApuPower;                 //Time filtered APU power [mW]
+  uint32_t GfxPower;                 //Time filtered GFX power [mW]
+  uint32_t dGpuPower;                //Time filtered dGPU power [mW]
+  uint32_t SocketPower;              //Time filtered power used for PPT/ST=
APM [APU+dGPU] [mW]
+  uint32_t AllCorePower;             //Time filtered sum of core power acr=
oss all cores in the socket [mW]
+  uint32_t FilterAlphaValue;         //Metrics table alpha filter time con=
stant [us]
+  uint32_t MetricsCounter;           //Counter that is incremented on ever=
y metrics table update [PM_TIMER cycles]
+  uint32_t spare[16];
 } SmuMetrics_t;

-typedef struct {
-  uint16_t GfxclkFrequency;             //[MHz]
-  uint16_t SocclkFrequency;             //[MHz]
-  uint16_t VclkFrequency;               //[MHz]
-  uint16_t DclkFrequency;               //[MHz]
-  uint16_t MemclkFrequency;             //[MHz]
-  uint16_t spare;
-  uint16_t UvdActivity;                 //[centi]
-  uint16_t GfxActivity;                 //[centi]
-
-  uint16_t Voltage[2];                  //[mV] indices: VDDCR_VDD, VDDCR_S=
OC
-  uint16_t Current[2];                  //[mA] indices: VDDCR_VDD, VDDCR_S=
OC
-  uint16_t Power[2];                    //[mW] indices: VDDCR_VDD, VDDCR_S=
OC
-
-  uint16_t CoreFrequency[8];            //[MHz]
-  uint16_t CorePower[8];                //[mW]
-  uint16_t CoreTemperature[8];          //[centi-Celsius]
-  uint16_t L3Frequency[2];              //[MHz]
-  uint16_t L3Temperature[2];            //[centi-Celsius]
-
-  uint16_t spare2[24];
-
-  uint16_t GfxTemperature;              //[centi-Celsius]
-  uint16_t SocTemperature;              //[centi-Celsius]
-  uint16_t ThrottlerStatus;
-
-  uint16_t CurrentSocketPower;          //[mW]
-  uint16_t StapmOpnLimit;               //[W]
-  uint16_t StapmCurrentLimit;           //[W]
-  uint32_t ApuPower;                    //[mW]
-  uint32_t dGpuPower;                   //[mW]
-
-  uint16_t VddTdcValue;                 //[mA]
-  uint16_t SocTdcValue;                 //[mA]
-  uint16_t VddEdcValue;                 //[mA]
-  uint16_t SocEdcValue;                 //[mA]
-
-  uint16_t InfrastructureCpuMaxFreq;    //[MHz]
-  uint16_t InfrastructureGfxMaxFreq;    //[MHz]
-
-  uint16_t SkinTemp;
-  uint16_t DeviceState;
-  uint16_t CurTemp;                     //[centi-Celsius]
-  uint16_t FilterAlphaValue;            //[m]
-
-  uint16_t AverageGfxclkFrequency;
-  uint16_t AverageFclkFrequency;
-  uint16_t AverageGfxActivity;
-  uint16_t AverageSocclkFrequency;
-  uint16_t AverageVclkFrequency;
-  uint16_t AverageVcnActivity;
-  uint16_t AverageDRAMReads;          //Filtered DF Bandwidth::DRAM Reads
-  uint16_t AverageDRAMWrites;         //Filtered DF Bandwidth::DRAM Writes
-  uint16_t AverageSocketPower;        //Filtered value of CurrentSocketPow=
er
-  uint16_t AverageCorePower[2];       //Filtered of [sum of CorePower[8] p=
er ccx])
-  uint16_t AverageCoreC0Residency[16]; //Filtered of [average C0 residency=
 % per core]
-  uint16_t spare1;
-  uint32_t MetricsCounter;            //Counts the # of metrics table para=
meter reads per update to the metrics table, i.e. if the metrics table upda=
te happens every 1 second, this value could be up to 1000 if the smu collec=
ted metrics data every cycle, or as low as 0 if the smu was asleep the whol=
e time. Reset to 0 after writing.
-} SmuMetrics_legacy_t;
-
 //ISP tile definitions
 typedef enum {
   TILE_XTILE =3D 0,         //ONO0
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 01f2ab456724..d8f8ad0e7137 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -229,6 +229,8 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
                smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_=
V14_0_2;
                break;
        case IP_VERSION(14, 0, 0):
+               if ((smu->smc_fw_version < 0x5d3a00))
+                       dev_warn(smu->adev->dev, "The PMFW version(%x) is b=
ehind in this
+BIOS!\n", smu->smc_fw_version);
                smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_=
V14_0_0;
                break;
        default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index c36fc10b63c8..03b38c3a9968 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -156,15 +156,10 @@ static int smu_v14_0_0_init_smc_tables(struct smu_con=
text *smu)
                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
        SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-       if (smu->smc_fw_version > 0x5d3500) {
-               SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMet=
rics_t),
-                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-               smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_t), =
GFP_KERNEL);
-       } else {
-               SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMet=
rics_legacy_t),
-                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-               smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_lega=
cy_t), GFP_KERNEL);
-       }
+       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+               PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
+       smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_t), GFP_KERN=
EL);
        if (!smu_table->metrics_table)
                goto err0_out;
        smu_table->metrics_time =3D 0;
@@ -177,10 +172,7 @@ static int smu_v14_0_0_init_smc_tables(struct smu_cont=
ext *smu)
        if (!smu_table->watermarks_table)
                goto err2_out;

-       if (smu->smc_fw_version > 0x5d3500)
-               smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_met=
rics_v3_0);
-       else
-               smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_met=
rics_v2_1);
+       smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v3_=
0);
        smu_table->gpu_metrics_table =3D kzalloc(smu_table->gpu_metrics_tab=
le_size, GFP_KERNEL);
        if (!smu_table->gpu_metrics_table)
                goto err3_out;
@@ -242,13 +234,13 @@ static int smu_v14_0_0_get_smu_metrics_data(struct sm=
u_context *smu,

        switch (member) {
        case METRICS_AVERAGE_GFXCLK:
-               *value =3D metrics->AverageGfxclkFrequency;
+               *value =3D metrics->GfxclkFrequency;
                break;
        case METRICS_AVERAGE_SOCCLK:
-               *value =3D metrics->AverageSocclkFrequency;
+               *value =3D metrics->SocclkFrequency;
                break;
        case METRICS_AVERAGE_VCLK:
-               *value =3D metrics->AverageVclkFrequency;
+               *value =3D metrics->VclkFrequency;
                break;
        case METRICS_AVERAGE_DCLK:
                *value =3D 0;
@@ -257,25 +249,25 @@ static int smu_v14_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
                *value =3D 0;
                break;
        case METRICS_AVERAGE_FCLK:
-               *value =3D metrics->AverageFclkFrequency;
+               *value =3D metrics->FclkFrequency;
                break;
        case METRICS_AVERAGE_GFXACTIVITY:
-               *value =3D metrics->AverageGfxActivity >> 8;
+               *value =3D metrics->GfxActivity / 100;
                break;
        case METRICS_AVERAGE_VCNACTIVITY:
-               *value =3D metrics->AverageVcnActivity >> 8;
+               *value =3D metrics->VcnActivity / 100;
                break;
        case METRICS_AVERAGE_SOCKETPOWER:
        case METRICS_CURR_SOCKETPOWER:
-               *value =3D (metrics->AverageSocketPower & 0xff00) +
-               ((metrics->AverageSocketPower & 0xff) * 100 >> 8);
+               *value =3D (metrics->SocketPower / 1000 << 8) +
+               (metrics->SocketPower % 1000 / 10);
                break;
        case METRICS_TEMPERATURE_EDGE:
-               *value =3D (metrics->GfxTemperature >> 8) *
+               *value =3D metrics->GfxTemperature / 100 *
                SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                break;
        case METRICS_TEMPERATURE_HOTSPOT:
-               *value =3D (metrics->SocTemperature >> 8) *
+               *value =3D metrics->SocTemperature / 100 *
                SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
                break;
        case METRICS_THROTTLER_STATUS:
@@ -317,107 +309,6 @@ static int smu_v14_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
        return ret;
 }

-static int smu_v14_0_0_legacy_get_smu_metrics_data(struct smu_context *smu=
,
-                                           MetricsMember_t member,
-                                           uint32_t *value)
-{
-       struct smu_table_context *smu_table =3D &smu->smu_table;
-
-       SmuMetrics_legacy_t *metrics =3D (SmuMetrics_legacy_t *)smu_table->=
metrics_table;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_get_metrics_table(smu, NULL, false);
-       if (ret)
-               return ret;
-
-       switch (member) {
-       case METRICS_AVERAGE_GFXCLK:
-               *value =3D metrics->GfxclkFrequency;
-               break;
-       case METRICS_AVERAGE_SOCCLK:
-               *value =3D metrics->SocclkFrequency;
-               break;
-       case METRICS_AVERAGE_VCLK:
-               *value =3D metrics->VclkFrequency;
-               break;
-       case METRICS_AVERAGE_DCLK:
-               *value =3D metrics->DclkFrequency;
-               break;
-       case METRICS_AVERAGE_UCLK:
-               *value =3D metrics->MemclkFrequency;
-               break;
-       case METRICS_AVERAGE_GFXACTIVITY:
-               *value =3D metrics->GfxActivity / 100;
-               break;
-       case METRICS_AVERAGE_FCLK:
-               *value =3D metrics->AverageFclkFrequency;
-               break;
-       case METRICS_AVERAGE_VCNACTIVITY:
-               *value =3D metrics->UvdActivity;
-               break;
-       case METRICS_AVERAGE_SOCKETPOWER:
-               *value =3D (metrics->AverageSocketPower << 8) / 1000;
-               break;
-       case METRICS_CURR_SOCKETPOWER:
-               *value =3D (metrics->CurrentSocketPower << 8) / 1000;
-               break;
-       case METRICS_TEMPERATURE_EDGE:
-               *value =3D metrics->GfxTemperature / 100 *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-               break;
-       case METRICS_TEMPERATURE_HOTSPOT:
-               *value =3D metrics->SocTemperature / 100 *
-               SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-               break;
-       case METRICS_THROTTLER_STATUS:
-               *value =3D metrics->ThrottlerStatus;
-               break;
-       case METRICS_VOLTAGE_VDDGFX:
-               *value =3D metrics->Voltage[0];
-               break;
-       case METRICS_VOLTAGE_VDDSOC:
-               *value =3D metrics->Voltage[1];
-               break;
-       case METRICS_SS_APU_SHARE:
-               /* return the percentage of APU power with respect to APU's=
 power limit.
-                * percentage is reported, this isn't boost value. Smartshi=
ft power
-                * boost/shift is only when the percentage is more than 100=
.
-                */
-               if (metrics->StapmOpnLimit > 0)
-                       *value =3D  (metrics->ApuPower * 100) / metrics->St=
apmOpnLimit;
-               else
-                       *value =3D 0;
-               break;
-       case METRICS_SS_DGPU_SHARE:
-               /* return the percentage of dGPU power with respect to dGPU=
's power limit.
-                * percentage is reported, this isn't boost value. Smartshi=
ft power
-                * boost/shift is only when the percentage is more than 100=
.
-                */
-               if ((metrics->dGpuPower > 0) &&
-                   (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
-                       *value =3D (metrics->dGpuPower * 100) /
-                                (metrics->StapmCurrentLimit - metrics->Sta=
pmOpnLimit);
-               else
-                       *value =3D 0;
-               break;
-       default:
-               *value =3D UINT_MAX;
-               break;
-       }
-
-       return ret;
-}
-
-static int smu_v14_0_0_common_get_smu_metrics_data(struct smu_context *smu=
,
-                                           MetricsMember_t member,
-                                           uint32_t *value)
-{
-       if (smu->smc_fw_version > 0x5d3500)
-               return smu_v14_0_0_get_smu_metrics_data(smu, member, value)=
;
-       else
-               return smu_v14_0_0_legacy_get_smu_metrics_data(smu, member,=
 value);
-}
-
 static int smu_v14_0_0_read_sensor(struct smu_context *smu,
                                   enum amd_pp_sensors sensor,
                                   void *data, uint32_t *size)
@@ -429,69 +320,69 @@ static int smu_v14_0_0_read_sensor(struct smu_context=
 *smu,

        switch (sensor) {
        case AMDGPU_PP_SENSOR_GPU_LOAD:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_AVERAGE_GFXA=
CTIVITY,
                                                       (uint32_t *)data);
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_AVERAGE_SOCK=
ETPOWER,
                                                       (uint32_t *)data);
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_CURR_SOCKETP=
OWER,
                                                       (uint32_t *)data);
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_EDGE_TEMP:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_TEMPERATURE_=
EDGE,
                                                       (uint32_t *)data);
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_TEMPERATURE_=
HOTSPOT,
                                                       (uint32_t *)data);
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_GFX_MCLK:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_AVERAGE_UCLK=
,
                                                       (uint32_t *)data);
                *(uint32_t *)data *=3D 100;
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_GFX_SCLK:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_AVERAGE_GFXC=
LK,
                                                       (uint32_t *)data);
                *(uint32_t *)data *=3D 100;
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_VDDGFX:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_VOLTAGE_VDDG=
FX,
                                                       (uint32_t *)data);
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_VDDNB:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_VOLTAGE_VDDS=
OC,
                                                       (uint32_t *)data);
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_SS_APU_SHARE:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_SS_APU_SHARE=
,
                                                       (uint32_t *)data);
                *size =3D 4;
                break;
        case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
-               ret =3D smu_v14_0_0_common_get_smu_metrics_data(smu,
+               ret =3D smu_v14_0_0_get_smu_metrics_data(smu,
                                                       METRICS_SS_DGPU_SHAR=
E,
                                                       (uint32_t *)data);
                *size =3D 4;
@@ -588,7 +479,7 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_c=
ontext *smu,
        if (ret)
                return ret;

-       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 3, 0);

        gpu_metrics->temperature_gfx =3D metrics.GfxTemperature;
        gpu_metrics->temperature_soc =3D metrics.SocTemperature; @@ -597,32=
 +488,33 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *=
smu,
                sizeof(uint16_t) * 16);
        gpu_metrics->temperature_skin =3D metrics.SkinTemp;

-       gpu_metrics->average_gfx_activity =3D metrics.AverageGfxActivity;
-       gpu_metrics->average_vcn_activity =3D metrics.AverageVcnActivity;
+       gpu_metrics->average_gfx_activity =3D metrics.GfxActivity;
+       gpu_metrics->average_vcn_activity =3D metrics.VcnActivity;
        memcpy(&gpu_metrics->average_ipu_activity[0],
-               &metrics.AverageIpuBusy[0],
+               &metrics.IpuBusy[0],
                sizeof(uint16_t) * 8);
        memcpy(&gpu_metrics->average_core_c0_activity[0],
-               &metrics.AverageCoreC0Residency[0],
+               &metrics.CoreC0Residency[0],
                sizeof(uint16_t) * 16);
-       gpu_metrics->average_dram_reads =3D metrics.AverageDRAMReads;
-       gpu_metrics->average_dram_writes =3D metrics.AverageDRAMWrites;
+       gpu_metrics->average_dram_reads =3D metrics.DRAMReads;
+       gpu_metrics->average_dram_writes =3D metrics.DRAMWrites;

-       gpu_metrics->average_socket_power =3D metrics.AverageSocketPower;
+       gpu_metrics->average_socket_power =3D metrics.SocketPower;
        gpu_metrics->average_ipu_power =3D metrics.IpuPower;
        gpu_metrics->average_apu_power =3D metrics.ApuPower;
+       gpu_metrics->average_gfx_power =3D metrics.GfxPower;
        gpu_metrics->average_dgpu_power =3D metrics.dGpuPower;
-       gpu_metrics->average_core_power =3D metrics.AverageCorePower;
-       memcpy(&gpu_metrics->core_power[0],
+       gpu_metrics->average_all_core_power =3D metrics.AllCorePower;
+       memcpy(&gpu_metrics->average_core_power[0],
                &metrics.CorePower[0],
                sizeof(uint16_t) * 16);

-       gpu_metrics->average_gfxclk_frequency =3D metrics.AverageGfxclkFreq=
uency;
-       gpu_metrics->average_socclk_frequency =3D metrics.AverageSocclkFreq=
uency;
-       gpu_metrics->average_vpeclk_frequency =3D metrics.AverageVpeclkFreq=
uency;
-       gpu_metrics->average_fclk_frequency =3D metrics.AverageFclkFrequenc=
y;
-       gpu_metrics->average_vclk_frequency =3D metrics.AverageVclkFrequenc=
y;
-       gpu_metrics->average_ipuclk_frequency =3D metrics.AverageIpuclkFreq=
uency;
+       gpu_metrics->average_gfxclk_frequency =3D metrics.GfxclkFrequency;
+       gpu_metrics->average_socclk_frequency =3D metrics.SocclkFrequency;
+       gpu_metrics->average_vpeclk_frequency =3D metrics.VpeclkFrequency;
+       gpu_metrics->average_fclk_frequency =3D metrics.FclkFrequency;
+       gpu_metrics->average_vclk_frequency =3D metrics.VclkFrequency;
+       gpu_metrics->average_ipuclk_frequency =3D metrics.IpuclkFrequency;

        memcpy(&gpu_metrics->current_coreclk[0],
                &metrics.CoreFrequency[0],
@@ -638,68 +530,6 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_=
context *smu,
        return sizeof(struct gpu_metrics_v3_0);  }

-static ssize_t smu_v14_0_0_get_legacy_gpu_metrics(struct smu_context *smu,
-                                               void **table)
-{
-       struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct gpu_metrics_v2_1 *gpu_metrics =3D
-               (struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
-       SmuMetrics_legacy_t metrics;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_get_metrics_table(smu, &metrics, true);
-       if (ret)
-               return ret;
-
-       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
-
-       gpu_metrics->temperature_gfx =3D metrics.GfxTemperature;
-       gpu_metrics->temperature_soc =3D metrics.SocTemperature;
-       memcpy(&gpu_metrics->temperature_core[0],
-               &metrics.CoreTemperature[0],
-               sizeof(uint16_t) * 8);
-       gpu_metrics->temperature_l3[0] =3D metrics.L3Temperature[0];
-       gpu_metrics->temperature_l3[1] =3D metrics.L3Temperature[1];
-
-       gpu_metrics->average_gfx_activity =3D metrics.GfxActivity;
-       gpu_metrics->average_mm_activity =3D metrics.UvdActivity;
-
-       gpu_metrics->average_socket_power =3D metrics.CurrentSocketPower;
-       gpu_metrics->average_gfx_power =3D metrics.Power[0];
-       gpu_metrics->average_soc_power =3D metrics.Power[1];
-       memcpy(&gpu_metrics->average_core_power[0],
-               &metrics.CorePower[0],
-               sizeof(uint16_t) * 8);
-
-       gpu_metrics->average_gfxclk_frequency =3D metrics.GfxclkFrequency;
-       gpu_metrics->average_socclk_frequency =3D metrics.SocclkFrequency;
-       gpu_metrics->average_uclk_frequency =3D metrics.MemclkFrequency;
-       gpu_metrics->average_fclk_frequency =3D metrics.MemclkFrequency;
-       gpu_metrics->average_vclk_frequency =3D metrics.VclkFrequency;
-       gpu_metrics->average_dclk_frequency =3D metrics.DclkFrequency;
-
-       memcpy(&gpu_metrics->current_coreclk[0],
-               &metrics.CoreFrequency[0],
-               sizeof(uint16_t) * 8);
-
-       gpu_metrics->throttle_status =3D metrics.ThrottlerStatus;
-       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
-
-       *table =3D (void *)gpu_metrics;
-
-       return sizeof(struct gpu_metrics_v2_1);
-}
-
-static ssize_t smu_v14_0_0_common_get_gpu_metrics(struct smu_context *smu,
-                                     void **table)
-{
-
-       if (smu->smc_fw_version > 0x5d3500)
-               return smu_v14_0_0_get_gpu_metrics(smu, table);
-       else
-               return smu_v14_0_0_get_legacy_gpu_metrics(smu, table);
-}
-
 static int smu_v14_0_0_mode2_reset(struct smu_context *smu)  {
        int ret;
@@ -928,7 +758,7 @@ static int smu_v14_0_0_get_current_clk_freq(struct smu_=
context *smu,
                return -EINVAL;
        }

-       return smu_v14_0_0_common_get_smu_metrics_data(smu, member_type, va=
lue);
+       return smu_v14_0_0_get_smu_metrics_data(smu, member_type, value);
 }

 static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu, @@ -12=
30,7 +1060,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D=
 {
        .read_sensor =3D smu_v14_0_0_read_sensor,
        .is_dpm_running =3D smu_v14_0_0_is_dpm_running,
        .set_watermarks_table =3D smu_v14_0_0_set_watermarks_table,
-       .get_gpu_metrics =3D smu_v14_0_0_common_get_gpu_metrics,
+       .get_gpu_metrics =3D smu_v14_0_0_get_gpu_metrics,
        .get_enabled_mask =3D smu_cmn_get_enabled_mask,
        .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
        .set_driver_table_location =3D smu_v14_0_set_driver_table_location,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 6e57c94379a9..001a5cf09657 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1004,6 +1004,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8=
_t frev, uint8_t crev)
        case METRICS_VERSION(2, 4):
                structure_size =3D sizeof(struct gpu_metrics_v2_4);
                break;
+       case METRICS_VERSION(3, 0):
+               structure_size =3D sizeof(struct gpu_metrics_v3_0);
+               break;
        default:
                return;
        }
--
2.25.1

