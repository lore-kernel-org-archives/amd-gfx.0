Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6372DC32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 07:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F85920673
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 07:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C+60oLvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F85920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92E16E3B0;
	Thu,  9 Jan 2020 07:35:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0E86E3B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 07:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WepSKgzGkuNMTREdGtuA0rIJhjeFb8MQGFf2kGjzvLmljSqsSrEvKUBUqnjmfhuQEO9UaJU75ue0Qg1h6syOoKD/pqN5W27HjNNQVuYAhdqHsbd1FIwKfviDfV43ezrZaeESN/kyvxRySu2jOmGDLKWe1BQvJHIC+w+IEr/nNJUeBcZtWClt/SYmkgmMTZKnQliEzgltoFYrNvK0y5g4tyvJSUiG+MuuPPBrw+eOD1R7c7X/gZWEmdnv2cb/296RayvUzhL7/2EYZeOV9O9llcFPlv6b5bcKEOzyt4SHkcqY0/RkP9J0xr0mmDsMCd5QY+a3KpiC66rWcnKj+JIIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99xcJbcJAfyglvU/4e1mDUwF5cx/ZA4iT6QpWPlCgg4=;
 b=jhYtkzRsRxOd737lhD7Wrr7BO/yj8NUWBDlAtOWHQhnvl7zRrTZFoTt3T9c8+jhMXa/1K/LIf/jQ0tZLI6MTrFEYDWihmybW1jmdDaIZCFSkcTS7uQEK355hxIqzM226LVToFm4q/klsgZROXWdoX5cdavA3YHhDPQrb92HfRAu12FgwAsak+Hdthw5nLCSu+fx8qvfxyoApIBY8Uqc9DXuEXss8Y16C12YMWBIlVPp4EcNe/ePTBXEgZ/2Am+nmrjoT6jUURFyVfpG9keMhyKkXuIa5fQ5epndAmGJ2nxVooPylYjmkzWeRr8VRenipx53CTqWd91aAKOlon5yLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99xcJbcJAfyglvU/4e1mDUwF5cx/ZA4iT6QpWPlCgg4=;
 b=C+60oLvOI9Tk3BVPGDtCD7GwoSWUkqKX71K6o8h8gGLPo94pSW5LqMwnMNdyo8+f2eOQ2tn9KdrYYkSZnY/THIqapQGv6Z9W85kYobN4Fj6s9CU1gKsgANDhuVUWD+YG+iA368bSov85uMV8scgNpb4BVa/zzi2PMVxFDcz0cWI=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3040.namprd12.prod.outlook.com (20.178.243.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 07:35:06 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.016; Thu, 9 Jan 2020
 07:35:06 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/powerplay: sw ctf for arcturus
Thread-Topic: [PATCH v2] drm/amd/powerplay: sw ctf for arcturus
Thread-Index: AQHVxrw63RgOUuOl7k2Cy0nzVkWyI6fh8QuA
Date: Thu, 9 Jan 2020 07:35:06 +0000
Message-ID: <MN2PR12MB3344788A692B53750BC2C889E4390@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1578553969-30579-1-git-send-email-kenneth.feng@amd.com>
In-Reply-To: <1578553969-30579-1-git-send-email-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3046c02b-1051-42c3-a58e-0000f1841156;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-09T07:34:43Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d4693d7-c091-4421-08e4-08d794d672b7
x-ms-traffictypediagnostic: MN2PR12MB3040:|MN2PR12MB3040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB304076379DFCCBC2AFBBFE4EE4390@MN2PR12MB3040.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(13464003)(316002)(6506007)(26005)(33656002)(55016002)(110136005)(9686003)(5660300002)(52536014)(53546011)(66446008)(66556008)(66476007)(66946007)(64756008)(76116006)(478600001)(86362001)(8676002)(81156014)(81166006)(2906002)(71200400001)(4326008)(7696005)(186003)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3040;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDEiU6Q+dQ6nj+rw1wDIRhLQe4VBahr6OT3YNaToGhy9m24tc1KM0dnEO4qEege8Shb1wGocjrfD2AGU0ZcnMLgF4eSqgCyoaE8czc+x/H6AqWiPvuuInasS2igUtyxSdyRr6askDfXMhP1auZTbsKv2M86IpOe1CyKrcP54phpGTzTtL88ZRkjU5pPsAhhHCYDZ8EOW2HshHYKYhAnpHE/QciyK/FiUUnsujKgAjHDtWVaqXklgvQicbXRNIYJzy02TBIjAsKMX/PFbqe2UL9e/pVSYS1vx75fSuGyqNukZLIykVk3ZEVFEErAXaznAA/yNfpNwiw0OYn7koIS2uFeeZrCihKPN64ehERE3W6041FtwLWr/j28LYZ8EYM/ZqTMTMKLZxRf5Jz1Lm8+Vd1XI9RYDls58R6PlQ3wWcDnPiTYn1/JKW0ZKD7XpJdENBrFwDycipR7UYgFxKcjdjnheYh4CwGwdZpUdBsA96V5N9vUXKAhz5AwRweW5LIQq
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4693d7-c091-4421-08e4-08d794d672b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 07:35:06.3655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucU4A8xnfaxAl+jLCeoe73U680zQ0ys7IvDlPKcgrBCAZVbCSMCuwjlqlRjmNpoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Thursday, January 9, 2020 3:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Subject: [PATCH v2] drm/amd/powerplay: sw ctf for arcturus
> 
> change the sw ctf setting to smu_v11_0_set_thermal_range()
> since software_shutdown_temp shares the same definition and
> name in all the smu11 project.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index e804f98..76bddd5 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1154,11 +1154,12 @@ static int smu_v11_0_set_thermal_range(struct
> smu_context *smu,
>  	int low = SMU_THERMAL_MINIMUM_ALERT_TEMP;
>  	int high = SMU_THERMAL_MAXIMUM_ALERT_TEMP;
>  	uint32_t val;
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	struct smu_11_0_powerplay_table *powerplay_table = table_context-
> >power_play_table;
> 
>  	low = max(SMU_THERMAL_MINIMUM_ALERT_TEMP,
>  			range.min /
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
> -	high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
> -			range.max /
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES);
> +	high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
> powerplay_table->software_shutdown_temp);
> 
>  	if (low > high)
>  		return -EINVAL;
> --
> 2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
