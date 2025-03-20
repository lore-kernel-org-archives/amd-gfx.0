Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5607CC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 10:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E530410E14E;
	Thu, 20 Mar 2025 10:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="blUoWQ7H";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C33A10E14E
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 10:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9+L68wUuRRyyzoigmBHrhNX06osvvb4W5aDzVXenPe7vs2U205cPGTUbawP+NFj9XXTKgSw6iW2/nwPup4j8w8WXc+j56CByXbSFD1NPlkn+mZekQFghY9hWuS79dEx4Xier4yNQ0/uMs1Mzi4EdCvUigVbobJre9CHiZbZuXUJbC/UMjIw0EF6qXiKatytTesk1Bxq/laNQeidWKCXXq1G4+CVY4IgXt4582U48CuSKQmi8XX9cOU6zQMF/tD3lIK0robAf20fO1bOuNXUqtEy//C8P4KvMVWJ1I+SdIt/57OYWjsmWRPXKzzceslt7m5s41r0frtO1aHQ5agf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzmapDy/BBP7qaGqP5slZTPS0zq+oTzvNRcNhSjlfxY=;
 b=DDysdQiVxgeWS49vFcwtp3L9drbkQoFiK+INLUClF9b+AdE4L3/g8hnaVqinpEjVhK9T1dR0RssE6CNsRm/QwQ/msdWdD19M0wbfJCoqHFvBKqMzoKC63TOkZ+sxVs7Ui/o9DWqIgRCeCx+MzqRJmtei/Z8hN0TIl5MYQO15336IlCR8mtxSsgbRFAU2s9KvTQ7eRGGCq0WzPiqPxE97bAfBIrUoxqi3t1UZM43cCpNAuBUGA2d2IPCy/xz+X5TitCWQd5sbRPMd3ko+HzSW/QPPlNzKjTS2Lwh1bfJn0xXtdWL7/04nyyVBkmjeGaSpIOXGltV0cF5qs+rbi16azg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmapDy/BBP7qaGqP5slZTPS0zq+oTzvNRcNhSjlfxY=;
 b=blUoWQ7Hn1fHK+P2aersUVQvw+JE+4LPqEejr7RHYH/MHyMr3Twqd41MX4tr9QV+1Rrj2yZ6vZBgeYGGG1u8dWE1IvgREcIs2sqDWuYtHs8CE5R/6+1FAEPC4bbwwvHmTyGBNTM86IqRSYk30RKwaOZXX3u2kZKchAvIN4yqSGY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 10:14:59 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 10:14:59 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
Thread-Topic: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
Thread-Index: AQHbmQJsamM4FgkSRkGX+LYQv+vO+LN7z6tw
Date: Thu, 20 Mar 2025 10:14:59 +0000
Message-ID: <DS7PR12MB600553BFFA842DB4BF8370C7FBD82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
In-Reply-To: <20250319190850.3899718-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=96715cd7-b2c8-42a8-b258-ff5aaad49252;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-20T10:14:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW6PR12MB8951:EE_
x-ms-office365-filtering-correlation-id: 3dfb2a7b-7673-4f0f-afb0-08dd6798124b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cQKrs4dj2se21fBzayq7qjO3O++tvTraesocXsqiIPMUQBkdWWpZO8FB9uX3?=
 =?us-ascii?Q?HsIviUKZNgPoh4pDmZLDb3g+f0T/2aaQ5J/xh3imV5DV0qWoPTtd/OTtxwlM?=
 =?us-ascii?Q?uU6xLGtMP67ZIMJm22jXWhQ9Y3YOJ11utDBK/eyhHX29eWSsb81H+FKrOfZM?=
 =?us-ascii?Q?fp1RQ3ZXj+dOCjlW/u5+OPY83jNjr9UJpcfFzzxlUew7gstc1apIcT0b7+4Y?=
 =?us-ascii?Q?hYV1/67Gc6DHQoEaHRWTSRjxyBlCq6RIHa15OOlGUlWMKjYwkAS6rU7fZYAz?=
 =?us-ascii?Q?Tr3Q4qf87miy69QrC/fqdKwfTUxfCv7wKHACMIxiymrSJG+aDVp/QC/3SUi4?=
 =?us-ascii?Q?HVyOrs677G726mKFE0oEFKdOrmRfqPsy5ldE3bKabtHWK411nqrldm20zgMS?=
 =?us-ascii?Q?rLFFkCUg+gj9hIuHYphcCecvBXd8VDGmODmMjVN27K35F539sX5xUp3Ln42Q?=
 =?us-ascii?Q?3bi3pgeZOeKO7FIsPUvAJ71kH8kFqucntSUJIEw7Xeph6N+a+23kDt4DDUpR?=
 =?us-ascii?Q?b7MX9SYG4l3p07TIz3MAWDTFEuh1LD7wwpEw5KpyRLqTbnRApNjpt2EHpfXv?=
 =?us-ascii?Q?yVaVNw/Bg827tiA9gnljqW3IfkDqHUwd0a/F73X1n43wrMZ2PAsXtisOEBjq?=
 =?us-ascii?Q?G2J8hcd7mn7QgVmfKjak8YypaKgv/lfNeE/NcPTWuFmziPi/GwB4P9malRlF?=
 =?us-ascii?Q?9qoGI2+zMsr+cTmlFOJ6GLXnsi4eOyCfd++UufeBrLUr2SgW3NR1gtqq2Re/?=
 =?us-ascii?Q?/YI/ipsCP/C0I56tom2m0TdcpDeHvgNXJR5/iq142JmOaQIhdjC3QE1KzHz9?=
 =?us-ascii?Q?tIpdRy4Jd5CWpiee8r+7uayPsuuD/nqMbW/nBTbjUAZn9Qil8aGYx4WyrpOT?=
 =?us-ascii?Q?SfM8OI3gR19+UMs4fJu+aMDCafT4NfT4QqIVRrMXeT+Z0M85xjmaOKQMIvbu?=
 =?us-ascii?Q?TLyHKV4gaDZ3YjqGyb0NWqGzNdAegIh9wmNfGf0HvSl5XAp4AarKkDPdgVPY?=
 =?us-ascii?Q?J4vueTXOlmIThCKpCt+3WGwZzT8vrLjEG5tsV7u78p4yDOf/Hs7B3N9XM1Gc?=
 =?us-ascii?Q?xJtpZctKS9jUD+kRT1H52WRHf0Vzh8t936ytf0fMYClHb8Vq2vhOZFOD9mhT?=
 =?us-ascii?Q?5AC8gxig+52cqBQDpj2xMSuo8+2goy5oRvTdnCDNnGqhtWI44W6pKhqCTiZn?=
 =?us-ascii?Q?QIF+cgqoXgDJmmzQRIQoG7lACnA/uLxPxVzu/uQok64nWsrJ2zArnsFdjz1s?=
 =?us-ascii?Q?TpgtAfMpLRBYJpRRIQeIPH8exSN3mhnqqc3g7XXgIev4bMoLdmEBsd5z0MWz?=
 =?us-ascii?Q?uQmM99GpckqzOWxl/pzINlSH6n0SR/Gr3fjOQW9hUWv13WksxHqkOXCHNMdm?=
 =?us-ascii?Q?OhyIiYJSSu6HFs7VoAlZZMqfqy3hBbvaJ2B/UTZH5sp7IcTze+XHP5fWsLkF?=
 =?us-ascii?Q?mhYKB7vxU8nlWtO9CalIK4IETNGv4Fj/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lKRm/cTAKrPXi9fK/yz5tFjlGRmPL5jDulIRjrW1qHXHE01lgOQB2P8gLZlN?=
 =?us-ascii?Q?CaMXsAYKKufwHzTrTIE8VBpx91cdmB8Z1VK93KVzPF54LJoEVyuZgZj3bdOl?=
 =?us-ascii?Q?PYl7zyI9XWJHxf/bfq0E1KxqVfNjFGk9fb0NnlhOk1tnpdjb/Ra9GWczNonU?=
 =?us-ascii?Q?OPzJ909nM4JZ4/kkgX1R1yKw9GIbL3DAkDVTlOU501e06kKHOfkQcEiAUgGH?=
 =?us-ascii?Q?LQzBexY1qdQGSmtcR4JClyJQPPMUX+U0azgV0l/pnM+dXPHYlTRIuejHbXrU?=
 =?us-ascii?Q?eEm9jzhSV84j/8Oee65aTefaBdIRGnkKkQkEhOow+tBCppjxBITcWg4XEbs/?=
 =?us-ascii?Q?wWC6sq7TixQVdpOGFlMMuZ6irApYw9UMv7ahARLAbQvDWwTRbty01lepNhv+?=
 =?us-ascii?Q?Kyz7DvJq2Rjj+PaflyG9IMDLM1d+E8L20SAZqvnx1BLyL+7dX8jpDAfgNogF?=
 =?us-ascii?Q?UcmaIWyUq/HIQRxLrO8x6VX0gr7Pq+WIPSOFob91FWPR4QBDjuXM9aZcJbbd?=
 =?us-ascii?Q?I6oKyyo6P7YY2yEIpb+Su8tIZCCIPfUkVg+FBUVErkWRtqg7ZP/VH+83qPD7?=
 =?us-ascii?Q?28ine35T/cjbw+/2QHKY3yy4wImqkN1DeODIvgRuFSCNazf/K33E+QWjNXE0?=
 =?us-ascii?Q?2WQF+ihSelAg+9mF/Y+Af+x4zkmRoqUP1vuNOzt3bPpc3pXdaHC6qBr/xacx?=
 =?us-ascii?Q?8EjNdVEy2usTQQE/4irYPaegqP5ujSZn3/b2kINn++2pTJucjPlldABuVrTp?=
 =?us-ascii?Q?YoFV5GFjFDVel4BUH7BXm3RywtOvRbyWAr6tInca7TS5dFt+wxEVpGTUlT5c?=
 =?us-ascii?Q?3y1QkzEZvstrveG+OwCHmzQ4cD0Z8q8VRJb9oql5mZ9YJAb1r66g9NijCgkJ?=
 =?us-ascii?Q?zHnMngDU2XA/FdOUljk9Ox8x3fYC+gYXrp4ddi48UzzI+fab2hDQgbne6V3i?=
 =?us-ascii?Q?cROGu7iz17eQ/6nwDd89KPBPdIldb93zXOJL56pQl+kIF73Ik8zQHKt8HBPK?=
 =?us-ascii?Q?n1nfO4iCGP1qh6WTyaj1B62MeYHpLfPqb0ibwVFE85BwKyfautVsALmbptlx?=
 =?us-ascii?Q?xzJp/DeC9Rnt11Yc2+5AED98ZaGgd3ZdsZfTF5vQZVmRisGNT3GhnHdwKGNd?=
 =?us-ascii?Q?P+vs1kYOi7LG4flaG9YKtfY9BkomLAULhxtXrzWOg94NTYoXevvMsW6bJMnK?=
 =?us-ascii?Q?wP4cvR9UKUvAPkKlcxjN636QepoUkYqMjF5/Pn4HXww5mtpTW7cc+tYYl0EX?=
 =?us-ascii?Q?J7HVVo4bzKkM/0KYg9d/FaR4w7rXo2x+B5s1poPhm2a1TZ87e+a/mPEAgOcX?=
 =?us-ascii?Q?D9gAMt6PaomNxXFJJjeH6zeb/HelFrkYQNkd8u80Mt/IcRk5P+QQnebygT5Z?=
 =?us-ascii?Q?xV6a6JbQYP9cdHThbFwhA2Wl4B4dI5Chq3356Mpe0331MMcpElA5mtVhyx1o?=
 =?us-ascii?Q?tWNsWRnivR+jZprtWAYMucltHiKBtdnTgLIJyPCF1I5d88Bd87hi6DtiX6tb?=
 =?us-ascii?Q?AA3jxanvQZQfUG6w9Xmb5Mme6qMjl8Xz0wPoiq9aCD8NC6geDyjJxyUV322X?=
 =?us-ascii?Q?7z0Kr4S6Vtalv/9UN70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfb2a7b-7673-4f0f-afb0-08dd6798124b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 10:14:59.6060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSx0ps502CJeYDXlpiMlGZnlkscyprmEjggwXIFW4nUpPcV1mw5t7XpcntEsWrjQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
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

[Public]

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 20, 2025 3:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Shaoyun
> <Shaoyun.Liu@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
>
> Break when we get to the end of the supported pipes rather than continuin=
g the
> loop.
>
> Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 3b83880f9e2cc..10f14bf925778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -132,7 +132,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
>               /* use only 1st MEC pipes */
>               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
> -                     continue;
> +                     break;
>               adev->mes.compute_hqd_mask[i] =3D 0xc;
>       }
>
> --
> 2.48.1

