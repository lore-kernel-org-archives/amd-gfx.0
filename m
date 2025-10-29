Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530A4CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D605510E7A4;
	Wed, 29 Oct 2025 11:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CZlIwSpM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6017010E7A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyiNsoHeP2m4wlYlq1wkRSJXaJLawN2BlXZNlRh3kcY5SWaAP/fMFzJtLxpSpq3+6ZZVcCZYezZNmUu5eHZB87aoqvuoAcoT7GLHi7bmKCwUFDlZseUrvU4+nRUXtdIHHSpTJw5Od1zCA32JYKzLAosKskBLv7sQARq5vpNP7boyLZvWds6gzsUSFif+OakLYMwc7PX42Q5JBuZybHmsTO+pN59VUSiyn0hzNILs/lWg+hFFDEMQQ3muNootyldDYjVMXBZRFj4fF3AYLmseJPEV/uavMWxhpBDrlcnUPWEKChFy9MQHGQkdPoXzVAsSAjxCy05+aCJiO6+rW8Vhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viRo4C8fQTB0R4D+hI3LX8gej+cl1p22RXE9FP7Lj/o=;
 b=EJ4o2jFbuwgAs0kQCkQPZpT4LATs8AyzrdbRmqzwoViBtr6QOwamV6ozkbHVtjsc39w0lB4d8O8Yb4dYlqXE0QS0aSACay0Bn+ZQ0tRPlgqAff0xcylfZEPqJkKClOaepGw/bupqedzaxETNEdODYSHvzTjdER8yYS+f1tYN5vuPjGPa6+jMsDihZyHFgG+G7m/6ak/sqk3chkOshKKWONLqDQI1jBW1QDN4letGRGjCZHJI5RLx/xeF/pSgrpZhFakdf5+jnUf3GJ5oTcrypp1q1t0NKybv50wAVac7s03DO3sc0NipeMNYmmvbduwfO7tQfBEs4pYrJwu3WpgqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viRo4C8fQTB0R4D+hI3LX8gej+cl1p22RXE9FP7Lj/o=;
 b=CZlIwSpM4V5/wSuhxlKaDcSOjlieYYHTZbwhjhQ5D1mhezCm1oic2cEkw2AglivDF9xZe3v6+Ag5WyH7IBtxpdkhajQScmYZ5tL2LE/kUDoYPHLS2AQbE4hC/HdzOMPYWU/bfoA5j6PZQpzTEfWDXHsSSnrD4CaGcS+ODFLPiho=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 11:42:32 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 11:42:32 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: : [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling
Thread-Topic: : [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling
Thread-Index: AQHcSMQWJgvHVjXqkkegV0Fgno928rTZABFQ
Date: Wed, 29 Oct 2025 11:42:32 +0000
Message-ID: <PH7PR12MB8796854ACFE67D5092A03D26B0FAA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <mailman.2815.1761735259.18618.amd-gfx@lists.freedesktop.org>
 <MW5PR12MB568409CD46E9AB4F48AFB015E5FAA@MW5PR12MB5684.namprd12.prod.outlook.com>
In-Reply-To: <MW5PR12MB568409CD46E9AB4F48AFB015E5FAA@MW5PR12MB5684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T11:00:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7340:EE_
x-ms-office365-filtering-correlation-id: b39eae27-0e5c-4f1d-4247-08de16e03f7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|4022899009|376014|1800799024|366016|38070700021|7053199007|13003099007;
x-microsoft-antispam-message-info: =?us-ascii?Q?pKwkOrM4mUi1RA5TiAkIzGx40ZHbKMpA+t0ugt2J39cC8ze5hQehJrFfPpGW?=
 =?us-ascii?Q?rPT+sBPnFQZDZ+p2I3Ev3KvABvp6tU4M+YDFKn0VCPY+LVQom6hzY8OiZrBT?=
 =?us-ascii?Q?T8xEYjnnwpMnheiPzktzM3Pfz22IjI3OXeYcUtqDd21LgcJyN1L6zJp0fguq?=
 =?us-ascii?Q?PgogrCEJIvS8+tTCp53mdW0/Ev7MBD5wYOp2C8Y6YUaHmJK3iWV5d9ee4sMJ?=
 =?us-ascii?Q?iEjQYI5d7zyYPyMXB5KDTdH3k6UU95St7dCtilZW2KpAEpcqQnnWmapQITzk?=
 =?us-ascii?Q?Wg79wfEvMfbd7XTwFL3W5BqVNsNmxamy4MQPBAASmfaQ6szwuDobIA7DxcFR?=
 =?us-ascii?Q?0HHnTOQbRbGJtHW9kjv/1KmYJ16xEyAI12dNs/g/gmZ8u3zNowQqRRyMGhHm?=
 =?us-ascii?Q?5aiubmGhj4uJ9Rt2kwE9k1CC/Dlmex54WayP4yH8NPL5IEcwiXCbAe43pNVM?=
 =?us-ascii?Q?F3H8X1z8d6ULyxXTU8Bn0HzzuTDozScPS0BvgEjSfgyd6QbLZFRvDrU0ViLk?=
 =?us-ascii?Q?WS+HbW+S5XDSCeHX+9dcQ2tDLFYxmaKQFiw4w01k8L26zUZqkuOpbp1Y5mTP?=
 =?us-ascii?Q?MECQ6qz7DimaXkcILWK0jCkH1fY1CwdC6sJu4QQmePoYTnvOqBEMc8YGQc9f?=
 =?us-ascii?Q?GDKMLizNbmT/qGl/60TFNFIlgkbjwt1i8GBWAAQROmVPEvY8moBCcuu8N0M+?=
 =?us-ascii?Q?Um+X0DBUzGuBIIlzVyUxZzxUsY6aE+0S0Fy9E/QnK5cy68ibHIiMB++35+fJ?=
 =?us-ascii?Q?0VHjKxv8r/ULi26hBxY7YwMlEsar7eDeYeyRaO40hByw78zo1bds99fWY9wY?=
 =?us-ascii?Q?xVYe5+6s1Ly38efAMzHHSZ7JZc1m1B/SPuEzcBGtyRlrOztLbk/5bccRlq1Y?=
 =?us-ascii?Q?9ZTo2WVu1P+wIV/VP9TV6GAFKZtxZiYUv9gHwWDh1dqWGBoMcL6nLU1xgNHR?=
 =?us-ascii?Q?F+eK3MBPgAi0T0hJjReYkiT4hZ6V/+3f6uBFjuR/3N+ZUAwImtOUo1PMpuUM?=
 =?us-ascii?Q?HsGX+rHAayTdzynEkB5bG+hJuYNNfiJadtVh9252rGRbfClj9vE3C2v9I0DF?=
 =?us-ascii?Q?f/2PRxdmwAVx/ALOTmpa/TRiiDWBbLhVFbsUtxuZzk2DXzh0/n9CgRHDR/Tj?=
 =?us-ascii?Q?NSS7wJdwUkmuhJjSazOa6M4GGRQN3lKAyG3rX1FxqtM+KzoGxzfVQ4JM4xv+?=
 =?us-ascii?Q?ygjZTFBjxTWvMmH12U8/vArzLAKIdvj2v0ple5PdCtbkEe6O3oeVncccMXOu?=
 =?us-ascii?Q?3vTT52bW7NKZGvC9yzglzCTwVwUXEaf9OospJlZIvHoRIrzWHU3p10j25AN3?=
 =?us-ascii?Q?zDleF4zaV9LWEoDOs3LjSezIomltz69ccXt5cyklQS1DbHxJ1PgjWxsNv6H6?=
 =?us-ascii?Q?5LQH+68EtzLSTJDo85VWcPC3umi6vIkdsnDXIr3TzHWs2viIpBfArqs95wfI?=
 =?us-ascii?Q?UnqYwNfSuS15f/NpSbpUs6/phlQff42iWKOh1cZO91N1yiyhsFdYEA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(4022899009)(376014)(1800799024)(366016)(38070700021)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xdx8h86WoWXmdfG/v+dlBRcTFOp8xVfaQC1OqrJh6Ei6Y0hlkI4OX7zDeTTL?=
 =?us-ascii?Q?JAEOrH7pLMWLH7Ew1o8vW70P5aL88JKz5mLSO9U8TCRPtmFoMPkqA13HP5VK?=
 =?us-ascii?Q?SVDnbEbq7/d6zDWyIbI4EFbWqokI9GDMG+RgRy5PFdFu7fgHSdYx9SYB03nS?=
 =?us-ascii?Q?0wPgF9mOlgdjPxlV55M5pX6Y7YZd3iPSCCgvhbja7FgtFRl5qcq4PlQgjaCb?=
 =?us-ascii?Q?pndv3EsEVhkT/o4PKNlBKnTXIRg4QSHhwuAxxXZYXlimF+HOsJsgj5kVrCJe?=
 =?us-ascii?Q?p4hrRLg5dnrsDhiizpxvviVZkjRJ4VAyqBMNKh8IKK4pSO1SWcSIkZeOWb25?=
 =?us-ascii?Q?jROkWCxH4nUlJwzZ1x0FAx1PJ7s6zw1xRC9Ii69jvqKikgi5EPrB9wAiSX52?=
 =?us-ascii?Q?xbCBw/bTtikxawXkJ9GXxkmIp/p7yFuPm/PnpfJ8z1em9F1q/PsvpcLC34Aj?=
 =?us-ascii?Q?MbxySB9xIjhXMoqyT39SerZEcA9+LDcoIed5ob8x2MhA0Etyi/YXlu20BJGx?=
 =?us-ascii?Q?WsaL0chh6WaqrAeWV23Ily2hDr/X/CbcVaOGmns17OW34Jlqb73kxZL7BEoa?=
 =?us-ascii?Q?wdGSzti6OR8vQ47SR18soEjkD16C6kZ4l1KBOGjeGOoQ3neQBkwXbeKfDyB9?=
 =?us-ascii?Q?yH+6nllPW/63q0tiFk7U49wFVoJvH7sW9QBNtx+DVo8sSu31PMBKImuFd7mq?=
 =?us-ascii?Q?g5/MCelNVdmIZQIK0dLD4Ok2uwKRlE5I4eCGrmaYzfZW5hNm3HOAqTim0kUr?=
 =?us-ascii?Q?vJfBFurPkxoKMx+eU++858gr4OQ8Tk18/9xUe6/VC0VrZnheQntJNBWNYxWt?=
 =?us-ascii?Q?ufJVRpkHDBObAHq1WtOr0n6k0kUEkFz1bsrC2UkrEdE7049rgmX5unHCLB74?=
 =?us-ascii?Q?6noSvjnDcNFtP8WQkblafA2bN+fIH73O2TBGJdqsGKEG1Zh1iV2CZWDwwFCo?=
 =?us-ascii?Q?Mxf9fI+rdq7o97jabqCDyng3KsXe/ElKhTQeRSD3rO00thKpxbSruIK7GVgI?=
 =?us-ascii?Q?CBEpDQvNvGOq/dlX4jDWqsWKAoTTcnkl6IdZklsFPSp/9XwYb/09Z72+YAn8?=
 =?us-ascii?Q?LlpNbMOGPsM/KhI87kCTKrRtk1ADRlsR+uZDWhXiSrdgSKh7Q1kw4dMdiDOv?=
 =?us-ascii?Q?2L/qXuB9y9FybQd5m+P+FGQJIJbB0uW2fPzScqZXiaPNoaaEVblhoSNIS4vO?=
 =?us-ascii?Q?L37aiAJvLtjtLqsktUS0KsLsawaQATVWjD16q6QAhIbNy29r8cTgp+CpqMjK?=
 =?us-ascii?Q?C7oQv3XWK/Y+D0Vr0Pk3crdDN6Q8EORnnyyXYFAQ4qsrES6VxKanTJvCgH3I?=
 =?us-ascii?Q?S0rvEZNwZLgZoLljq2w0yOHoKqZowGJPvRkP99uXqlQCpHrdlP1iGV4+qlqu?=
 =?us-ascii?Q?PWZj/CiBZuXefjO1DOLzN/47OQYcrTnjKE6ZsnrnNCwZHTabsaUwxSq9gE2D?=
 =?us-ascii?Q?doCz35POa4EQADAQJPXD3ipyNCgVHT6wukdY0rowirqf4wh5Q6zsRy5LNj2z?=
 =?us-ascii?Q?VUsAu31YukG6ePpudw4ZxSg2iR7eXqNpOteFcrYKpXdm95HUs8FTs22ZaSE2?=
 =?us-ascii?Q?S3rI7ughp3enDKkf+R4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39eae27-0e5c-4f1d-4247-08de16e03f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 11:42:32.6331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+KH/oLIgxobuEXkOqOE3yqXX8m+wpacR2+ZiQYQfhysfCsWrE1UAl+/nYGlL/86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Wednesday, October 29, 2025 7:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: : [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handlin=
g
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of amd-gf=
x-
> request@lists.freedesktop.org
> Sent: Wednesday, October 29, 2025 6:54 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: amd-gfx Digest, Vol 113, Issue 529
>
> Send amd-gfx mailing list submissions to
>         amd-gfx@lists.freedesktop.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> or, via email, send a message with subject or body 'help' to
>         amd-gfx-request@lists.freedesktop.org
>
> You can reach the person managing the list at
>         amd-gfx-owner@lists.freedesktop.org
>
> When replying, please edit your Subject line so it is more specific than =
"Re: Contents
> of amd-gfx digest..."
>
>
> Today's Topics:
>
>    1. [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling
>       for PMFW manages eeprom (Tao Zhou)
>    2. [PATCH 6/8] drm/amdgpu: get RAS bad page address from MCA
>       address (Tao Zhou)
>    3. Re: [PATCH 05/14] drm/amdgpu/vce: Clear VCPU BO before
>       copying firmware to it (Timur Krist?f)
>    4. Re: [PATCH 07/14] drm/amdgpu/si,cik,vi: Verify IP block when
>       querying video codecs (Timur Krist?f)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 29 Oct 2025 18:38:02 +0800
> From: Tao Zhou <tao.zhou1@amd.com>
> To: <amd-gfx@lists.freedesktop.org>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Subject: [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling
>         for PMFW manages eeprom
> Message-ID: <20251029103802.1402199-8-tao.zhou1@amd.com>
> Content-Type: text/plain
>
> Check if bad page threshold is reached and take actions accordingly.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 37 ++++++++++++++++---
>  1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index de7b268a9862..0acf45d5fc54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -896,6 +896,36 @@ int amdgpu_ras_eeprom_update_record_num(struct
> amdgpu_ras_eeprom_control *contro
>         return ret;
>  }
>
> +static int amdgpu_ras_smu_eeprom_append(struct
> +amdgpu_ras_eeprom_control *control) {
> +       struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +
> +       if (!amdgpu_ras_smu_eeprom_supported(adev))
> +               return 0;
> +
> +       control->ras_num_bad_pages =3D con->bad_page_num;
> +
> +       if (amdgpu_bad_page_threshold !=3D 0 &&
> +           control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
> +               dev_warn(adev->dev,
> +                       "Saved bad pages %d reaches threshold value %d\n"=
,
> +                       control->ras_num_bad_pages,
> + con->bad_page_cnt_threshold);
> +
> +               if (adev->cper.enabled &&
> amdgpu_cper_generate_bp_threshold_record(adev))
> +                       dev_warn(adev->dev, "fail to generate bad page
> +threshold cper records\n");
> +
> +               if ((amdgpu_bad_page_threshold !=3D -1) &&
> +                   (amdgpu_bad_page_threshold !=3D -2))
> +                       con->is_rma =3D true;
> +
> +               /* ignore the -ENOTSUPP return value */
> +               amdgpu_dpm_send_rma_reason(adev);
> Patrick:
>         In pmfw managed eeprom, rma reason is not needed, so these two li=
nes should
> be removed.
>
> Best Regards,

[Tao] thanks for the reminder, will update it.

> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
>   * @control: pointer to control structure @@ -914,17 +944,14 @@ int
> amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
>                              const u32 num)  {
>         struct amdgpu_device *adev =3D to_amdgpu_device(control);
> -       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>         int res, i;
>         uint64_t nps =3D AMDGPU_NPS1_PARTITION_MODE;
>
>         if (!__is_ras_eeprom_supported(adev))
>                 return 0;
>
> -       if (amdgpu_ras_smu_eeprom_supported(adev)) {
> -               control->ras_num_bad_pages =3D con->bad_page_num;
> -               return 0;
> -       }
> +       if (amdgpu_ras_smu_eeprom_supported(adev))
> +               return amdgpu_ras_smu_eeprom_append(control);
>
>         if (num =3D=3D 0) {
>                 dev_err(adev->dev, "will not append 0 records\n");
> --
> 2.34.1
>
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 29 Oct 2025 18:38:00 +0800
> From: Tao Zhou <tao.zhou1@amd.com>
> To: <amd-gfx@lists.freedesktop.org>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Subject: [PATCH 6/8] drm/amdgpu: get RAS bad page address from MCA
>         address
> Message-ID: <20251029103802.1402199-6-tao.zhou1@amd.com>
> Content-Type: text/plain
>
> Instead of from physical address.
>
> v2: add comment to make the code more readable
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 15 ++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |  4 ++--
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 23d421b8ba54..ad197486d9e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3010,8 +3010,13 @@ static int amdgpu_ras_mca2pa_by_idx(struct
> amdgpu_device *adev,
>         addr_in.ma.err_addr =3D bps->address;
>         addr_in.ma.socket_id =3D socket;
>         addr_in.ma.ch_inst =3D bps->mem_channel;
> -       /* tell RAS TA the node instance is not used */
> -       addr_in.ma.node_inst =3D TA_RAS_INV_NODE;
> +       if (!amdgpu_ras_smu_eeprom_supported(adev)) {
> +               /* tell RAS TA the node instance is not used */
> +               addr_in.ma.node_inst =3D TA_RAS_INV_NODE;
> +       } else {
> +               addr_in.ma.umc_inst =3D bps->mcumc_id;
> +               addr_in.ma.node_inst =3D bps->cu;
> +       }
>
>         if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
>                 ret =3D adev->umc.ras->convert_ras_err_addr(adev, err_dat=
a, @@ -3158,7
> +3163,11 @@ static int __amdgpu_ras_convert_rec_from_rom(struct
> amdgpu_device *adev,
>                 save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) &
> UMC_NPS_MASK;
>                 bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
>         } else {
> -               save_nps =3D nps;
> +               /* if pmfw manages eeprom, save_nps is not stored on eepr=
om,
> +                * we should always convert mca address into physical add=
ress,
> +                * make save_nps different from nps
> +                */
> +               save_nps =3D nps + 1;
>         }
>
>         if (save_nps =3D=3D nps) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 3bf633158fa2..511c5882b37e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1012,10 +1012,10 @@ int amdgpu_ras_eeprom_read_idx(struct
> amdgpu_ras_eeprom_control *control,
>                 record[i - rec_idx].retired_page =3D 0x1ULL;
>                 record[i - rec_idx].ts =3D ts;
>                 record[i - rec_idx].err_type =3D
> AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
> -               record[i - rec_idx].cu =3D 0;
>
>                 if (adev->umc.ras->mca_ipid_parse)
> -                       adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
> +                       adev->umc.ras->mca_ipid_parse(adev, ipid,
> +                               (uint32_t *)&(record[i - rec_idx].cu),
>                                 (uint32_t *)&(record[i - rec_idx].mem_cha=
nnel),
>                                 (uint32_t *)&(record[i - rec_idx].mcumc_i=
d), NULL);
>                 else
> --
> 2.34.1
>
>
>
> ------------------------------
>
> Message: 3
> Date: Wed, 29 Oct 2025 11:48:41 +0100
> From: Timur Krist?f <timur.kristof@gmail.com>
> To: Christian K?nig <christian.koenig@amd.com>,
>         amd-gfx@lists.freedesktop.org, Alex Deucher
>         <alexander.deucher@amd.com>,  Alexandre Demers
>         <alexandre.f.demers@gmail.com>, Rodrigo Siqueira <siqueira@igalia=
.com>
> Subject: Re: [PATCH 05/14] drm/amdgpu/vce: Clear VCPU BO before
>         copying firmware to it
> Message-ID: <2f0591f9dc2dadac72e8def5977afdc0a1e876b1.camel@gmail.com>
> Content-Type: text/plain; charset=3D"UTF-8"
>
> On Wed, 2025-10-29 at 11:19 +0100, Christian K?nig wrote:
> > On 10/28/25 23:06, Timur Krist?f wrote:
> > > The VCPU BO doesn't only contain the VCE firmware but also other
> > > ranges that the VCE uses for its stack and data. Let's initialize
> > > this to zero to avoid having garbage in the VCPU BO.
> >
> > Absolutely clear NAK.
> >
> > This is intentionally not initialized on resume to avoid breaking
> > encode sessions which existed before suspend.
>
> How can there be encode sessions from before suspend?
> I think that there can't be.
>
> As far as I see, before suspend we wait for the VCE to go idle, meaning t=
hat we wait
> for all pending work to finish.
> amdgpu_vce_suspend has a comment which says:
> suspending running encoding sessions isn't supported
>
> > Why exactly is that an issue?
>
> We need to clear at least some of the BO for the VCE1 firmware validation
> mechanism. This is done in a memset in vce_v1_0_load_fw in the old radeon=
 driver.
>
> Also I think it's a good idea to avoid having garbage in the VCPU BO.
>
> > The VCE FW BO should be cleared to zero after initial allocation?
>
> To clarify, are you suggesting that I move the memset to after the BO cre=
ation, and
> then never clear it again? Or are you saying that amdgpu_bo_create_reserv=
ed
> already clears the BO?
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > > Signed-off-by: Timur Krist?f <timur.kristof@gmail.com>
> > > ---
> > > ?drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
> > > ?1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > index b9060bcd4806..eaa06dbef5c4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > > @@ -310,6 +310,7 @@ int amdgpu_vce_resume(struct amdgpu_device
> > > *adev)
> > > ?   offset =3D le32_to_cpu(hdr->ucode_array_offset_bytes);
> > > ?
> > > ?   if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > > +           memset32(cpu_addr, 0, amdgpu_bo_size(adev-
> > > >vce.vcpu_bo) / 4);
> > > ?           memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> > > ?                   ??? adev->vce.fw->size - offset);
> > > ?           drm_dev_exit(idx);
>
>
> ------------------------------
>
> Message: 4
> Date: Wed, 29 Oct 2025 11:54:14 +0100
> From: Timur Krist?f <timur.kristof@gmail.com>
> To: Christian K?nig <christian.koenig@amd.com>,
>         amd-gfx@lists.freedesktop.org, Alex Deucher
>         <alexander.deucher@amd.com>,  Alexandre Demers
>         <alexandre.f.demers@gmail.com>, Rodrigo Siqueira <siqueira@igalia=
.com>
> Subject: Re: [PATCH 07/14] drm/amdgpu/si,cik,vi: Verify IP block when
>         querying video codecs
> Message-ID: <c80bae703d5f0f825becc35b17d855380f380a9d.camel@gmail.com>
> Content-Type: text/plain; charset=3D"UTF-8"
>
> On Wed, 2025-10-29 at 11:35 +0100, Christian K?nig wrote:
> >
> >
> > On 10/28/25 23:06, Timur Krist?f wrote:
> > > Some harvested chips may not have any IP blocks, or we may not have
> > > the firmware for the IP blocks.
> > > In these cases, the query should return that no video codec is
> > > supported.
> > >
> > > Signed-off-by: Timur Krist?f <timur.kristof@gmail.com>
> > > ---
> > > ?drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
> > > ?drivers/gpu/drm/amd/amdgpu/cik.c??????? | 6 ++++++
> > > ?drivers/gpu/drm/amd/amdgpu/si.c???????? | 6 ++++++
> > > ?drivers/gpu/drm/amd/amdgpu/vi.c???????? | 6 ++++++
> > > ?4 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > index b3e6b3fcdf2c..42b5da59d00f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -1263,7 +1263,8 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> > > void *data, struct drm_file *filp)
> > > ?                   -EFAULT : 0;
> > > ?   }
> > > ?   case AMDGPU_INFO_VIDEO_CAPS: {
> > > -           const struct amdgpu_video_codecs *codecs;
> > > +           static const struct amdgpu_video_codecs no_codecs
> > > =3D {0};
> >
> > No zero init for static variables please, that will raise you a
> > constant checker warning.
> >
> > > +           const struct amdgpu_video_codecs *codecs =3D
> > > &no_codecs;
> > > ?           struct drm_amdgpu_info_video_caps *caps;
> > > ?           int r;
> > > ?
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
> > > b/drivers/gpu/drm/amd/amdgpu/cik.c
> > > index 9cd63b4177bf..b755238c2c3d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> > > @@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs
> > > cik_video_codecs_decode =3D ?static int cik_query_video_codecs(struct
> > > amdgpu_device *adev, bool encode,
> > > ?                           ? const struct amdgpu_video_codecs
> > > **codecs)
> > > ?{
> > > +   const enum amd_ip_block_type ip =3D
> > > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > > AMD_IP_BLOCK_TYPE_UVD;
> > > +
> > > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > > +           return 0;
> >
> > I'm wondering if returning EOPNOTSUPP is not more appropriate here
> > than returning an empty cappability list.
>
> I don't think so.
>
> Returning EOPNOTSUPP would indicate that the operation of querying the co=
dec
> support is not supported, and not that the list of supported codecs is em=
pty.
>
> >
> > Anyway setting the codecs list to empty in the caller is rather bad
> > coding style.
>
> Sure, I'll come up with a better way to do this.
>
> >
> > Regards,
> > Christian.
> >
> > > +
> > > ?   switch (adev->asic_type) {
> > > ?   case CHIP_BONAIRE:
> > > ?   case CHIP_HAWAII:
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/si.c
> > > b/drivers/gpu/drm/amd/amdgpu/si.c index e0f139de7991..9468c03bdb1b
> > > 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/si.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> > > @@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs
> > > hainan_video_codecs_decode =3D ?static int
> > > si_query_video_codecs(struct amdgpu_device *adev, bool encode,
> > > ?                            const struct amdgpu_video_codecs
> > > **codecs)
> > > ?{
> > > +   const enum amd_ip_block_type ip =3D
> > > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > > AMD_IP_BLOCK_TYPE_UVD;
> > > +
> > > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > > +           return 0;
> > > +
> > > ?   switch (adev->asic_type) {
> > > ?   case CHIP_VERDE:
> > > ?   case CHIP_TAHITI:
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> > > b/drivers/gpu/drm/amd/amdgpu/vi.c index a611a7345125..f0e4193cf722
> > > 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > > @@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs
> > > cz_video_codecs_decode =3D ?static int vi_query_video_codecs(struct
> > > amdgpu_device *adev, bool encode,
> > > ?                            const struct amdgpu_video_codecs
> > > **codecs)
> > > ?{
> > > +   const enum amd_ip_block_type ip =3D
> > > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > > AMD_IP_BLOCK_TYPE_UVD;
> > > +
> > > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > > +           return 0;
> > > +
> > > ?   switch (adev->asic_type) {
> > > ?   case CHIP_TOPAZ:
> > > ?           if (encode)
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> ------------------------------
>
> End of amd-gfx Digest, Vol 113, Issue 529
> *****************************************

