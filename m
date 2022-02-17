Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2725C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 11:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8420A10E8D0;
	Thu, 17 Feb 2022 11:48:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8FA10E8C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 11:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyEo1a5ooINx+PzzMMxX8srgoMGIJxsyIvmsxa5cheNOC4Fpdw9aPna8IwVWs+q191yg0xj7Kt/m2vWXg/pOhMgG44eSpwqEWQ6xLTdIFWsQEUo0X0hX9TqZziEc+9md0ByA3VGyKmzvagACwFnsAePqq7pRUi9VVHdGqp40x2b6SJaTCoMwWqL66y9HIj2B9tj3oUsRixx0tFSbvMgE4RufX1KVdPFZ5UlPHbfbB+o9Az0yOcELAMBzEaTAu93pHlBQrJDoPL1l3MFG7aRzYvcI4grU9u43H7FpUSC5Jm46lRfcT+mf8oMU1Y/zm5pqSFmjRquDnqDPjrbySIFA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmJLnkWRUF6seOZLjzzkQo7IXIgKFtjs2YAKLMUK0Xk=;
 b=E0G1vu5VcbCz0JcGq0liiYFde1cVrvsAC2GgYUbHLZ+vf3qbMzSKqe45I2/Pg2vh9Rzzg+kYBlJQW1YzBCKy906hiVCGc54WMVRomu6nHd7R/vWFmfRT5h9CgIC7kmXLbaAcRXVEF8va6Fk6h8vvV6rhd3hgmWc/jh7GStgmRydMpLjx4Intrc1ZK/zJNG/bPYct01kcsXmUlbYixsFylqBhkAC8Dpr/qTpFmG/4lGR3+lt7z6E9+Z4SPte68AzhDcrKRWLQ2Rdmzq/DouUTgQUWmPcwasQ37f+kmW3ItqjoMeqEOlVdtpFXkiBrrscz/nwXMV9XUXO4XSeoFw0zFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmJLnkWRUF6seOZLjzzkQo7IXIgKFtjs2YAKLMUK0Xk=;
 b=ihVphyDRRgtv3hLeA1jGoOmNfpJKzpuN2SO87EJY1K6TZgd2f1sk6Us2u+fzQ1xELsnsCwJgQigtmhofQ35VqURNG2JiB85rBMAVqs2O5tNNB/jGYLKs5+6sDrrFMMSojfZaeWguRrIkHsFnfINw8ok9wQrrTnEAJr+JUlqj3T0=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 11:48:02 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4%5]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 11:48:02 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs data
 (v2)
Thread-Topic: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs data
 (v2)
Thread-Index: AQHYIsZaec6A0XT/AUK/vPEDdUcKpqyWP7kAgAFjAzc=
Date: Thu, 17 Feb 2022 11:48:02 +0000
Message-ID: <DM6PR12MB35479A4ADD38A52F0B79A77EF7369@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220215234701.1560356-1-tom.stdenis@amd.com>
 <CADnq5_ND4xDQR_ut59rQoMfJhKvniVF9vGyjpqr1QroacR5YJg@mail.gmail.com>
In-Reply-To: <CADnq5_ND4xDQR_ut59rQoMfJhKvniVF9vGyjpqr1QroacR5YJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-17T11:48:02.163Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 7da765a8-1252-d274-ff58-595456c424ab
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5ecead4-ea4a-48aa-9e5d-08d9f20b5a9c
x-ms-traffictypediagnostic: DM6PR12MB3179:EE_
x-microsoft-antispam-prvs: <DM6PR12MB31796EEA8F0FF0298C7673B7F7369@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4Dn58jEa483yKPqTNMjYnz7WaOWot7y7FPvgsmFjFpWQIhJDu7DMX4WhGsATLRj4j1z81yvsO4AEK4BpVdRW8X5G9i2d2FxLeMA4jO6rky6ISh9CNXNlhcKiWtqHrDyl6fz+anVIl0qDJCgOuuv9gQ7hPExbPCIW/CnMR3WBRq0gNPDimBZM3NJC6GYY/efaO7FUYIXp8nu68ZqMrcGflytpP63Eg0KjLQutV+zQvjeNgQg4mRXIlQAOniw1dAsltIc6yCtxYfg39hZa0dGDAfp46O4WRH9Qa2WtDze7VkjzytTJvrQEWWOY3jml5WZXWeArxgW2ZhmSe/B08gbWiq4/A/Aaso/5UHLFfQnOkPgfGKfyQlSZgO/IqyDDl44NYLirtugRiiA88PyYwfj5OulxlKIh0nQLRUbzHsezn9i1o7kLlxUqA+z0dAS0VgZVPRALTJjK1Fwym4+akpoNob2dRCjiFHV6HQ5WVm4vm/RLk8ckhUiSRO273Wi2CS6NXCCj5jyeTn1a5J8EXEncjoStwL16tNYHV2VjgivYjfePXYQhukEbU1cRxDtvHBxoL1vS5KpmodYxg7XM/ArxDg732KkanKPJF1kTytKdwIjvx2EJdZJaUNcZGCR56YZv0ZAAH8j9QqgHqfq8TouZ0FM/Aa1Xx4EjehAvuaZQRPFrveAHrYKpy4dhvHNA/TC3Cldfx8l6AdKokgFx7CF2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(66446008)(4326008)(91956017)(33656002)(83380400001)(52536014)(8936002)(9686003)(53546011)(64756008)(86362001)(8676002)(5660300002)(186003)(71200400001)(7696005)(66476007)(55016003)(66946007)(38070700005)(38100700002)(316002)(122000001)(508600001)(76116006)(6506007)(66556008)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gtn0LtRsEDLWabYibGiZBD5XN+zxhYDMJtmwNJWy4u0HdPYAtZJeOg2xwC?=
 =?iso-8859-1?Q?RzPabScuOWaQlu1AjPKSnSRb3Rmy6VetBosv7sb9/or4Mzk3Z9SBVmXY9h?=
 =?iso-8859-1?Q?nplqwKdQkKP6pnULR0PaSRXY5M1wvm+Z/FjinNB1C2zoUvSrfUB1FdoAE3?=
 =?iso-8859-1?Q?GYEPa7JBcFnQgOV0w1uJY6u3G2H0zQHO3rEfinpVIoyRxJE3TOyz8fj/XR?=
 =?iso-8859-1?Q?wQrkvU1Z2t6FSUo8g3/pxFW0bFn/AbF3+oIC8yc+MBvXOXRVRRcUp0M/Fv?=
 =?iso-8859-1?Q?0eUccgvZ+AY23I8rqeDPHRfMkZ0Q6ECCRpfjNNiDDj4NiNyiMANPDOcT7Q?=
 =?iso-8859-1?Q?eoP9ufuOgSArwg4uPNbhSFg7/eTgbU+0LUIJLFA0dT4dOjwbxLKHez8QjJ?=
 =?iso-8859-1?Q?1KKSSvsOZtqEKpvLJgxOtZmgsuIVtJ4X2RODv0ajG42tSOpUzIxoQp9i+7?=
 =?iso-8859-1?Q?mzZHkRORtg3R/zqUH2EPE/0rqDPOQAfMtypo3GTkAf2RlKP11yo+7o/TTw?=
 =?iso-8859-1?Q?vL0rtSNFcSV6+WjXYIyQCiepQvyURRYb1R6snbrbbx7kj3tt/QnNE4wJR/?=
 =?iso-8859-1?Q?FMFUhyTsWpNUXXjnBKI5Xa0qI6pjMSzP729FiznuyoVrHRVA4bOSnookZz?=
 =?iso-8859-1?Q?LPmlsvWKjyYKwq+cgYoUVO0B5SqbTugGCKUyakztt88YFBWgOZw8z6iRIh?=
 =?iso-8859-1?Q?d0QY6SH0FHhjbcd/I/vvg4+bNWthz7MzjXeVDbsd6LjhAq2bj7h3ZY3PQj?=
 =?iso-8859-1?Q?RkgxAWN2L10oaUteWfKv59zv1oaFxEo+VyjmVIDyaeNmWLft3lfV0NuH8E?=
 =?iso-8859-1?Q?+re6oi8sPP5eFhVPjqAfspzXHhcKQzpIm7Mx8WEJPOfWag0a6CxYRKeDHh?=
 =?iso-8859-1?Q?r1ig0HmVMUI0Gj00MGDAhd8cKN3bNIVPnTzyRFBuvN/qWcrIx6EtfUVCvn?=
 =?iso-8859-1?Q?lRrbRHCVeuuddYlnxX8G4Ek75zqTAPS0o7CNBXQSFDgtHowW3Bz9qhJAmm?=
 =?iso-8859-1?Q?8CjhVFwzTtpZf6Xaq9nnS9J/o6PXpM3SgkoGyjun6aUQAv5HiWG/YlEI6s?=
 =?iso-8859-1?Q?vtmy+3fouuqYI0N5qQA39H+HpoHd/np6IuplSXs2pNw4IaZygZbuWb8b2U?=
 =?iso-8859-1?Q?+ReAKUWXtyQzfprl3xhyci6In4tHJwhLylfGIFupXTbHsCwJCBY+bNCDxm?=
 =?iso-8859-1?Q?+xv6kVJolQr53TCHShWf7eade2yHlaGNKlRos4RzDb6WH/ukb5o0ihtVCM?=
 =?iso-8859-1?Q?qXlEracZU243liwBxXMyxhHSdMLCqH8+trkkdSJLXHuGJV9tbSnb1ZjIVJ?=
 =?iso-8859-1?Q?xPAi5H/swc4Fs7sHNkLeBjHoUnakKtzJM+QNDdusK8qYOkfqanBLbPsSXr?=
 =?iso-8859-1?Q?y0/pac9y9LDhCgLyAQgjeslIZALeCS1XrGwYOPgtwbDP9C8IGBQRFrscxI?=
 =?iso-8859-1?Q?QaoIqZbDO4OIit0pQMZZCLE8fvtSCBdg8yMw03ZQ0hxoaHm7/7AilG68OC?=
 =?iso-8859-1?Q?m7ZjXC7V6LiJKSGW3kjy9mfbEoPNCIBaX5pnb+eOyJIQZDft0qQ3lHC8sA?=
 =?iso-8859-1?Q?FFADZ19q8aF83JXZ5ysE/2WuIGNEaSC+5UncqrthH6yCFcxSH02ZE9d4NR?=
 =?iso-8859-1?Q?xKbbhEMMq03gdpaHX5DHdMBn3yNyls8PLXOSqriOi+JUrU/BBDbfJw1eg/?=
 =?iso-8859-1?Q?1n8Ofk6CAq/ALvXQQMZp7y8TxQH/o89+4iaK5LAhxiZDkZo4YOwEpAXvOo?=
 =?iso-8859-1?Q?3CpM7XuIsbqbQhXsAUuEvs2dc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ecead4-ea4a-48aa-9e5d-08d9f20b5a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 11:48:02.6692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jpm6l+Ir3Rewz0Rn8nmYcZn9+c4HUnH5x8sZmFQ2qgrqKPlJy0DKH1JjOjhg7spMFyKAlYNuNJXq2QVhtBb9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

umr uses the config debugfs during init anyways so adding apu status here i=
nstead of fetching it out of DRM makes sense (for umr).

I'll send a v3.

Tom

________________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, February 16, 2022 09:36
To: StDenis, Tom
Cc: amd-gfx list
Subject: Re: [PATCH] drm/amd/amdgpu: Add APU flag to gca_config debugfs dat=
a (v2)

On Tue, Feb 15, 2022 at 6:47 PM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Needed by umr to detect if ip discovered ASIC is an APU or not.
>
> (v2): Remove asic type from packet it's not strictly needed
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 4b950de9bf66..8f0ca71862b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -728,7 +728,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct =
file *f, char __user *buf,
>                 return -ENOMEM;
>
>         /* version, increment each time something is added */
> -       config[no_regs++] =3D 3;
> +       config[no_regs++] =3D 4;
>         config[no_regs++] =3D adev->gfx.config.max_shader_engines;
>         config[no_regs++] =3D adev->gfx.config.max_tile_pipes;
>         config[no_regs++] =3D adev->gfx.config.max_cu_per_sh;
> @@ -768,6 +768,9 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct =
file *f, char __user *buf,
>         config[no_regs++] =3D adev->pdev->subsystem_device;
>         config[no_regs++] =3D adev->pdev->subsystem_vendor;
>
> +       /* rev=3D=3D4 asic_type and APU flag */

Fix the comment here. Also, we already expose the APU flag as
AMDGPU_IDS_FLAGS_FUSION via the AMDGPU_INFO_DEV_INFO query to the INFO
ioctl.  If you already use that, you should already have this.  If
not, with the comment fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +       config[no_regs++] =3D adev->flags & AMD_IS_APU ? 1 : 0;
> +
>         while (size && (*pos < no_regs * 4)) {
>                 uint32_t value;
>
> --
> 2.32.0
>
