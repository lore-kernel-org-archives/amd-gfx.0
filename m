Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B68CC636CD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 09:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68D510ECBE;
	Fri, 10 Feb 2023 09:51:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879D710ECBE
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 09:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmgiSi47SuybfkMOrgSt0Qyb5fVuaVc1g6wWj+YIEhhn3ccgEz93np1TAQL4NaXYnsEahWYtOg8QuJLgBniTj19hzm65cfe86UYh1SId3hs6l3P9MJxIN+D32ONMBnKqWb5Ml+tBjFvp1hLqMqmR3v3gIIJHHTRqqmKl5AssmluhOKoUtYL3C6ds7WBHB2cAbSFn1Sd4czIaqtAuzfrIsYHoeElM6owluW1EzyN9TCg8yMcqT6ZlmZMXokmVDrYrhVV2pF4nVsmhzTVzg4yCnPklPT54ZxsJtkODlkvHpfoSeQCQx9CGlppna2Z9bso+Bcir4DUb2ISYi5+g+sGcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx7JLTQZaQPCV6CVQpJ3UBOGVqNX0dTrNBJcuySb0FI=;
 b=CfmyFSWmDaKOtlWzG+80CxKDHbBWayrxDd9SrRNsuwhSIx8wqkki9ojmxEf7lm4Z3SERJNqSUdtYZU44DqzSfZJ4JpNGABJoi2wBcgYtHXHr1PMQlqzRHfXwF9r4FB4oXSjMd1Pd03lUKl7Fsb6VATGI1L4KZt0483pvbHYR1mIJzDUhj3WaHdnKR9rdRKoYxWri9BCC6HnCvkzJvdyQ8gneccimxTz0dJl+wlVe40+tdPX6UmMYgr4vmMZfhEbcz7+z8lv44j6Bj6uNw8P2grpfAmEetMdTmT+ithPQGSoT29H15DtCv6WuO+du07+868XJtnTrXZ3fIqscJypIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx7JLTQZaQPCV6CVQpJ3UBOGVqNX0dTrNBJcuySb0FI=;
 b=ucg2C6CJOyn/H13g3z9s86JAKhUpwH9ilqD/QpP+kAGTyP1sulO9K8M9YcV1ZKS+/YfdTOW2394Ecnbm+Tb6FpnRr7tNpMpkX1YSsSZpu338Hyliuig5lUTCjDzIKUiPyof5cPPllDjhrNWrZicXDdbxsjL0NP8xoTujPi65WqA=
Received: from MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 09:51:54 +0000
Received: from MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::bac5:385f:b991:c9c0]) by MW3PR12MB4458.namprd12.prod.outlook.com
 ([fe80::bac5:385f:b991:c9c0%5]) with mapi id 15.20.6086.021; Fri, 10 Feb 2023
 09:51:54 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Topic: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Thread-Index: AQHZNuxfg8FNVol4pke6J9qzLuANM667iUeAgAExmRCAAHu1gIAES/RQgAATLwCAAAHxgIAADTYAgAX4+QCAAEHdAIAAB+bQ
Date: Fri, 10 Feb 2023 09:51:53 +0000
Message-ID: <MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9@MW3PR12MB4458.namprd12.prod.outlook.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
 <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
 <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
 <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
 <MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <9ac594eb-9b59-02e1-fc7f-a745e28ff201@amd.com>
 <MW3PR12MB4458C18F7080280760953EACEFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <9cf6c24f-2b91-0431-6098-4ee2230ce57a@gmail.com>
 <DM6PR12MB26199592B7845FA8543B9134E4DE9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <29f0cd30-9af6-0bd9-fa13-80c52d8209fe@amd.com>
In-Reply-To: <29f0cd30-9af6-0bd9-fa13-80c52d8209fe@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-10T09:51:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6713e4c6-3059-4b73-8379-379aecf605df;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-10T09:51:48Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3897acf0-4524-4876-ac3d-0a6a60187109
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4458:EE_|DS0PR12MB7631:EE_
x-ms-office365-filtering-correlation-id: d45627e4-ffa5-406e-e8ce-08db0b4c707e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6SUOkGM9NzPhpIPiqGMLAsKqT2aubI9ZeykIfJ8HKE+oejAWhmDpI1Nb976eWZc0+wReU+rL4y4yloutGJ+cw7CGNix9iPy0zBFoM7+P7RAO8pttVazKzPDu+51aSUFx7ZYjx917W8arVBs2ZaR93qLYzNGpT90lskte2fjx6S8/rF//FUYeZ1tkGzxkFN4GP1cTc8DvPg9WDovDH9NzydKVCmLAkthDgU8Q5bLxoT8x/J25wgxvtx+BVhRwNQz3wgAnko9iaQC1u1Pa1MgPOItK5gWAGiC+/Ao5Sa/wFmxOddNT9GlJOtc1AhP9FbKgNzRseqy7YkUzbn1G/+C0UhryllJ0L0LRBPEdvpszrj70f7eHncUbQQdnYlWrgfN8D8thk2O9P5d/ynTScDBBaFRqsZ6/ACCq1ttzTz1wt+fgNsfXclSGl1TxoN0swlvzmg2evAnBQPP1h0t+O+feJ2hAltAZooZWujE1fne1xOa1YMo+0h4Swy6EgZd7B6j8s262WffClj3GnveN5dwrXYGx2rsL+E0I8RYnhcwCpkN4x/FhwL2k/LusGg9q6l7GEnLKrqKNmGSPl85AAeMY2oNJ/fvun3WhfDAPHC5zEjMuyodYeSajcabl81PRAF47l4GjGTwujhumFRTzaonalLWADeCnIYppYCIg1KLJtj16o4aMnr3ub/qKadfuL6pgamXYs7T4w7j+mLOEBPeEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199018)(66476007)(76116006)(66946007)(8676002)(316002)(45080400002)(38100700002)(66556008)(6636002)(122000001)(66574015)(83380400001)(110136005)(86362001)(52536014)(33656002)(53546011)(478600001)(38070700005)(6506007)(186003)(2906002)(26005)(9686003)(30864003)(71200400001)(5660300002)(64756008)(66446008)(55016003)(41300700001)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xWg3KsQTL/RdcbABHCLEz8Kr4FE1+UOw9UjEVTY1rAsDIB/S74H51KByLr?=
 =?iso-8859-1?Q?lvFWUZs/onxNj7J/x1LgZ0MxTBxNIBp3E7ocfu/HEwr+twjEXT3WxDVx0E?=
 =?iso-8859-1?Q?FLWokfWKvuTJ9toEdY9OsebDVKML62TS1P1Z5RgcrC6wOTL8BBFWjSCzFs?=
 =?iso-8859-1?Q?M1J6JVNM2t9a3ctLOQ8BN8tfDZolq+oS45r2OsTUTRgtY4jawcYpU4ZCr6?=
 =?iso-8859-1?Q?Q0Zpaaed/pC426Or2YPstpILmlscN/yfhJRS19GGqdegQJstcIrjJekLKD?=
 =?iso-8859-1?Q?jBy6t9SLvp5w2pUtPRY1e8Z28s+/TpFEHBh39tCx19m/guHoJcBR3dDTSH?=
 =?iso-8859-1?Q?Cx35C24l6ti+BRrInWjmsRt9H6Voh1ReLfn0xBFq/XeCnCktLeD6kPL+Az?=
 =?iso-8859-1?Q?oXDJz+9gDPQ3vx5uaRWxowNOFK4MN4T5QRZZNfGhPKeEjh+V369E1xzJi7?=
 =?iso-8859-1?Q?MbQeDKDEtML7eWhxs36/6n5/AiR0suiznDDcd7G0vD5+4S9DE4hPekw+ut?=
 =?iso-8859-1?Q?QNODBTds5SQ7u366maoxfL2JLnqfMQxn7r/AYxgn+HB4HHhsswmi++ajPr?=
 =?iso-8859-1?Q?8xhCqS57FStAALINZ44pqvK+Hqke+PR9lxhasqO8ed/05hl8SOcu5nKioy?=
 =?iso-8859-1?Q?8L4myapeVBEP1svDk+t+1gHz7AyJOghMISEuLegJCALvMhrDvqAnmnlqfh?=
 =?iso-8859-1?Q?FULhP+g4vLR0/SeA+OdU/dgZaAOxlKnUkmsu7RCqCOE05ZKLA/O1R0+d3N?=
 =?iso-8859-1?Q?lJmUl6C1AsVNAS+np9Bv/6U2HoZD7tFNhFyiqNHNwSh6LIN1iDStTdgSrs?=
 =?iso-8859-1?Q?3Cix5HEBdv7QeEVn2/hNCA262wVcqTYGyl9sCNJGO7/vFKaTaU1+uqTx8k?=
 =?iso-8859-1?Q?zcqHE26wZWhrS/VYoriL6nl0qOLzG5e9+DDb8GeTS2ag6xW2ZKyPBmJT9W?=
 =?iso-8859-1?Q?4Ix5C0kzjJ06NtS0XS2W5pxpSUkPJCsVFCOsJqaWj6ZmsbiqV36z7doF9E?=
 =?iso-8859-1?Q?3fbOEjyilBeMa/UT6VBWpdBHdJXQj5CK/464qo8Z7O0MTWZgleUv6z1GAY?=
 =?iso-8859-1?Q?4RXrW797h2KI3wbPTJNR5i1/2f4riq75Y11qqNe+vRH8G47hb3sewB5Pub?=
 =?iso-8859-1?Q?OCFw4hgudQAvjgPjcHRvnPY9KVQQfZNduShzbonMNEWO4za0xhv9i4u9Vc?=
 =?iso-8859-1?Q?P1HFKzkhwUNZqdcP0Mh2z7cSaHsAR0mc0DqnKhIbmOgsTF2RrLtxKMd5s8?=
 =?iso-8859-1?Q?yWIRtsCyflKDGfUUcAqYNsAh+TC9+z4Kl242CyE1A3G2Gu1cBcoPMNAJIf?=
 =?iso-8859-1?Q?tiJaEIQvmayle+5xKKuAc/IDfX/R8Q2Kz3LMpn1rv0c057f0HewoTGGkEm?=
 =?iso-8859-1?Q?//w+ttu3FdJNwvnbcJhBvoqJwfv1kLNc4KCdWovwHQIPbgNMppn8Wz4lS8?=
 =?iso-8859-1?Q?m2unspWNLGHDDu5D4laVNLm3rFZmVqigfTi0gLXgiEfXFyTMYxJPsB+FqA?=
 =?iso-8859-1?Q?3hlIG421R8WB6e3RRomfEKi4ZbfhuKmiwhajndrD8fyGG9v5PkATMqcKVE?=
 =?iso-8859-1?Q?G5irO5JFvVJYFtcAoEJOTow2ozeTVPn/78yO53E2rGxFbcnC+8mOsloCHp?=
 =?iso-8859-1?Q?QumAmCHQsKil8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9MW3PR12MB4458namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45627e4-ffa5-406e-e8ce-08db0b4c707e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 09:51:53.5686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yt8nOgd8etkky4Lbj1eRyOPFsZ83gT3oRHVhOzwlvy6DT1/UWB3cHUXxW1PaGoz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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

--_000_MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9MW3PR12MB4458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Christian,

>> Allocating buffers temporary for stuff like that is illegal during resum=
e.

Can you *deeply* explain why it is illegal during ip late_init stage which =
is a part stage of resume?
In my understanding, after gmc ready, driver can allocate/free kernel bo, a=
nd after SDMA ready,
the eviction should be ready. What else prevent driver doing that during re=
sume?

>> I strongly suggest to just remove the MES test. It's abusing the kernel =
ring interface in a way we didn't want anyway and is currently replaced by =
Shahanks work.

The kernel mes unit test is very meaningful and important to catch MES firm=
ware issue at first time before
issue went spread to other components like kfd/umd to avoid the problem com=
plicated, Otherwise, the issue
would become hard to catch and debug.

Secondly, for mes unit test is self-containing and no dependency, it is a p=
art of milestone to qualify MES ready,
indicating that it can deliver to other component especially during brinup.=
 It is likely ring test and ib test indicating
gfx is ready to go. After totally transitioning to gfx user queue, mes unit=
 test may be the only one unit test which
can indicate gfx is ready at the very early stage of bringup when UMD is no=
t ready.

Regards,
Jack

From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, February 10, 2023 4:08 PM
To: Quan, Evan <Evan.Quan@amd.com>; Christian K=F6nig <ckoenig.leichtzumerk=
en@gmail.com>; Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.or=
g; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Hi Evan,

yeah, exactly that's what this warning should prevent. Allocating buffers t=
emporary for stuff like that is illegal during resume.

I strongly suggest to just remove the MES test. It's abusing the kernel rin=
g interface in a way we didn't want anyway and is currently replaced by Sha=
hanks work.

Regards,
Christian.
Am 10.02.23 um 05:12 schrieb Quan, Evan:

[AMD Official Use Only - General]

Hi Jack,

Are you trying to fix the call trace popped up on resuming below?
It seems mes created some bo for its self test and freed it up later at the=
 final stage of the resuming process.
All these happened before the in_suspend flag cleared. And that triggered t=
he call trace.
Is my understanding correct?

[74084.799260] WARNING: CPU: 2 PID: 2891 at drivers/gpu/drm/amd/amdgpu/amdg=
pu_object.c:425 amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
[74084.811019] Modules linked in: nls_iso8859_1 amdgpu(OE) iommu_v2 gpu_sch=
ed drm_buddy drm_ttm_helper ttm drm_display_helper drm_kms_helper i2c_algo_=
bit fb_sys_fops syscopyarea sysfillrect sysimgblt snd_sm
[74084.811042]  ip_tables x_tables autofs4 hid_logitech_hidpp hid_logitech_=
dj hid_generic e1000e usbhid ptp uas hid video i2c_i801 ahci pps_core crc32=
_pclmul i2c_smbus usb_storage libahci wmi
[74084.914519] CPU: 2 PID: 2891 Comm: kworker/u16:38 Tainted: G        W IO=
E      6.0.0-custom #1
[74084.923146] Hardware name: ASUS System Product Name/PRIME Z390-A, BIOS 2=
004 11/02/2021
[74084.931074] Workqueue: events_unbound async_run_entry_fn
[74084.936393] RIP: 0010:amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
[74084.942422] Code: 00 4d 85 ed 74 08 49 c7 45 00 00 00 00 00 4d 85 e4 74 =
08 49 c7 04 24 00 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc <0f=
> 0b e9 39 ff ff ff 3d 00 fe ff ff 0f 85 75 96 47 00 ebf
[74084.961199] RSP: 0000:ffffbed6812ebb90 EFLAGS: 00010202
[74084.966435] RAX: 0000000000000000 RBX: ffffbed6812ebc50 RCX: 00000000000=
00000
[74084.973578] RDX: ffffbed6812ebc70 RSI: ffffbed6812ebc60 RDI: ffffbed6812=
ebc50
[74084.980725] RBP: ffffbed6812ebbb8 R08: 0000000000000000 R09: 00000000000=
001ff
[74084.987869] R10: ffffbed6812ebb40 R11: 0000000000000000 R12: ffffbed6812=
ebc70
[74084.995015] R13: ffffbed6812ebc60 R14: ffff963a2945cc00 R15: ffff9639c7d=
a5630
[74085.002160] FS:  0000000000000000(0000) GS:ffff963d1dc80000(0000) knlGS:=
0000000000000000
[74085.010262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[74085.016016] CR2: 0000000000000000 CR3: 0000000377c0a001 CR4: 00000000003=
706e0
[74085.023164] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[74085.030307] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[74085.037453] Call Trace:
[74085.039911]  <TASK>
[74085.042023]  amdgpu_mes_self_test+0x385/0x460 [amdgpu]
[74085.047293]  mes_v11_0_late_init+0x44/0x50 [amdgpu]
[74085.052291]  amdgpu_device_ip_late_init+0x50/0x270 [amdgpu]
[74085.058032]  amdgpu_device_resume+0xb0/0x2d0 [amdgpu]
[74085.063187]  amdgpu_pmops_resume+0x37/0x70 [amdgpu]
[74085.068162]  pci_pm_resume+0x68/0x100
[74085.071836]  ? pci_legacy_resume+0x80/0x80
[74085.075943]  dpm_run_callback+0x4c/0x160
[74085.079873]  device_resume+0xad/0x210
[74085.083546]  async_resume+0x1e/0x40
[74085.087046]  async_run_entry_fn+0x30/0x120
[74085.091152]  process_one_work+0x21a/0x3f0
[74085.095173]  worker_thread+0x50/0x3e0
[74085.098845]  ? process_one_work+0x3f0/0x3f0
[74085.103039]  kthread+0xfa/0x130
[74085.106189]  ? kthread_complete_and_exit+0x20/0x20
[74085.110993]  ret_from_fork+0x1f/0x30
[74085.114576]  </TASK>
[74085.116773] ---[ end trace 0000000000000000 ]---

BR
Evan
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> On Behalf Of Christian K=F6nig
Sent: Monday, February 6, 2023 5:00 PM
To: Xiao, Jack <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>; Koenig, Chris=
tian <Christian.Koenig@amd.com><mailto:Christian.Koenig@amd.com>; amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexan=
der <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Am 06.02.23 um 09:28 schrieb Xiao, Jack:

[AMD Official Use Only - General]

                              >> >> It's simply not allowed to free up reso=
urces during suspend since those can't be acquired again during resume.
                              >> The in_suspend flag is set at the beginnin=
g of suspend and unset at the end of resume. It can't filter the case you m=
entioned.

               Why not? This is exactly what it should do.

[Jack] If freeing up resources during resume, it should not hit the issue y=
ou described. But only checking in_suspend flag would take these cases as w=
arning.

No, once more: Freeing up or allocating resources between suspend and resum=
e is illegal!

If you free up a resource during resume you should absolutely hit that, thi=
s is intentional!

Regards,
Christian.



Regards,
Jack

From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Monday, February 6, 2023 4:06 PM
To: Xiao, Jack <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>; Christian K=
=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.leichtzumerken@gma=
il.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org=
>; Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@=
amd.com>
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Am 06.02.23 um 08:23 schrieb Xiao, Jack:

[AMD Official Use Only - General]

>> Nope, that is not related to any hw state.

can use other flag.

>> It's simply not allowed to free up resources during suspend since those =
can't be acquired again during resume.
The in_suspend flag is set at the beginning of suspend and unset at the end=
 of resume. It can't filter the case you mentioned.

Why not? This is exactly what it should do.


Do you know the root cause of these cases hitting the issue? So that we can=
 get an exact point to warn the freeing up behavior.

Well the root cause are programming errors. See between suspending and resu=
ming you should not allocate nor free memory.

Otherwise we can run into trouble. And this check here is one part of that,=
 we should probably add another warning during allocation of memory. But th=
is here is certainly correct.

Regards,
Christian.



Thanks,
Jack

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Friday, February 3, 2023 9:20 PM
To: Xiao, Jack <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>; Koenig, Chris=
tian <Christian.Koenig@amd.com><mailto:Christian.Koenig@amd.com>; amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexan=
der <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Nope, that is not related to any hw state.

It's simply not allowed to free up resources during suspend since those can=
't be acquired again during resume.

We had a couple of cases now where this was wrong. If you get a warning fro=
m that please fix the code which tried to free something during suspend ins=
tead.

Regards,
Christian.
Am 03.02.23 um 07:04 schrieb Xiao, Jack:

[AMD Official Use Only - General]

>> It's simply illegal to free up memory during suspend.
Why? In my understanding, the limit was caused by DMA shutdown.

Regards,
Jack

From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Thursday, February 2, 2023 7:43 PM
To: Xiao, Jack <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander =
<Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Subject: AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unav=
ailable

Big NAK to this! This warning is not related in any way to the hw state.

It's simply illegal to free up memory during suspend.

Regards,
Christian.

________________________________
Von: Xiao, Jack <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
Gesendet: Donnerstag, 2. Februar 2023 10:54
An: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com=
>>
Cc: Xiao, Jack <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
Betreff: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unavaila=
ble

Reduce waringings, only warn when DMA is unavailable.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com<mailto:Jack.Xiao@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 2d237f3d3a2e..e3e3764ea697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,
         if (*bo =3D=3D NULL)
                 return;

-       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
+       WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
+               !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_T=
YPE_SDMA].status.hw);

         if (likely(amdgpu_bo_reserve(*bo, true) =3D=3D 0)) {
                 if (cpu_addr)
--
2.37.3





--_000_MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9MW3PR12MB4458namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Christian,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; Allocating buffers temporary for stuff like=
 that is illegal during resume.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can you *<b>deeply</b>* explain why it is illegal du=
ring ip late_init stage which is a part stage of resume?<o:p></o:p></p>
<p class=3D"MsoNormal">In my understanding, after gmc ready, driver can all=
ocate/free kernel bo, and after SDMA ready,
<o:p></o:p></p>
<p class=3D"MsoNormal">the eviction should be ready. What else prevent driv=
er doing that during resume?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; I strongly suggest to just remove the MES t=
est. It's abusing the kernel ring interface in a way we didn't want anyway =
and is currently replaced by Shahanks work.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The kernel mes unit test is very meaningful and impo=
rtant to catch MES firmware issue at first time before
<o:p></o:p></p>
<p class=3D"MsoNormal">issue went spread to other components like kfd/umd t=
o avoid the problem complicated, Otherwise, the issue
<o:p></o:p></p>
<p class=3D"MsoNormal">would become hard to catch and debug. <o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Secondly, for mes unit test is self-containing and n=
o dependency, it is a part of milestone to qualify MES ready,<o:p></o:p></p=
>
<p class=3D"MsoNormal">indicating that it can deliver to other component es=
pecially during brinup. It is likely ring test and ib test indicating
<o:p></o:p></p>
<p class=3D"MsoNormal">gfx is ready to go. After totally transitioning to g=
fx user queue, mes unit test may be the only one unit test which<o:p></o:p>=
</p>
<p class=3D"MsoNormal">can indicate gfx is ready at the very early stage of=
 bringup when UMD is not ready.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian &lt;Christian.Koenig@=
amd.com&gt; <br>
<b>Sent:</b> Friday, February 10, 2023 4:08 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Christian K=F6nig &lt;ckoe=
nig.leichtzumerken@gmail.com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; amd=
-gfx@lists.freedesktop.org; Deucher, Alexander &lt;Alexander.Deucher@amd.co=
m&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hi Evan,<br>
<br>
yeah, exactly that's what this warning should prevent. Allocating buffers t=
emporary for stuff like that is illegal during resume.<br>
<br>
I strongly suggest to just remove the MES test. It's abusing the kernel rin=
g interface in a way we didn't want anyway and is currently replaced by Sha=
hanks work.<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 10.02.23 um 05:12 schrieb Quan, Evan:<o:p></o:p><=
/p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Hi Jack,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Are you trying to fix the call trace popped up on re=
suming below?<o:p></o:p></p>
<p class=3D"MsoNormal">It seems mes created some bo for its self test and f=
reed it up later at the final stage of the resuming process.
<o:p></o:p></p>
<p class=3D"MsoNormal">All these happened before the in_suspend flag cleare=
d. And that triggered the call trace.<o:p></o:p></p>
<p class=3D"MsoNormal">Is my understanding correct?<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.799260] WARNING: CPU: 2 PID: 2891 at drivers/=
gpu/drm/amd/amdgpu/amdgpu_object.c:425 amdgpu_bo_free_kernel+0xfc/0x110 [am=
dgpu]<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.811019] Modules linked in: nls_iso8859_1 amdg=
pu(OE) iommu_v2 gpu_sched drm_buddy drm_ttm_helper ttm drm_display_helper d=
rm_kms_helper i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt sn=
d_sm<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.811042]&nbsp; ip_tables x_tables autofs4 hid_=
logitech_hidpp hid_logitech_dj hid_generic e1000e usbhid ptp uas hid video =
i2c_i801 ahci pps_core crc32_pclmul i2c_smbus usb_storage libahci wmi<o:p><=
/o:p></p>
<p class=3D"MsoNormal">[74084.914519] CPU: 2 PID: 2891 Comm: kworker/u16:38=
 Tainted: G &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;W IOE&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 6.0.0-custom #1<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.923146] Hardware name: ASUS System Product Na=
me/PRIME Z390-A, BIOS 2004 11/02/2021<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.931074] Workqueue: events_unbound async_run_e=
ntry_fn<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.936393] RIP: 0010:amdgpu_bo_free_kernel+0xfc/=
0x110 [amdgpu]<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.942422] Code: 00 4d 85 ed 74 08 49 c7 45 00 0=
0 00 00 00 4d 85 e4 74 08 49 c7 04 24 00 00 00 00 5b 41 5c 41 5d 41 5e 41 5=
f 5d c3 cc cc cc cc &lt;0f&gt; 0b e9 39 ff ff ff 3d 00 fe ff ff 0f 85 75 96=
 47 00 ebf<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.961199] RSP: 0000:ffffbed6812ebb90 EFLAGS: 00=
010202<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.966435] RAX: 0000000000000000 RBX: ffffbed681=
2ebc50 RCX: 0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.973578] RDX: ffffbed6812ebc70 RSI: ffffbed681=
2ebc60 RDI: ffffbed6812ebc50<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.980725] RBP: ffffbed6812ebbb8 R08: 0000000000=
000000 R09: 00000000000001ff<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.987869] R10: ffffbed6812ebb40 R11: 0000000000=
000000 R12: ffffbed6812ebc70<o:p></o:p></p>
<p class=3D"MsoNormal">[74084.995015] R13: ffffbed6812ebc60 R14: ffff963a29=
45cc00 R15: ffff9639c7da5630<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.002160] FS:&nbsp; 0000000000000000(0000) GS:f=
fff963d1dc80000(0000) knlGS:0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.010262] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0:=
 0000000080050033<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.016016] CR2: 0000000000000000 CR3: 0000000377=
c0a001 CR4: 00000000003706e0<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.023164] DR0: 0000000000000000 DR1: 0000000000=
000000 DR2: 0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.030307] DR3: 0000000000000000 DR6: 00000000ff=
fe0ff0 DR7: 0000000000000400<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.037453] Call Trace:<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.039911]&nbsp; &lt;TASK&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.042023]&nbsp; amdgpu_mes_self_test+0x385/0x46=
0 [amdgpu]<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.047293]&nbsp; mes_v11_0_late_init+0x44/0x50 [=
amdgpu]<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.052291]&nbsp; amdgpu_device_ip_late_init+0x50=
/0x270 [amdgpu]<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.058032]&nbsp; amdgpu_device_resume+0xb0/0x2d0=
 [amdgpu]<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.063187]&nbsp; amdgpu_pmops_resume+0x37/0x70 [=
amdgpu]<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.068162]&nbsp; pci_pm_resume+0x68/0x100<o:p></=
o:p></p>
<p class=3D"MsoNormal">[74085.071836]&nbsp; ? pci_legacy_resume+0x80/0x80<o=
:p></o:p></p>
<p class=3D"MsoNormal">[74085.075943]&nbsp; dpm_run_callback+0x4c/0x160<o:p=
></o:p></p>
<p class=3D"MsoNormal">[74085.079873]&nbsp; device_resume+0xad/0x210<o:p></=
o:p></p>
<p class=3D"MsoNormal">[74085.083546]&nbsp; async_resume+0x1e/0x40<o:p></o:=
p></p>
<p class=3D"MsoNormal">[74085.087046]&nbsp; async_run_entry_fn+0x30/0x120<o=
:p></o:p></p>
<p class=3D"MsoNormal">[74085.091152]&nbsp; process_one_work+0x21a/0x3f0<o:=
p></o:p></p>
<p class=3D"MsoNormal">[74085.095173]&nbsp; worker_thread+0x50/0x3e0<o:p></=
o:p></p>
<p class=3D"MsoNormal">[74085.098845]&nbsp; ? process_one_work+0x3f0/0x3f0<=
o:p></o:p></p>
<p class=3D"MsoNormal">[74085.103039]&nbsp; kthread+0xfa/0x130<o:p></o:p></=
p>
<p class=3D"MsoNormal">[74085.106189]&nbsp; ? kthread_complete_and_exit+0x2=
0/0x20<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.110993]&nbsp; ret_from_fork+0x1f/0x30<o:p></o=
:p></p>
<p class=3D"MsoNormal">[74085.114576]&nbsp; &lt;/TASK&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">[74085.116773] ---[ end trace 0000000000000000 ]---<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx <a href=3D"mailto:amd-gfx-bounc=
es@lists.freedesktop.org">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> <b>On Behalf Of </b>Chris=
tian K=F6nig<br>
<b>Sent:</b> Monday, February 6, 2023 5:00 PM<br>
<b>To:</b> Xiao, Jack <a href=3D"mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@am=
d.com&gt;</a>; Koenig, Christian
<a href=3D"mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt=
;</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander <a href=3D"mailto:Ale=
xander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 06.02.23 um 09:28 =
schrieb Xiao, Jack:<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
gt;&gt; &gt;&gt; It's simply not allowed to free up resources during suspen=
d since those can't be acquired again during resume.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; The in_suspend flag is =
set at the beginning of suspend and unset at the end of resume. It can&#821=
7;t filter the case you mentioned.<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Why not? This is exactly what it should do.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">[Jack] If freeing up resources during resume, it sho=
uld not hit the issue you described. But only checking in_suspend flag woul=
d take these cases as warning.<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
No, once more: Freeing up or allocating resources between suspend and resum=
e is illegal!<br>
<br>
If you free up a resource during resume you should absolutely hit that, thi=
s is intentional!<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian <a href=3D"mailto:Chr=
istian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a> <br>
<b>Sent:</b> Monday, February 6, 2023 4:06 PM<br>
<b>To:</b> Xiao, Jack <a href=3D"mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@am=
d.com&gt;</a>; Christian K=F6nig
<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumer=
ken@gmail.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Deucher, Alexander
<a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&=
gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 06.02.23 um 08:23 =
schrieb Xiao, Jack:<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; Nope, that is not related to any hw state.<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">can use other flag.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt;&gt; It's simply =
not allowed to free up resources during suspend since those can't be acquir=
ed again during resume.<o:p></o:p></p>
<p class=3D"MsoNormal">The in_suspend flag is set at the beginning of suspe=
nd and unset at the end of resume. It can&#8217;t filter the case you menti=
oned.<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
Why not? This is exactly what it should do.<br>
<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">Do you know the root cause of these cases hitting th=
e issue? So that we can get an exact point to warn the freeing up behavior.=
<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
Well the root cause are programming errors. See between suspending and resu=
ming you should not allocate nor free memory.<br>
<br>
Otherwise we can run into trouble. And this check here is one part of that,=
 we should probably add another warning during allocation of memory. But th=
is here is certainly correct.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Christian K=F6nig <a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a> <br>
<b>Sent:</b> Friday, February 3, 2023 9:20 PM<br>
<b>To:</b> Xiao, Jack <a href=3D"mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@am=
d.com&gt;</a>; Koenig, Christian
<a href=3D"mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt=
;</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander <a href=3D"mailto:Ale=
xander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Nope, that is not rel=
ated to any hw state.<br>
<br>
It's simply not allowed to free up resources during suspend since those can=
't be acquired again during resume.<br>
<br>
We had a couple of cases now where this was wrong. If you get a warning fro=
m that please fix the code which tried to free something during suspend ins=
tead.<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 03.02.23 um 07:04 schrieb Xiao, Jack:<o:p></o:p><=
/p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;&gt; It's simply illegal to free up memory durin=
g suspend.<o:p></o:p></p>
<p class=3D"MsoNormal">Why? In my understanding, the limit was caused by DM=
A shutdown.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jack<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian <a href=3D"mailto:Chr=
istian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a> <br>
<b>Sent:</b> Thursday, February 2, 2023 7:43 PM<br>
<b>To:</b> Xiao, Jack <a href=3D"mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@am=
d.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Deucher, Alexander
<a href=3D"mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&=
gt;</a><br>
<b>Subject:</b> AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA =
is unavailable<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Big NAK to this! This warning is not related in any =
way to the hw state.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">It's simply illegal to free up memory during suspend=
.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">Von:</span></b><span =
style=3D"color:black"> Xiao, Jack &lt;</span><a href=3D"mailto:Jack.Xiao@am=
d.com">Jack.Xiao@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Gesendet:</b> Donnerstag, 2. Februar 2023 10:54<br>
<b>An:</b> </span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D=
"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><sp=
an style=3D"color:black">&gt;; Deucher, Alexander
 &lt;</span><a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@=
amd.com</a><span style=3D"color:black">&gt;; Koenig, Christian &lt;</span><=
a href=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a><spa=
n style=3D"color:black">&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;</span><a href=3D"mailto:Jack.Xiao@amd.com">Jack.=
Xiao@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Betreff:</b> [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is u=
navailable</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Reduce waringings, on=
ly warn when DMA is unavailable.<br>
<br>
Signed-off-by: Jack Xiao &lt;<a href=3D"mailto:Jack.Xiao@amd.com">Jack.Xiao=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 2d237f3d3a2e..e3e3764ea697 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *=
gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*bo =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo=
.bdev)-&gt;in_suspend &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_=
TYPE_SDMA].status.hw);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(amdgpu_bo_reser=
ve(*bo, true) =3D=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
-- <br>
2.37.3<o:p></o:p></p>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MW3PR12MB44588B8BD8DD804DA96DBC65EFDE9MW3PR12MB4458namp_--
