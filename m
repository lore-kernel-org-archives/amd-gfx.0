Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9183EC44515
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 14:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFEA89C46;
	Mon, 20 Jul 2026 14:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qm5drVK+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FE389C46
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 14:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxEWoJiZeO/hFHu2o9uDrIqjEO0VJpoyOyBX+karwgARAZVrVelBgLv9y1BXUJps4qgEhiqo4HEy4inRedVE+DF9uXHBANbXGtDVPjK6n3dht8Aqk26svSgWs6juCDkyVE2ab1HgbQFx5XaUAGo5b7fXBJRMRmTrqNa/l7PV82JaoaTZ0ULDcElDQqbOzjmVuLwYPfzrv6e81l5Kk11ppMIeBrClO7oXU3oxIlT4Vnxvki7zBWPNxqRr4uJ/CLdLo8KKYjRK0Aqbx78fl9RCqozsSOy7Ne4TWxmZ3NFMQnZIS8xy+RqXz9XuBHctdddcozWIiTBzPCZAPjX0+cLjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJNdYRNNrwDCmoU7JdlWMRlwvVC6fLyACMmPYbv9Yk4=;
 b=PV4fG/FBY3vXIz2foG8qlcgEf1J+EdvZHcYTeL8p0J72wSiruvEXIPHggpupwqvPqBHgG+w+iS8JEU0j8JozZqiUo2o0yK/9NB5xc61s6oivBzIsYbzxQuKF1qdpf/W6PizKJol+DEok0pQu9t87KVP4XDJ06vq+LlCs9aNbHBnhjDXaRa3hzLX+huEJL7rGjl0ZdtqQTORj6bwVbAqP42awtWFOGazbUymoMJ3eKTsmc8T80E5bheqtHoUC+bzLWJuxJoRifyFLs4y83TzqpsK6eFlv+41jBcYI3iFNnz21R7ylanvUDUCBDWXl0s6rqEd8zkGzdIGPBNdEM9Ma0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJNdYRNNrwDCmoU7JdlWMRlwvVC6fLyACMmPYbv9Yk4=;
 b=Qm5drVK+vDNzwZhkE6CIsGOS5tFFbGSy7ioeNJF1xacPWz+y77nEMGE+Z0jYzRUw7vTJ6rh+BU0itR4IdK2Y0ed6xcn+hcEG69ZzlHGUogm5KKcocYw+SvOly4MFWrGfYBBwUMzeqJTu84oGKf8dFouycjUfjKBaNfkoR+rNKwo=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:48:15 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 14:48:14 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Soliman, Fares" <Fares.Soliman@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liang, Richard qi" <Richardqi.Liang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Topic: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
 gather GFXOFF residency logs
Thread-Index: AQHdEstEdRhluHIiQUCJy/qwMVU2rrZyPpaAgAAdhACABCuIAA==
Date: Mon, 20 Jul 2026 14:48:14 +0000
Message-ID: <BL1PR12MB58989742E91D30239AF0231785C32@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260713132624.1173426-1-Fares.Soliman@amd.com>
 <BN9PR12MB51464FFC1E39FC0777D45524F7C62@BN9PR12MB5146.namprd12.prod.outlook.com>
 <BL4PR12MB948066C4AA3E7F79D3569773EBC62@BL4PR12MB9480.namprd12.prod.outlook.com>
In-Reply-To: <BL4PR12MB948066C4AA3E7F79D3569773EBC62@BL4PR12MB9480.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-17T21:20:06.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DM4PR12MB7669:EE_
x-ms-office365-filtering-correlation-id: 8ef3e2b7-c009-42e5-ff6a-08dee66dedbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|8096899003|38070700021|10067099003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: RI8M/MmJ1O1PaNJ3OBxblX3h+6Obs00BGQsYcaUXamctjbwMj/FIN/sJIm21RmYDkxl/W4RVhLNySpuzhBb1kLLDunWsvyauCxXTabpOfv2Ubg2TIZbPhUhgVKklyCk36tgO3W13najzUBlmDksGK3iRxBOy/iLvDoBP8Yh/9eD1G5SFNYRBpxR/Dcb7YRqrS1jb/H1aCQsdH5w1+XFZhkle2+wx8LyD6MrpIu4eNECr1SGN7UppLlfeksIpPSCqldwARRH+z32cYSvqEb/RakojK1qinAoodvD6Ki0YUNcpK8VF43km0AHjtH7ukc8RQ1w/WCHfsvmCMWF/TfXTOF8tdO0uLmhRjsGamHzr6Zt2wHUWnP/w5CKAklUZC/vjhnbQnf6LHbCX04DHozmxduipTl5CfivYxcHHFHtxlacqyhQWEr3e2pWhcq3fxQ0m9BUnlXrSbfQMwRpcUo5YpLjqpiekbiQlwl8rGS6uvofyODybyAumkvSguqywxOTRUpoepMJcXrDGfaQSwdSgr3Umez+uLZu80Ti2JMpeFfugRQoAbG2sfSiHTAKYuUnigWNLhMcONWcO6/ZOvm2vEqQiE9dZq5G2oSZoGCOt4nzggTMPzaJTmpnF/9YCM1QvC9iLC+eKSUinX2bik/Gbn4XqDQ79h9NzqqP/3i0txL4y12pV3nOF4kEaCpOojmowP0+9us906my/tQO4WuChMid+jmOvcLRaWLz2lFQwF1U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(8096899003)(38070700021)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rRHZlMB1hhS84i2n9Dz4AHQQqG4Bnc0iQ6JrGba7wBgRcoPn8klBavXNDSif?=
 =?us-ascii?Q?RFBVzTJKuU0BkyZ3ukOxbATTkIt8fKStPyQH0RQVlewQJw3o4pxZM0DC0giX?=
 =?us-ascii?Q?UYanR7ej1FWhGIPk9fLiMrb2gtI0/SHkwkyaUOQBK1nycsoibZjSN25uGGy7?=
 =?us-ascii?Q?0D75L1pM2PphmPJV8mCzi1/nsP31PkKnFGCRrzVrTtnX0l0BMmGTOXrpsiN0?=
 =?us-ascii?Q?OUfUzeimE+fHiOQemnd4Y95Pa/pmv98GvCc5m6v0lnTsofWdTf8xd9NMAz8X?=
 =?us-ascii?Q?2KtdiiJqRpQRxdtVEpdyaFgh/yL8G2+1WUp+WcwvfG2VwI1opjhpfqIEMsMb?=
 =?us-ascii?Q?0lsKvjCszpFlaF61cI3RKD9fF8wR4pkIg7qKDG5HL1Il4uMUlhrCQxCPyfi+?=
 =?us-ascii?Q?Jr0dFr/1kYvaEn1+xq1atnN//dmyvPSMM1oi2TU2875pymJYluupK/CE9gfT?=
 =?us-ascii?Q?/g71stVRoDvpptHc2N3ys8tYw83o7OyZjvTL0j0eH9E3PYhMm+kVqQ0wqJnp?=
 =?us-ascii?Q?wxSGly+hts1LIQPX9NXMBkmGACvqTh96txzgWIJT4teIClpsKsnspRmz7ULj?=
 =?us-ascii?Q?83t5nhmrT1zOA2CuDS5Dp1/oilZTwY+/7oWt4llSCr7sIe3jQZ2rzaGDxVhu?=
 =?us-ascii?Q?5tKu5iqhuneRqzYAqipgpL0DOrsogE1jWT6ngXoP6F2fab+xMFFUfhZUMRgS?=
 =?us-ascii?Q?rEcwuwWSRNNDj6HXkPtaiIUgqoYPtNSBS0LopPVVtynk8b4I2ki/3gPMzUeH?=
 =?us-ascii?Q?kqwh2bFc4GDcxLQemIY5l2Bek0pHfL70QCNK9nZAnZ/Udp9TDSStEhwn4ScS?=
 =?us-ascii?Q?g1rZIB9cHILQI/dj1sxBlAKMXjQMtaT3dOE818j62zr9dHKFtHksIH5ICrzh?=
 =?us-ascii?Q?aKg4UrhlT08NQY/Sme0wI0QbNBT9zkAl3OO6P9Et3lTcYkFLgVCBXZmUtfcN?=
 =?us-ascii?Q?DL+H7EDOc7xlp0qOL1pW8FrhSGtlSzVj9b1hCs1YX08EUfDg4z6mFzPtgYTX?=
 =?us-ascii?Q?AzIw8kIcQXRKA3ZepAq37MW0hqEazdcecTqz+1e3Iqt/9NIRjHtxrVB6J7rg?=
 =?us-ascii?Q?zlO6fanH7x8mp1OxfBsJdkEGXNdRsN5eUBRYmcyMQ5pN0AV8R4fjqxzF+kez?=
 =?us-ascii?Q?GBDAzBtzYTEGq+chbubHo1FTyjYDrXXkS/vgPIWRZDthi9cjiYe9Qn8uUrPw?=
 =?us-ascii?Q?tZLOnGvFQWDl1O7BEn6V6jyhQptmjDDgPTUpcQzG6TGfWB3IwjawtHG1MJno?=
 =?us-ascii?Q?MJjKk0ro1K4I7qjf6NIdcj7I7IkIbmsEkREdysCMjvU43JWbApdPWe7LqycX?=
 =?us-ascii?Q?ylxZg1TgCFCDYE271eDV499vAGeAVWVVC4bnuuaFuzH7ahgIPKBW+Le5EfKu?=
 =?us-ascii?Q?i+l8sLs9uuk0igKu00Pq2Nur3v18i2fpXYUA6ieVbBIhhBmqAhe9L8uO+gXG?=
 =?us-ascii?Q?YnEm0jS3dNwooRH443SWMzSoflXnw5g3vDIx2v9WgOVZZ8X03eW2m5oDwzPJ?=
 =?us-ascii?Q?IuKQhBiWrc+CqVmo13dqBChhcy9SahD4+SOHtzE4V/88uewEjDHMxgEJ6yYe?=
 =?us-ascii?Q?EBIZZTw4j8YksE0pvl4QtmZqMK1RGaOP2LK0bP4CG9EpTMVQhQMuFSmLJSK1?=
 =?us-ascii?Q?+sMHHOacg/p0smep0Frnk1qgs7CdhMyAoyuwvODYmeIs3m5SD1/p3bTZE52w?=
 =?us-ascii?Q?rboo5+rXkDr6wEYPSvybZkqaPHgtWF0jEXCg85A7MdRUlppa?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB58989742E91D30239AF0231785C32BL1PR12MB5898namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef3e2b7-c009-42e5-ff6a-08dee66dedbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 14:48:14.7634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5uHOkk7z9Y/6IlbmRWH23YUGqtRleQq7xyjZ3zXd0IwNEJXf51LnvCitAnQzBCh7E4WF11Up2+23UciME2LCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
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

--_000_BL1PR12MB58989742E91D30239AF0231785C32BL1PR12MB5898namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Public

Either Acked-by or Reviewed-by are sufficient for merging.

Kent

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Soliman,=
 Fares
Sent: July 17, 2026 7:06 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Liang, Richard qi <Richardqi.Liang@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly=
 gather GFXOFF residency logs

Some people who received this message don't often get email from fares.soli=
man@amd.com<mailto:fares.soliman@amd.com>. Learn why this is important<http=
s://aka.ms/LearnAboutSenderIdentification>

Public

Thanks Alex,

Forgive me if this is obvious, but is an Acked-by tag sufficient to have th=
is pushed or will I have to get it reviewed by an additional developer?

Thanks,
Fares

________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Friday, 17 July 2026 17:20:27
To: Soliman, Fares <Fares.Soliman@amd.com<mailto:Fares.Soliman@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liang, Richard qi <Richardqi.Liang@amd.com<mailto:Richardqi.Liang@amd.c=
om>>; Soliman, Fares <Fares.Soliman@amd.com<mailto:Fares.Soliman@amd.com>>
Subject: RE: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly=
 gather GFXOFF residency logs

Public

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of Fares
> Soliman
> Sent: Monday, July 13, 2026 9:26 AM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Liang, Richard qi <Richardqi.Liang@amd.com<mailto:Richardqi.Liang@amd=
.com>>; Soliman, Fares
> <Fares.Soliman@amd.com<mailto:Fares.Soliman@amd.com>>
> Subject: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctly
> gather GFXOFF residency logs
>
> Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs on
> Van Gogh. Logs are now gathered live rather than starting then stopping
> logging and reading an average value afterwards. This is in accordance to
> changes made in PMFW.
>
> In regards to messageID 0x52, the old interface uses a start/stop paramet=
er,
> and the new one doesn't. The firmware is checked to determine which metho=
d
> to use.
>
> v2: added firmware guard to new interface, old interface kept as fallback
>
> Signed-off-by: Fares Soliman <Fares.Soliman@amd.com<mailto:Fares.Soliman@=
amd.com>>

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  6 ++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
> .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 50
> +++++++++++++++----
>  5 files changed, 50 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 5c4d4ff001ea..46514a1faf1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file
> *f, char __user *buf,
>   * @size: Number of bytes to read
>   * @pos:  Offset to seek to
>   *
> - * Read the last residency value logged. It doesn't auto update, one nee=
ds to
> - * stop logging before getting the current value.
> + * Read a live GFXOFF residency sample from firmware. One needs to
> + start logging
> + * before getting the current value.
>   */
>  static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char
> __user *buf,
>                                                   size_t size, loff_t *po=
s)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index f8fd93999617..d94e3dcf7f9a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1333,7 +1333,7 @@ struct pptable_funcs {
>       u32 (*set_gfx_off_residency)(struct smu_context *smu, bool start);
>
>       /**
> -      * @get_gfx_off_residency: Average GFXOFF residency % during the
> logging interval
> +      * @get_gfx_off_residency: Live GFXOFF residency percentage
>        */
>       u32 (*get_gfx_off_residency)(struct smu_context *smu, uint32_t
> *residency);
>
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..4206514765cd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -110,8 +110,10 @@
>  #define PPSMC_MSG_GetSlowPPTLimit                      0x4C
>  #define PPSMC_MSG_GetGfxOffStatus                   0x50
>  #define PPSMC_MSG_GetGfxOffEntryCount                       0x51
> -#define PPSMC_MSG_LogGfxOffResidency                0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_GfxOffResidencyLogReadSample              0x52
> +#define PPSMC_MSG_StopGfxOffResidencyLogging          0x53
> +#define PPSMC_MSG_StartGfxOffResidencyLogging                 0x56
> +#define PPSMC_Message_Count                            0x57
>
>  //Argument for PPSMC_MSG_GfxDeviceDriverReset  enum { diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 636ff90923d9..acf03838d49d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -252,7 +252,9 @@
>       __SMU_DUMMY_MAP(DriverMode2Reset), \
>       __SMU_DUMMY_MAP(GetGfxOffStatus),                \
>       __SMU_DUMMY_MAP(GetGfxOffEntryCount),            \
> -     __SMU_DUMMY_MAP(LogGfxOffResidency),                    \
> +     __SMU_DUMMY_MAP(StartGfxOffResidencyLogging),           \
> +     __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample),
>       \
> +     __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),            \
>       __SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),
>       \
>
>       __SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel)
> , \
>       __SMU_DUMMY_MAP(AllowGpo),      \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 717ba46c8933..1104f8b05b29 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -72,6 +72,12 @@ static const struct smu_feature_bits
> vangogh_dpm_features =3D {
>       }
>  };
>
> +/*
> + * SMU support new GFXOFF residency log interface since version
> +4.63.62.00,
> + * use this to get live readings of GFXOFF residency  */ #define
> +SUPPORT_LIVE_RESIDENCY_MSG_VERSION 0x043f3e00
> +
>  static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,
>               0),
>       MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,
>               0),
> @@ -142,7 +148,9 @@ static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(GetSlowPPTLimit,
> PPSMC_MSG_GetSlowPPTLimit,
>       0),
>       MSG_MAP(GetGfxOffStatus,
> PPSMC_MSG_GetGfxOffStatus,                                            0),
>       MSG_MAP(GetGfxOffEntryCount,
> PPSMC_MSG_GetGfxOffEntryCount,                                        0),
> -     MSG_MAP(LogGfxOffResidency,
> PPSMC_MSG_LogGfxOffResidency,                                 0),
> +     MSG_MAP(StartGfxOffResidencyLogging,
> PPSMC_MSG_StartGfxOffResidencyLogging,        0),
> +     MSG_MAP(GfxOffResidencyLogReadSample,
> PPSMC_MSG_GfxOffResidencyLogReadSample,       0),
> +     MSG_MAP(StopGfxOffResidencyLogging,
> PPSMC_MSG_StopGfxOffResidencyLogging,         0),
>  };
>
>  static struct cmn2asic_mapping
> vangogh_feature_mask_map[SMU_FEATURE_COUNT] =3D { @@ -2450,19
> +2458,32 @@ static int vangogh_set_power_limit(struct smu_context *smu,
> static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool
> start)  {
>       int ret =3D 0;
> -     u32 residency;
>       struct amdgpu_device *adev =3D smu->adev;
>
>       if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>               return 0;
>
> -     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_LogGfxOffResidency,
> -                                           start, &residency);
> -     if (ret)
> -             return ret;
> +     if (smu->smc_fw_version <
> SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
> +             u32 residency;
> +
> +             ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_GfxOffResidencyLogReadSample,
> +                                                     start, &residency);
> +             if (ret)
> +                     return ret;
>
> -     if (!start)
> -             adev->gfx.gfx_off_residency =3D residency;
> +             if (!start)
> +                     adev->gfx.gfx_off_residency =3D residency;
> +     } else {
> +             if (start) {
> +                     ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_StartGfxOffResidencyLogging, NULL);
> +                     if (ret)
> +                             return ret;
> +             } else {
> +                     ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_StopGfxOffResidencyLogging, NULL);
> +                     if (ret)
> +                             return ret;
> +             }
> +     }
>
>       return ret;
>  }
> @@ -2479,11 +2500,20 @@ static u32 vangogh_set_gfxoff_residency(struct
> smu_context *smu, bool start)
>   */
>  static u32 vangogh_get_gfxoff_residency(struct smu_context *smu, uint32_=
t
> *residency)  {
> +     int ret =3D 0;
>       struct amdgpu_device *adev =3D smu->adev;
>
> -     *residency =3D adev->gfx.gfx_off_residency;
> +     if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> +             return 0;
> +
> +     if (smu->smc_fw_version <
> SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {
> +             *residency =3D adev->gfx.gfx_off_residency;
> +     } else {
> +             ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_GfxOffResidencyLogReadSample,
> +                                                             residency);
> +     }
>
> -     return 0;
> +     return ret;
>  }
>
>  /**
> --
> 2.43.0

--_000_BL1PR12MB58989742E91D30239AF0231785C32BL1PR12MB5898namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-CA" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
Public<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Either Ac=
ked-by or Reviewed-by are sufficient for merging.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Kent<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt;
<b>On Behalf Of </b>Soliman, Fares<br>
<b>Sent:</b> July 17, 2026 7:06 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Liang, Richard qi &lt;Richardqi.Liang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to co=
rrectly gather GFXOFF residency logs<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" align=3D"left" width=3D"100%" style=3D"width:100.0%">
<tbody>
<tr>
<td width=3D"0" style=3D"width:.3pt;background:#A6A6A6;padding:5.25pt 1.5pt=
 5.25pt 1.5pt">
</td>
<td width=3D"100%" style=3D"width:100.0%;background:#EAEAEA;padding:5.25pt =
3.75pt 5.25pt 11.25pt;aspect-ratio: revert !important;background:revert !im=
portant;block-size: revert !important;border:revert !important;bottom: reve=
rt !important;color:revert !important;color-scheme: revert !important;conte=
nt-visibility: revert !important;cursor:revert !important;direction:revert =
!important;display:revert !important;font-size:revert !important;height:rev=
ert !important;hyphens: revert !important;letter-spacing:revert !important;=
line-height:revert !important;margin:revert !important;opacity: revert !imp=
ortant;order: revert !important;outline: revert !important;overflow:revert =
!important;padding:revert !important;position:revert !important;resize: rev=
ert !important;rotate: revert !important;scale: revert !important;tab-size:=
 revert !important;table-layout:revert !important;text-align:revert !import=
ant;text-indent:revert !important;text-orientation: revert !important;text-=
overflow: revert !important;text-shadow:revert !important;text-transform:re=
vert !important;text-wrap: revert !important;top:revert !important;transiti=
on: revert !important;user-select: revert !important;vertical-align:revert =
!important;visibility:revert !important;white-space:revert !important;width=
:revert !important;word-break:revert !important;word-spacing:revert !import=
ant;writing-mode:revert !important;zoom: revert !important">
<div>
<p class=3D"MsoNormal" style=3D"mso-element:frame;mso-element-frame-hspace:=
2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-el=
ement-anchor-horizontal:column;mso-height-rule:exactly">
<span style=3D"font-size:9.0pt;font-family:&quot;Segoe UI&quot;,sans-serif;=
color:#212121">Some people who received this message don't often get email =
from
<a href=3D"mailto:fares.soliman@amd.com">fares.soliman@amd.com</a>. <a href=
=3D"https://aka.ms/LearnAboutSenderIdentification">
Learn why this is important</a> <o:p></o:p></span></p>
</div>
</td>
<td width=3D"75" style=3D"width:56.25pt;background:#EAEAEA;padding:5.25pt 3=
.75pt 5.25pt 3.75pt;aspect-ratio: revert !important;background:revert !impo=
rtant;block-size: revert !important;border:revert !important;bottom: revert=
 !important;color:revert !important;color-scheme: revert !important;content=
-visibility: revert !important;cursor:revert !important;direction:revert !i=
mportant;display:revert !important;font-size:revert !important;height:rever=
t !important;hyphens: revert !important;letter-spacing:revert !important;li=
ne-height:revert !important;margin:revert !important;opacity: revert !impor=
tant;order: revert !important;outline: revert !important;overflow:revert !i=
mportant;padding:revert !important;position:revert !important;resize: rever=
t !important;rotate: revert !important;scale: revert !important;tab-size: r=
evert !important;table-layout:revert !important;text-align:revert !importan=
t;text-indent:revert !important;text-orientation: revert !important;text-ov=
erflow: revert !important;text-shadow:revert !important;text-transform:reve=
rt !important;text-wrap: revert !important;top:revert !important;transition=
: revert !important;user-select: revert !important;vertical-align:revert !i=
mportant;visibility:revert !important;white-space:revert !important;width:r=
evert !important;word-break:revert !important;word-spacing:revert !importan=
t;writing-mode:revert !important;zoom: revert !important;align: left !impor=
tant">
</td>
</tr>
</tbody>
</table>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">Public<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks Alex,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">Forgive me if this is ob=
vious, but is an Acked-by tag sufficient to have this pushed or will I have=
 to get it reviewed by an additional developer?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Fares<o:p></o:p></span><=
/p>
<div id=3D"ms-outlook-mobile-body-separator-line">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Deuche=
r, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deu=
cher@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, 17 July 2026 17:20:27<br>
<b>To:</b> Soliman, Fares &lt;<a href=3D"mailto:Fares.Soliman@amd.com">Fare=
s.Soliman@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liang, Richard qi &lt;<a href=3D"mailto:Richardqi.Liang@amd.com"=
>Richardqi.Liang@amd.com</a>&gt;; Soliman, Fares &lt;<a href=3D"mailto:Fare=
s.Soliman@amd.com">Fares.Soliman@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to co=
rrectly gather GFXOFF residency logs</span>
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">Public<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Fares<br>
&gt; Soliman<br>
&gt; Sent: Monday, July 13, 2026 9:26 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Liang, Richard qi &lt;<a href=3D"mailto:Richardqi.Liang@amd.com">R=
ichardqi.Liang@amd.com</a>&gt;; Soliman, Fares<br>
&gt; &lt;<a href=3D"mailto:Fares.Soliman@amd.com">Fares.Soliman@amd.com</a>=
&gt;<br>
&gt; Subject: [PATCH v2] drm/amdgpu: Update message IDs to PMFW to correctl=
y<br>
&gt; gather GFXOFF residency logs<br>
&gt;<br>
&gt; Updates PPSMC_MSGs and set/get functions for gathering GFXOFF logs on<=
br>
&gt; Van Gogh. Logs are now gathered live rather than starting then stoppin=
g<br>
&gt; logging and reading an average value afterwards. This is in accordance=
 to<br>
&gt; changes made in PMFW.<br>
&gt;<br>
&gt; In regards to messageID 0x52, the old interface uses a start/stop para=
meter,<br>
&gt; and the new one doesn't. The firmware is checked to determine which me=
thod<br>
&gt; to use.<br>
&gt;<br>
&gt; v2: added firmware guard to new interface, old interface kept as fallb=
ack<br>
&gt;<br>
&gt; Signed-off-by: Fares Soliman &lt;<a href=3D"mailto:Fares.Soliman@amd.c=
om">Fares.Soliman@amd.com</a>&gt;<br>
<br>
Acked-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">ale=
xander.deucher@amd.com</a>&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&nbsp; =
4 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |&nbsp; 2 +-<br>
&gt;&nbsp; .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 6 ++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp; |&nbsp; 4 +-<=
br>
&gt; .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c&nbsp; | 50<br>
&gt; +++++++++++++++----<br>
&gt;&nbsp; 5 files changed, 50 insertions(+), 16 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; index 5c4d4ff001ea..46514a1faf1f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt; @@ -1320,8 +1320,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct fi=
le<br>
&gt; *f, char __user *buf,<br>
&gt;&nbsp;&nbsp; * @size: Number of bytes to read<br>
&gt;&nbsp;&nbsp; * @pos:&nbsp; Offset to seek to<br>
&gt;&nbsp;&nbsp; *<br>
&gt; - * Read the last residency value logged. It doesn't auto update, one =
needs to<br>
&gt; - * stop logging before getting the current value.<br>
&gt; + * Read a live GFXOFF residency sample from firmware. One needs to<br=
>
&gt; + start logging<br>
&gt; + * before getting the current value.<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file =
*f, char<br>
&gt; __user *buf,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; size_t size, loff_t *pos)<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; index f8fd93999617..d94e3dcf7f9a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; @@ -1333,7 +1333,7 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*set_gfx_off_residency)(struc=
t smu_context *smu, bool start);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_gfx_off_residency: Average GFXO=
FF residency % during the<br>
&gt; logging interval<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_gfx_off_residency: Live GFXOFF =
residency percentage<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_gfx_off_residency)(struc=
t smu_context *smu, uint32_t<br>
&gt; *residency);<br>
&gt;<br>
&gt; diff --git<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
&gt; index 7471e2df2828..4206514765cd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h<br>
&gt; @@ -110,8 +110,10 @@<br>
&gt;&nbsp; #define PPSMC_MSG_GetSlowPPTLimit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x4C<br>
&gt;&nbsp; #define PPSMC_MSG_GetGfxOffStatus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x50<br>
&gt;&nbsp; #define PPSMC_MSG_GetGfxOffEntryCount&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x51<br>
&gt; -#define PPSMC_MSG_LogGfxOffResidency&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x52<br>
&gt; -#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x53<br>
&gt; +#define PPSMC_MSG_GfxOffResidencyLogReadSample&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x52<br>
&gt; +#define PPSMC_MSG_StopGfxOffResidencyLogging&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x53<br>
&gt; +#define PPSMC_MSG_StartGfxOffResidencyLogging&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
56<br>
&gt; +#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x57<br>
&gt;<br>
&gt;&nbsp; //Argument for PPSMC_MSG_GfxDeviceDriverReset&nbsp; enum { diff =
--git<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; index 636ff90923d9..acf03838d49d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; @@ -252,7 +252,9 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DriverMode2Reset),=
 \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetGfxOffStatus),&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetGfxOffEntryCoun=
t),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(LogGfxOffResidency),&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(StartGfxOffResidencyLogging)=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GfxOffResidencyLogReadSample=
),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(StopGfxOffResidencyLogging),=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetNumBadMemoryPag=
esRetired),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetBadMemoryPagesR=
etiredFlagsPerChannel)<br>
&gt; , \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(AllowGpo),&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; index 717ba46c8933..1104f8b05b29 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; @@ -72,6 +72,12 @@ static const struct smu_feature_bits<br>
&gt; vangogh_dpm_features =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; +/*<br>
&gt; + * SMU support new GFXOFF residency log interface since version<br>
&gt; +4.63.62.00,<br>
&gt; + * use this to get live readings of GFXOFF residency&nbsp; */ #define=
<br>
&gt; +SUPPORT_LIVE_RESIDENCY_MSG_VERSION 0x043f3e00<br>
&gt; +<br>
&gt;&nbsp; static struct cmn2asic_msg_mapping<br>
&gt; vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(TestMessage,&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TestMessage,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSmuVersion,&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PPSMC_MSG_GetSmuVersion,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0),<br>
&gt; @@ -142,7 +148,9 @@ static struct cmn2asic_msg_mapping<br>
&gt; vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetSlowPPTLimit,<br>
&gt; PPSMC_MSG_GetSlowPPTLimit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetGfxOffStatus,<br>
&gt; PPSMC_MSG_GetGfxOffStatus,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GetGfxOffEntryCount,<br>
&gt; PPSMC_MSG_GetGfxOffEntryCount,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(LogGfxOffResidency,<br>
&gt; PPSMC_MSG_LogGfxOffResidency,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(StartGfxOffResidencyLogging,<br>
&gt; PPSMC_MSG_StartGfxOffResidencyLogging,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxOffResidencyLogReadSample,<br>
&gt; PPSMC_MSG_GfxOffResidencyLogReadSample,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(StopGfxOffResidencyLogging,<br>
&gt; PPSMC_MSG_StopGfxOffResidencyLogging,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static struct cmn2asic_mapping<br>
&gt; vangogh_feature_mask_map[SMU_FEATURE_COUNT] =3D { @@ -2450,19<br>
&gt; +2458,32 @@ static int vangogh_set_power_limit(struct smu_context *smu=
,<br>
&gt; static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool<=
br>
&gt; start)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 residency;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu=
-&gt;adev;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp;=
 PP_GFXOFF_MASK))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,=
<br>
&gt; SMU_MSG_LogGfxOffResidency,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, &amp;residency);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt;<br>
&gt; SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u32 residency;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_GfxOffResidencyLogReadSample,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; start, &amp;residency);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!start)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.gfx_off_residency =3D residency;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!start)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.gfx_off_re=
sidency =3D residency;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (start) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_sm=
c_msg(smu,<br>
&gt; SMU_MSG_StartGfxOffResidencyLogging, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_sm=
c_msg(smu,<br>
&gt; SMU_MSG_StopGfxOffResidencyLogging, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; @@ -2479,11 +2500,20 @@ static u32 vangogh_set_gfxoff_residency(struct=
<br>
&gt; smu_context *smu, bool start)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static u32 vangogh_get_gfxoff_residency(struct smu_context *smu,=
 uint32_t<br>
&gt; *residency)&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu=
-&gt;adev;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *residency =3D adev-&gt;gfx.gfx_off_residenc=
y;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp; PP_GFXOFF=
_MASK))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt;<br>
&gt; SUPPORT_LIVE_RESIDENCY_MSG_VERSION) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *residency =3D adev-&gt;gfx.gfx_off_residency;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_send_smc_msg(smu,<br>
&gt; SMU_MSG_GfxOffResidencyLogReadSample,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; residenc=
y);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt; --<br>
&gt; 2.43.0</span><span style=3D"font-family:&quot;Times New Roman&quot;,se=
rif"><o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB58989742E91D30239AF0231785C32BL1PR12MB5898namp_--
