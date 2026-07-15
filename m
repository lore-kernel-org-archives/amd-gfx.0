Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDB8C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 04:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39BC10E125;
	Wed, 15 Jul 2026 04:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1DA2+SWR";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3FD610E125
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 04:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1Pkcf2A7eMjg8w+4yNEKyIf9tucTVedcjvHW4VktqYy5Xb+pUwc51tKCWC3POpcPbpXxmG3O2gAZ51ipvym08SC8Gud2tkBh86gAX6Y4R+Uxfm/CkF5f/0kyICkTInDwFr6Gv+iBs+9D06YH13V+Pg2zL1UkUoYrLsjWuIkllreFDhMOO0KaaW4XSYc5YJy2a3bqAaNJECjrIl8dySxCbA7iv2QDgTkdu8IxVtnELQ18uNGw0IE+gp7FhB/Io+UDR3htzG1S8T92VCe3Id3jqVtOzGfGQZgjg+TXJexFE4bcBP+HItYvOiezS9PEOjytK479Xb8bdb0Lti3ffUEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42y7iCyOsbDuwPq2CmJJ3mSlVmgMDQ6XaaH9+fg7qVo=;
 b=RKplaTX2cPwGboD2/t6AV+vvFvtw02oHwq4T3IySRU7GfGynhcir53C6yHn3A47SE8kUp/u6Cpufp9jZETegWWjlt19nqoSnt0ZpzdSlw/0LPBjkWPRNzF0Vpb7p2zolAJwlI6kYVpBhargelUUeYFToZBttGwDOEE6lBpMTdlbJuj8EmO1/np0Wx2FMnW97dUyAFA3tLYhE4M/bcIULRT8PtxCes8+7uypYRO4mPcLRg6dXDnaCsIYbL7mvTi3yVYYMgiJqL+xWKan01sdLHut8sdpHhtuWWRjH4sYTCGriKSeg5/5Zf7PJkAzen0W++e6b4vyyn+3Q7dQAUBc6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42y7iCyOsbDuwPq2CmJJ3mSlVmgMDQ6XaaH9+fg7qVo=;
 b=1DA2+SWRa1i7Kju7DRZDvnVAvqXnA9cXMMqS6as4KJOEdaquN6MkxM164aCT8WBSd9zHpeJvDdPSHSn0pPyNWdzkdq7wyvLWJWCSNtU1RnpRUDsBkR/c2kNS0IHw/pf/veAzih1Cj3NsM7TzxAySweZJYX5hZvrnhRJ/+5TkH8w=
Received: from PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 04:33:14 +0000
Received: from PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0]) by PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 04:33:14 +0000
From: "McRae, Geoffrey" <Geoffrey.McRae@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix sysfs duplicate errors and incomplete
 unwind in ip_init
Thread-Topic: [PATCH v2] drm/amdgpu: fix sysfs duplicate errors and incomplete
 unwind in ip_init
Thread-Index: AQHdD17Zp4LfWCh6+0Ks3fD2BRTLrbZnLKkAgAbaGMo=
Date: Wed, 15 Jul 2026 04:33:14 +0000
Message-ID: <PH7PR12MB5595CEAFF3E5273132B08E9588F82@PH7PR12MB5595.namprd12.prod.outlook.com>
References: <CADnq5_NDZqV4ihd70PBgXOrfRfzfYrgz948-FnNh+8tpvn7kxQ@mail.gmail.com>
 <20260709045238.3405709-1-geoffrey.mcrae@amd.com>
 <BN9PR12MB51462B1890A7FD7D248CD5C5F7FD2@BN9PR12MB5146.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB51462B1890A7FD7D248CD5C5F7FD2@BN9PR12MB5146.namprd12.prod.outlook.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-15T04:33:03.889Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=1;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5595:EE_|PH7PR12MB8780:EE_
x-ms-office365-filtering-correlation-id: e2b7143f-fe6c-45fa-5d93-08dee22a2f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: SykddHmZyBSu0LD9gVrvBBEaJVgZDJfwlyreFyH8AtDtUSe6jY5zi+6DPl6rDsO4X5ntAeeAIjCcp83Kdu8tyIdSf0Vv+plUJUsl/MCdZdQlxSNljL0UFEHwjpGiFKp1g1a6rgWLkAld5oUcpOLo1Swpvy6hDeG8No2YnHmmsvOB8R2K2xN4cAlh4RGX4EjSfZtiTNy/1cH6mH6k6R5rl83i5w/DUT3PnSMNltIajVKj15irr5QS6ZnmyBC07nWb4xRGKv1tzPnLpTvwzTWA9BJxuGd2AFDxJxdwXwh2psYmyRlsYU7aOi9dVxECCnJfXBD5ttFoc5iRoEzoUhVshttcRtOz6+I0XeTPumENk4qVxvOk3p4DjKmFBbSzE8zTdlEZm57D+vBNX7CCj60rVADV5qqBF52mCsQyaZQAJpg63av/ycbQN6d28HH3nmwr8bcAliqqME7hEnrcqgD/BBlEwDIAU4nFyq5RPExTwC9EoNKxPFxzs9zHOzND+FTFSr22zI/1ilIoBJpPlwREFqf3RSoYyWHrE1sOX3buqEZjZqhBgZcfSbv/+biqitSgIWuva/dW1s6b0HZPV9p5e7O+0I+70Fy4Mm6roRCHHfoiJmWSwEcfs4VDSXxFw3kEdnx4KfC4hDLzfUS73GVCGv9dgtwAigo1wMR6606P2nlPofj/lOYjDeaunl0I4oK1wmFAr44rWFPoXt1PTPsOu0y5eWPhfEVpQOvGbGZNCuM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5595.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m92BaGU34u54bquT8kEtnoCOgYlOWsd/oYDrT+FxW2DdehxlvvsAskofsT?=
 =?iso-8859-1?Q?PC1Zhloour9gWaU/9D94LCg5NPiSfFyw7cjjA3WnqgGhPrMqnRTdxisrl6?=
 =?iso-8859-1?Q?ZPtuiWBBSmjmw+uvl9QXHrnBeqfL/zYh3FSdzOugeQyT3yOV9ytOF74Yga?=
 =?iso-8859-1?Q?Okpq135K3s+kS6owshyh3WLPD8XF7zqv7+HurJEd3sl8gtSjD7vF6rCRZy?=
 =?iso-8859-1?Q?vFnsHvNbrqL9FQcKIiOU4tyBArW8rSuV/eMorlgTu90Seb8Sakob1wafou?=
 =?iso-8859-1?Q?sVg/qo3LInlgQTB5qzRxZejNJbx3/Vdzl1dYdD5CA8YouzsH1X0Rpoljci?=
 =?iso-8859-1?Q?QSjvDnwXY7KvMRH2R1/obMqJoghDf0Y81ZO9I9t/ves2NHz77Euxa8q4wt?=
 =?iso-8859-1?Q?KthA8haoUT5os/DctJLKlP5uq6oEt2yUKfU8o7SzHa6FT/WF8KFGzeS2gP?=
 =?iso-8859-1?Q?EgewXYkZixtd6i6Tz8A1g3zLSxfxTMfX8V2sXeA+1HS3arCc2GSWk1gOIv?=
 =?iso-8859-1?Q?3mrtuaZW/JA+brCb1wf5ELHJaa+ROibAOrsv9aPCWFmEHjuvxzGG7XKsZw?=
 =?iso-8859-1?Q?kAFchVwfiSc/4CB/gK9yuEEeIqBuHB3vTtZeRiPN6zbCZE8D8ctm+K5HYt?=
 =?iso-8859-1?Q?z7Wiif4ocNOlMIy30fBtQesxLKS0uPR4sLnpN2OOzObIFfDthavErzEvda?=
 =?iso-8859-1?Q?7St+2FPUHnMWB1cztZnsgOLPDu8SgUe346I9+3kzsg8EAazg5pRmhRDoXL?=
 =?iso-8859-1?Q?CxpLUMJJgynYl3MJs3ZT3mt9EdinoSRLwTS9zskYG6D1CkB/dyWkZ/xb7V?=
 =?iso-8859-1?Q?bnpPBADqf5I/xYuJIblFLTHAhRxEFs8dsn+n879gnag8AMpWVK5iFCOQ4e?=
 =?iso-8859-1?Q?5GMLXHr99pI3yhX8ZL/c6CEU/wKzYe4AIgEyKgNkl3VR/9pzuovDeADFch?=
 =?iso-8859-1?Q?333Tdgn0b1XuRFJj+IbpymfzHBl/gxdSI4fwg1t+rNdGYrck9BM1TCXeg9?=
 =?iso-8859-1?Q?MXwHni2pBkAFhmi4FehHas0OCKK3nRXFWvOQZZKlsj7tPHRuaYscihLUtD?=
 =?iso-8859-1?Q?dkr0a2xPLiZTfGAFt94rLpCbHbxIHX5edf2f+C8YDsy0YF8/DnZhC0Cght?=
 =?iso-8859-1?Q?0n06aAOBUyFGjyT6zs6L18R9h8zl8Srz7CtE8sGjtuVzGHSs6sBoAKsJON?=
 =?iso-8859-1?Q?HfswaWrbe9hkcDfpkITIms8GRSFt9idZzsqRYZGCI2K0aiSWcFbnoIeLbw?=
 =?iso-8859-1?Q?qMrlumtTZrr1wLdrXOBRV+o42RDtRbdappsiXyS3bi2WBHSxZqAKzkErps?=
 =?iso-8859-1?Q?QMOjvWwAwkjS8YnsU18SuPHfRfGNuC2nRA8lEgi63NVfg8DwYWNsSaSDuE?=
 =?iso-8859-1?Q?xhODDPmB5TnaYi1Stewk7j2rVvrIRG2dusKEEWJhJzJ+RfRq1Eik1q7wBB?=
 =?iso-8859-1?Q?26WOD+6ca7wi4oa3mbR1BCAuAG4n7g+PLHfjzKyZWBtyAjlZEBl8/YaTSW?=
 =?iso-8859-1?Q?/68k/BbFPUak4DMtXvtzKslVLzD+4p88YGRJnWRgz2hTStXEbrlRVBxHDS?=
 =?iso-8859-1?Q?0N0lwSl/v1bVbLEE9DE8/GrpijWdwYj9nEqhG7stPwYj+DWrTIPOP/ZtDC?=
 =?iso-8859-1?Q?ophFl4ukIB+DOjsM9EJGk6h0eLGunhhZgZHMkHUbTy8PZsYmPC8KhQbloh?=
 =?iso-8859-1?Q?47KDls7UzC8SZ+drEK8lPGE5In0AgAeJ/EBy/oyv8c1K5tB3lji5AWeKCu?=
 =?iso-8859-1?Q?C/rr3HkrdRIJS1Ox/A7/tDquJrYEfuSismvBTBLUX33YH5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5595.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b7143f-fe6c-45fa-5d93-08dee22a2f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 04:33:14.6176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ek/HDIsWdSOFHaaow9j9bgioCcdkmcMyoKpEpKT0asGpJ/w9T9nV/hlYVH/0JHY7iaJIbzaWvbQEcM/8WLvVpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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

Public=0A=
=0A=
>________________________________________=0A=
>From: Deucher, Alexander <Alexander.Deucher@amd.com>=0A=
>Sent: Saturday, 11 July 2026 5:52 AM=0A=
>To: McRae, Geoffrey=0A=
>Cc: Koenig, Christian; amd-gfx@lists.freedesktop.org=0A=
>Subject: RE: [PATCH v2] drm/amdgpu: fix sysfs duplicate errors and incompl=
ete unwind in ip_init=0A=
>=0A=
>Public=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: McRae, Geoffrey <Geoffrey.McRae@amd.com>=0A=
>> Sent: Thursday, July 9, 2026 12:53 AM=0A=
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>=0A=
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; amd-=0A=
>> gfx@lists.freedesktop.org; McRae, Geoffrey <Geoffrey.McRae@amd.com>=0A=
>> Subject: [PATCH v2] drm/amdgpu: fix sysfs duplicate errors and incomplet=
e=0A=
>> unwind in ip_init=0A=
>>=0A=
>> When amdgpu_device_ip_init() fails partway through, IP blocks that had=
=0A=
>> completed sw_init() were never unwound, leaving sysfs files registered.=
=0A=
>> On the next device init attempt this produced duplicate filename errors:=
=0A=
>>=0A=
>>   sysfs: cannot create duplicate filename '.../enforce_isolation'=0A=
>>   sysfs: cannot create duplicate filename '.../sdma_reset_mask'=0A=
>>   sysfs: cannot create duplicate filename '.../vcn_reset_mask'=0A=
>>   sysfs: cannot create duplicate filename '.../jpeg_reset_mask'=0A=
>>   sysfs: cannot create duplicate filename '.../vpe_reset_mask'=0A=
>>   sysfs: cannot create duplicate filename '.../current_memory_partition'=
=0A=
>>   sysfs: cannot create duplicate filename '.../available_memory_partitio=
n'=0A=
>>=0A=
>> Fix the init_failed unwind path in amdgpu_device_ip_init() to properly r=
everse=0A=
>> all initialisation performed by the function:=0A=
>>=0A=
>> - Call sw_fini() in reverse order for all IP blocks where status.sw is=
=0A=
>>   true, mirroring amdgpu_device_ip_fini().=0A=
>>=0A=
>> - For the GMC block, free the resources allocated during its early=0A=
>>   hw_init phase in the correct reverse order: seq64, static CSA,=0A=
>>   writeback buffer, and mem scratch page.=0A=
>>=0A=
>> - Free resources initialised after the IP block loop: ucode BO, IB=0A=
>>   pool, KFD device, TTM buffer funcs, and the SRIOV vf2pf data=0A=
>>   exchange work item.=0A=
>>=0A=
>> Additionally, fix amdgpu_gfx_sysfs_init() to properly unwind partially=
=0A=
>> registered gfx sysfs files on registration failure, and drop the now-unn=
ecessary=0A=
>> kobj.sd liveness guard from amdgpu_gfx_sysfs_fini() since=0A=
>> device_remove_file() is safe to call during sysfs teardown.=0A=
>>=0A=
>> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>=0A=
>> Cc: Alex Deucher <alexander.deucher@amd.com>=0A=
>> Cc: Christian K=F6nig <christian.koenig@amd.com>=0A=
>> ---=0A=
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21=0A=
>> ++++++++++++++++++++=0A=
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 23 +++++++++++++++-----=0A=
>> --=0A=
>>  2 files changed, 37 insertions(+), 7 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
>> index 70d07ca187a3..9630ad5f3048 100644=0A=
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
>> @@ -2491,6 +2491,27 @@ static int amdgpu_device_ip_init(struct=0A=
>> amdgpu_device *adev)=0A=
>>       r =3D amdgpu_cper_init(adev);=0A=
>>=0A=
>>  init_failed:=0A=
>> +     if (r) {=0A=
>> +             amdgpu_amdkfd_device_fini_sw(adev);=0A=
>> +             amdgpu_ttm_disable_buffer_funcs(adev);=0A=
>> +             if (amdgpu_sriov_vf(adev))=0A=
>> +                     amdgpu_virt_fini_data_exchange(adev);=0A=
>> +             amdgpu_ucode_free_bo(adev);=0A=
>> +             amdgpu_ib_pool_fini(adev);=0A=
>> +             for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {=0A=
>> +                     if (!adev->ip_blocks[i].status.sw)=0A=
>> +                             continue;=0A=
>> +                     if (adev->ip_blocks[i].version->type =3D=3D=0A=
>> AMD_IP_BLOCK_TYPE_GMC) {=0A=
>> +                             amdgpu_seq64_fini(adev);=0A=
>> +                             amdgpu_free_static_csa(&adev-=0A=
>> >virt.csa_obj);=0A=
>> +                             amdgpu_device_wb_fini(adev);=0A=
>> +                             amdgpu_device_mem_scratch_fini(adev);=0A=
>> +                     }=0A=
>> +                     if (adev->ip_blocks[i].version->funcs->sw_fini)=0A=
>> +                             adev->ip_blocks[i].version->funcs-=0A=
>> >sw_fini(&adev->ip_blocks[i]);=0A=
>> +                     adev->ip_blocks[i].status.sw =3D false;=0A=
>> +             }=0A=
>=0A=
>Also need to unwind all of the other stuff in that function (hw_init(), uc=
ode bo allocation, etc.).  Might be easier to call amdgpu_device_ip_fini() =
instead to cover all of the unwinding properly.=0A=
>=0A=
>Alex=0A=
>=0A=
=0A=
ip_fini_early() and ip_fini() make assumptions about device state that don'=
t hold for a partially initialised device, for example, ip_fini() calls amd=
gpu_doorbell_fini() from the GMC block, but doorbells are owned by the oute=
r amdgpu_device_init() and would be double-freed. The init_failed unwind is=
 the correct approach, we already handle sw_fini for all IP blocks, and the=
 associated resources (ucode BO, IB pool, WB, mem scratch, seq64, CSA, KFD,=
 TTM buffer funcs) are all properly torn down.=0A=
=0A=
Geoff=0A=
=0A=
>=0A=
>> +     }=0A=
>>=0A=
>>       return r;=0A=
>>  }=0A=
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=0A=
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=0A=
>> index 982b41606d48..0ab4c73c102a 100644=0A=
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=0A=
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=0A=
>> @@ -2182,23 +2182,32 @@ int amdgpu_gfx_sysfs_init(struct=0A=
>> amdgpu_device *adev)=0A=
>>       }=0A=
>>=0A=
>>       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);=0A=
>> -     if (r)=0A=
>> +     if (r) {=0A=
>>               dev_err(adev->dev, "failed to create isolation sysfs files=
");=0A=
>> +             goto err_isolation_shader;=0A=
>> +     }=0A=
>>=0A=
>>       r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);=0A=
>> -     if (r)=0A=
>> +     if (r) {=0A=
>>               dev_err(adev->dev, "failed to create reset mask sysfs file=
s");=0A=
>> +             goto err_reset_mask;=0A=
>> +     }=0A=
>> +=0A=
>> +     return 0;=0A=
>>=0A=
>> +err_reset_mask:=0A=
>> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);=0A=
>> +     amdgpu_gfx_sysfs_isolation_shader_fini(adev);=0A=
>> +err_isolation_shader:=0A=
>> +     amdgpu_gfx_sysfs_xcp_fini(adev);=0A=
>>       return r;=0A=
>>  }=0A=
>>=0A=
>>  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)  {=0A=
>> -     if (adev->dev->kobj.sd) {=0A=
>> -             amdgpu_gfx_sysfs_xcp_fini(adev);=0A=
>> -             amdgpu_gfx_sysfs_isolation_shader_fini(adev);=0A=
>> -             amdgpu_gfx_sysfs_reset_mask_fini(adev);=0A=
>> -     }=0A=
>> +     amdgpu_gfx_sysfs_xcp_fini(adev);=0A=
>> +     amdgpu_gfx_sysfs_isolation_shader_fini(adev);=0A=
>> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);=0A=
>>  }=0A=
>>=0A=
>>  static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device=
=0A=
>> *adev,=0A=
>> --=0A=
>> 2.43.0=
